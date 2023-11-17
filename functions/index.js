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

exports.createRoom = onRequest((req, res) => {
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

        // 룸 아이디 생성
        const now = Date.now();
        const room_id = now.toString().slice(-6);

        // 방장 정보 입력
        owner.isOwner = true;
        owner.isReady = true;

        // 룸 데이터 생성 (방장이 첫번째)
        const room_data = {
            isPlaying: false,
            isFull: false,
            turnIndex: 0,
            savingRate,
            loanRate,
            investmentRate,
            player: {
                0: owner
            },
            theme: 'worker',
            type: 'solo',
            max: 4
        };

        // 데이터 저장
        db.ref('Room').child(room_id).set(room_data);

        return res.status(200).json({ roomId: room_id, data: room_data });
    } catch (error) {
        return res.status(500).json({ error: `Error processing request: ${error.message}` });
    }
});

exports.enterRoom = onRequest((req, res) => {
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

        const room_ref = db.ref('Room').child('roomId');

        // 입장 가능 확인
        const room_is_full = room_ref.child('isFull').val();
        if (room_is_full) {
            return res.status(400).json({ Error: 'room_is_full' });
        }

        // 유저 인덱스
        const user_idx = Object.keys(room_ref.child('player').val()).length;
        if (user_idx >= 3) {
            room_ref.child('isFull').set(true);
        }

        // 유저 정보 정보입력
        user.isOwner = false;
        user.isReady = false;

        // 유저 입장
        db.ref('Room').child(`${roomId}`).child('player').child(`${user_idx}`).set(user);
        const room_data = room_ref.val();

        return res.status(200).json({ roomId, data: room_data });
    } catch (error) {
        return res.status(500).json({ error: `Error processing request: ${error.message}` });
    }
});
