/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const { onRequest } = require("firebase-functions/v2/https");
const { setGlobalOptions } = require("firebase-functions/v2");
const logger = require("firebase-functions/logger");
const admin = require("firebase-admin");
const auth = require("firebase-auth")

var serviceAccount = require("./moneycycle-5f900-firebase-adminsdk-um7sj-381cb394ed.json");

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
    databaseURL: 'https://moneycycle-5f900-default-rtdb.asia-southeast1.firebasedatabase.app/'
});

setGlobalOptions({ region: "asia-northeast3" });

db = admin.database();

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

exports.createCustomToken = onRequest(async (request, response) => {
    const user = request.body;

    const uid = `kakao:${user.uid}`;
    const updateParams = {
        email: user.email,
        displayName: user.displayName
    };

    try {
        await admin.auth().updateUser(uid, updateParams);
    } catch (e) {
        updateParams["uid"] = uid;
        await admin.auth().createUser(updateParams);
    }

    const token = await admin.auth().createCustomToken(uid);

    response.send(token);
});

exports.createRoom = onRequest(async (req, res) => {
    try {
        const request_data = req.body;
        // 데이터 파싱
        const { savingRate, loanRate, investmentRate, owner } = request_data;

        // 데이터 유효성 체크
        if (savingRate === undefined || typeof savingRate !== 'number') {
            return res.status(400).json({ ValueError: 'savingRate' });
        }
        if (loanRate === undefined || typeof loanRate !== 'number') {
            return res.status(400).json({ ValueError: 'loanRate' });
        }
        if (investmentRate === undefined || typeof investmentRate !== 'number') {
            return res.status(400).json({ ValueError: 'investmentRate' });
        }
        if (owner === undefined || typeof owner !== 'object') {
            return res.status(400).json({ ValueError: 'owner' });
        }
        if (owner.uid === undefined || typeof owner.uid !== 'string') {
            return res.status(400).json({ ValueError: 'uid' });
        }
        if (owner.characterIndex === undefined || typeof owner.characterIndex !== 'number') {
            return res.status(400).json({ ValueError: 'characterIndex' });
        }

        // 룸 아이디 생성
        const now = Date.now();
        const room_id = now.toString().slice(-6);

        // 방장 정보 입력
        owner.isReady = true;
        owner.cash = [0];
        owner.shortSaving = [0];
        owner.longSaving = [0];
        owner.creditLoan = [0];
        owner.mortgageLoan = [0];
        owner.expend = [0];
        owner.investment = [0];

        // 금리 및 뉴스 데이터 받아오기
        const newsRef = await db.ref('contentsData').child(4).child('categories').once('value');
        const newsData = newsRef.val();

        var savingRateInfo = [savingRate];
        var loanRateInfo = [loanRate];
        var investmentRateInfo = [investmentRate];
        for (news of newsData) {
            savingRateInfo.push(news.savingsInterest);
            loanRateInfo.push(news.loanInterest);
            investmentRateInfo.push(news.investmentVolatility);
        }

        // 룸 데이터 생성 (방장이 첫번째)
        const room_data = {
            isPlaying: false,
            isFull: false,
            isEnd: false,
            roundIndex: 0,
            turnIndex: 0,
            player: [owner],
            theme: 'worker',
            type: 'solo',
            max: 4,
            news: newsData,
            savingRateInfo: savingRateInfo,
            loanRateInfo: loanRateInfo,
            investmentRateInfo: investmentRateInfo
        };

        // 데이터 저장
        db.ref('Room').child(room_id).set(room_data);

        return res.status(200).json({ roomId: room_id, data: room_data });
    } catch (error) {
        return res.status(500).json({ error: `Error processing request: ${error.message}` });
    }
});

exports.enterRoom = onRequest(async (req, res) => {
    try {
        const request_data = req.body;
        // 데이터 파싱
        const { roomId, user } = request_data;

        // 데이터 유효성 검사
        if (roomId === undefined || typeof roomId !== 'string') {
            return res.status(400).json({ ValueError: 'roomId' });
        }
        if (user === undefined || typeof user !== 'object') {
            return res.status(400).json({ ValueError: 'user' });
        }
        if (user.characterIndex === undefined || typeof user.characterIndex !== 'number') {
            return res.status(400).json({ ValueError: 'characterIndex' });
        }
        if (user.uid === undefined || typeof user.uid !== 'string') {
            return res.status(400).json({ ValueError: 'uid' });
        }

        const room_ref = db.ref('Room').child(roomId);

        // 입장 가능 여부 확인
        const isPlaying = await room_ref.child('isPlaying').once('value');
        const roomIsPlaying = isPlaying.val();
        if (roomIsPlaying) {
            return res.status(400).json({ Error: 'room_is_playing' });
        }

        // 입장 정원 확인
        const isFull = await room_ref.child('isFull').once('value');
        const roomIsFull = isFull.val();
        if (roomIsFull) {
            return res.status(400).json({ Error: 'room_is_full' });
        }

        // 유저 인덱스
        const playerListRef = await room_ref.child('player').once('value');
        var playerList = playerListRef.val();

        if (playerList.length >= 3) {
            room_ref.child('isFull').set(true);
        }

        // 캐릭터 인덱스 증복 확인
        const availableCharacterIndex = [0, 1, 2, 3];
        const takenCharacterIndexes = playerList.map(player => player.characterIndex);
        if (takenCharacterIndexes.includes(user.characterIndex)) {
            user.characterIndex = availableCharacterIndex.find(index => !takenCharacterIndexes.includes(index));
        }

        // 유저 정보 정보입력
        user.isReady = false;
        user.cash = [0];
        user.shortSaving = [0];
        user.longSaving = [0];
        user.creditLoan = [0];
        user.mortgageLoan = [0];
        user.expend = [0];
        user.investment = [0];

        playerList.push(user);

        // 유저 입장
        db.ref('Room').child(roomId).child('player').set(playerList);
        const room_data = await room_ref.once('value');

        return res.status(200).json({ roomId: roomId, data: room_data.val() });
    } catch (error) {
        return res.status(500).json({ error: `Error processing request: ${error.message}` });
    }
});

exports.exitRoom = onRequest(async (req, res) => {
    try {
        const request_data = req.body;
        // 데이터 파싱
        const { roomId, uid } = request_data;

        // 데이터 유효성 체크
        if (roomId === undefined || typeof roomId !== 'string') {
            return res.status(400).json({ ValueError: 'roomId' });
        }
        if (uid === undefined || typeof uid !== 'string') {
            return res.status(400).json({ ValueError: 'uid' });
        }

        const room_ref = db.ref('Room').child(roomId);

        // 유저 퇴장
        const playerListRef = await room_ref.child('player').once('value');
        var playerList = playerListRef.val();
        const playerIndex = playerList.findIndex(player => player.uid === uid);

        playerList.splice(playerIndex, 1);

        db.ref('Room').child(roomId).child('player').set(playerList);

        // 최대 인원 수 확인
        if (playerList.length < 4) {
            room_ref.child('isFull').set(false);
        }

        // 인원 없을 시 방 삭제
        if (playerList.length === 0) {
            room_ref.remove();
        }

        const room_data = await room_ref.once('value');
        return res.status(200).json({ roomId: roomId, data: room_data.val() });
    } catch (error) {
        return res.status(500).json({ error: `Error processing request: ${error.message}` });
    }
});

exports.readyToggle = onRequest(async (req, res) => {
    try {
        const request_data = req.body;
        // 데이터 파싱
        const { roomId, uid } = request_data;

        // 데이터 유효성 체크
        if (roomId === undefined || typeof roomId !== 'string') {
            return res.status(400).json({ ValueError: 'roomId' });
        }
        if (uid === undefined || typeof uid !== 'string') {
            return res.status(400).json({ ValueError: 'uid' });
        }

        const roomRef = db.ref('Room').child(roomId);

        // 게임 시작 여부 확인
        const isPlaying = await roomRef.child('isPlaying').once('value');
        const roomIsPlaying = isPlaying.val();
        if (roomIsPlaying) {
            return res.status(400).json({ Error: 'room_is_playing' });
        }

        // 유저 인덱스 조회
        const playerListRef = await roomRef.child('player').once('value');
        const playerList = playerListRef.val();
        const playerIndex = playerList.findIndex(player => player.uid === uid);

        // 준비 상태 토글
        const userIsReady = await roomRef.child('player').child(`${playerIndex}`).child('isReady').once('value');
        if (userIsReady.val() === true) {
            roomRef.child('player').child(`${playerIndex}`).child('isReady').set(false);
        } else {
            roomRef.child('player').child(`${playerIndex}`).child('isReady').set(true);
        }

        const room_data = await roomRef.once('value');

        return res.status(200).json({ roomId: roomId, data: room_data.val() });
    } catch (error) {
        return res.status(500).json({ error: `Error processing request: ${error.message}` });
    }
});

exports.gameStart = onRequest(async (req, res) => {
    try {
        const request_data = req.body;
        // 데이터 파싱
        const { roomId } = request_data;

        // 데이터 유효성 체크
        if (roomId === undefined || typeof roomId !== 'string') {
            return res.status(400).json({ ValueError: 'roomId' });
        }

        const roomRef = db.ref('Room').child(roomId);

        // 준비 상태 확인
        const playerList = await roomRef.child('player').once('value');
        const allPlayersReady = playerList.val().every(player => player.isReady);
        if (!allPlayersReady) {
            return res.status(400).json({ Error: 'all_players_not_ready' });
        } 

        // 라운드 턴 세팅
        roomRef.child('turnIndex').set(0);
        roomRef.child('roundIndex').set(0);

        // 게임 시작
        roomRef.child('isPlaying').set(true);

        const room_data = await roomRef.once('value');
        return res.status(200).json({ roomId: roomId, data: room_data.val() });
    } catch (error) {
        return res.status(500).json({ error: `Error processing request: ${error.message}` });
    }
});

exports.updateRateSetting = onRequest(async(req, res) => {
    try {
        const request_data = req.body;
        // 데이터 파싱
        const { savingRate, loanRate, investmentRate, roomId } = request_data;

        // 데이터 유효성 체크
        if (savingRate === undefined || typeof savingRate !== 'number') {
            return res.status(400).json({ ValueError: 'savingRate' });
        }
        if (loanRate === undefined || typeof loanRate !== 'number') {
            return res.status(400).json({ ValueError: 'loanRate' });
        }
        if (investmentRate === undefined || typeof investmentRate !== 'number') {
            return res.status(400).json({ ValueError: 'investmentRate' });
        }
        if (roomId === undefined || typeof roomId !== 'string') {
            return res.status(400).json({ ValueError: 'roomId' });
        }

        roomRef = db.ref('Room').child(roomId);

        roomRef.child('savingRateInfo').child(0).set(savingRate);
        roomRef.child('loanRateInfo').child(0).set(loanRate);
        roomRef.child('investmentRateInfo').child(0).set(investmentRate);

        const room_data = await roomRef.once('value');

        return res.status(200).json({ roomId: roomId, data: room_data });
    } catch (error) {
        return res.status(500).json({ error: `Error processing request: ${error.message}` });
    }
});

exports.turnEnded = onRequest(async(req, res) => {
    try {
        const request_data = req.body;
        // 데이터 파싱
        const { roomId, playerIndex } = request_data;

        // 데이터 유효성 체크
        if (roomId === undefined || typeof roomId !== 'string') {
            return res.status(400).json({ ValueError: 'roomId' });
        }
        if (playerIndex === undefined || typeof playerIndex !== 'number') {
            return res.status(400).json({ ValueError: 'playerIndex' });
        }

        const roomRef = db.ref('Room').child(roomId);

        // 현재 라운드와 턴 확인
        const roundIndexRef = await roomRef.child('roundIndex').once('value');
        var roundIndex = roundIndexRef.val();
        const turnIndexRef = await roomRef.child('turnIndex').once('value');
        var turnIndex = turnIndexRef.val();

        // 플레이어 수 확인
        const playerList = await roomRef.child('player').once('value');
        const playerCount = Object.keys(playerList.val()).length;

        // 일반 턴
        turnIndex += 1;

        // 라운드 턴
        if (turnIndex >= playerCount*3) {
            turnIndex = 0;
            roundIndex += 1;
        }

        // 게임 종료
        if (roundIndex >= 3) {
            roomRef.child('isEnd').set(true);
        }

        roomRef.child('turnIndex').set(turnIndex);
        roomRef.child('roundIndex').set(roundIndex);

        const room_data = await roomRef.once('value');
        return res.status(200).json({ roomId: roomId, data: room_data });
    } catch (error) {
        return res.status(500).json({ error: `Error processing request: ${error.message}` });
    }
});

exports.userAction = onRequest(async (req, res) => {
    try {
        const request_data = req.body;
        // 데이터 파싱
        const { roomId, playerIndex, userActions } = request_data;

        // 데이터 유효성 체크
        if (roomId === undefined || typeof roomId !== 'string') {
            return res.status(400).json({ ValueError: 'roomId' });
        }
        if (playerIndex === undefined || typeof playerIndex !== 'number') {
            return res.status(400).json({ ValueError: 'playerIndex' });
        }
        if (userActions === undefined || !Array.isArray(userActions)) {
            return res.status(400).json({ ValueError: 'userActions should be an array' });
        }

        const roomRef = db.ref('Room').child(roomId);

        // 유저 액션 배열을 반복하여 추가
        for (const userAction of userActions) {
            if (!userAction || typeof userAction !== 'object' || !("type" in userAction) || typeof userAction.type !== 'string') {
                return res.status(400).json({ ValueError: 'Invalid userAction in the array' });
            }

            // 해당 타입 불러오기
            const typeRef = await roomRef.child('player').child(playerIndex).child(userAction.type).once('value');
            const type = typeRef.val();

            type.push(userAction);

            // 유저 액션 추가
            roomRef.child('player').child(`${playerIndex}`).child(userAction.type).set(type);
        }

        const room_data = await roomRef.once('value');
        return res.status(200).json({ roomId: roomId, data: room_data });
    } catch (error) {
        return res.status(500).json({ error: `Error processing request: ${error.message}` });
    }
});

exports.startVacation = onRequest(async (req, res) => {
    try {
        const request_data = req.body;
        // 데이터 파싱
        const { roomId, playerIndex } = request_data;

        // 데이터 유효성 체크
        if (roomId === undefined || typeof roomId !== 'string') {
            return res.status(400).json({ ValueError: 'roomId' });
        }
        if (playerIndex === undefined || typeof playerIndex !== 'number') {
            return res.status(400).json({ ValueError: 'playerIndex' });
        }

        const roomRef = db.ref('Room').child(roomId);
        const userRef = db.ref('Room').child(roomId).child('player').child(`${playerIndex}`);

        // 유저 휴가 상태로 변경
        userRef.child('isVacation').set(true);

        // 라운드 확인(마지막 라운드만 1회 휴가)
        const roundIndexRef = await roomRef.child('roundIndex').once('value');
        var roundIndex = roundIndexRef.val();
        if (roundIndex === 3) {
            userRef.child('vacationCount').set(1);
        } else {
            userRef.child('vacationCount').set(2);
        }

        const room_data = await roomRef.once('value');
        return res.status(200).json({ roomId: roomId, data: room_data });
    } catch (error) {
        return res.status(500).json({ error: `Error processing request: ${error.message}` });
    }
});

exports.useVacation = onRequest(async (req, res) => {
    try {
        const request_data = req.body;
        // 데이터 파싱
        const { roomId, playerIndex } = request_data;

        // 데이터 유효성 체크
        if (roomId === undefined || typeof roomId !== 'string') {
            return res.status(400).json({ ValueError: 'roomId' });
        }
        if (playerIndex === undefined || typeof playerIndex !== 'number') {
            return res.status(400).json({ ValueError: 'playerIndex' });
        }

        const userRef = db.ref('Room').child(roomId).child('player').child(`${playerIndex}`);

        // 유저 휴가 횟수 차감
        const vacationCountRef = await userRef.child('vacationCount').once('value');
        var vacationCount = vacationCountRef.val();
        vacationCount -= 1;
        userRef.child('vacationCount').set(vacationCount);

        // 휴가 종료
        if (vacationCount === 0) {
            userRef.child('isVacation').set(false);
        }

        const room_data = await db.ref('Room').child(roomId).once('value');
        return res.status(200).json({ roomId: roomId, data: room_data });
    } catch (error) {
        return res.status(500).json({ error: `Error processing request: ${error.message}` });
    }
});