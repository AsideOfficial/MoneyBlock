// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bounceable/flutter_bounceable.dart';
// import 'package:get/get.dart';
// import 'package:money_cycle/constants.dart';
// import 'package:money_cycle/controller/game_controller.dart';
// import 'package:money_cycle/models/enums/game_action_type.dart';
// import 'package:syncfusion_flutter_core/theme.dart';
// import 'package:syncfusion_flutter_sliders/sliders.dart';

// class GameActionContainer extends StatefulWidget {
//   const GameActionContainer({super.key});

//   @override
//   State<GameActionContainer> createState() => _GameActionContainerState();
// }

// class _GameActionContainerState extends State<GameActionContainer> {
//   bool isLoan = true;
//   bool isCreditLoan = true;
//   double cash = 10000000;
//   double currentAmount = 7000000;

//   @override
//   Widget build(BuildContext context) {
//     return GetX<GameController>(
//       builder: (gameController) {
//         final model = gameController.currentActionTypeModel;
//         final specificActionModel = gameController.curretnSpecificActionModel;
//         return Stack(
//           children: [
//             //배경
//             Container(
//               decoration: BoxDecoration(
//                   gradient: gameController.currentBackgroundGradient),
//             ),

//             Padding(
//               padding: const EdgeInsets.only(top: 10, left: 50),
//               child: Column(
//                 children: [
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Row(
//                     children: [
//                       Bounceable(
//                         scaleFactor: 0.8,
//                         onTap: () => gameController.isActionChoicing = false,
//                         child: Image.asset(
//                           gameController.currentBackButtonAssetString,
//                           width: 46.0,
//                           height: 46.0,
//                         ),
//                       ),
//                       const SizedBox(width: 25),
//                       Text(
//                         gameController.currentActionType.actionData.title,
//                         style: Constants.titleTextStyle,
//                       )
//                     ],
//                   )
//                 ],
//               ),
//             ),

//             Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const SizedBox(
//                   height: 34,
//                 ),
//                 const Row(),
//                 SizedBox(
//                   width: 184,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Expanded(
//                             child: TabButton(
//                               title: '대출',
//                               isSelected: isLoan,
//                               onPressed: () {
//                                 setState(() => isLoan = true);
//                               },
//                             ),
//                           ),
//                           Expanded(
//                             child: TabButton(
//                               title: '상환',
//                               isSelected: !isLoan,
//                               onPressed: () {
//                                 setState(() => isLoan = false);
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 20),
//                       Text("보유현금 X (0.5 ~2)",
//                           style: Constants.defaultTextStyle),
//                       const SizedBox(height: 12),
//                       Text("대출게이지", style: Constants.defaultTextStyle),
//                       SizedBox(
//                         width: 140,
//                         child: SfSliderTheme(
//                           data: SfSliderThemeData(
//                             activeTrackHeight: 2,
//                             inactiveTrackHeight: 2,
//                             trackCornerRadius: 2,
//                             activeTrackColor: Colors.white.withOpacity(0.8),
//                             inactiveTrackColor: const Color(0xFF7062AD),
//                             overlayRadius: 10,
//                           ),
//                           child: SfSlider(
//                             value: currentAmount,
//                             min: cash * 0.5,
//                             max: cash * 2,
//                             stepSize: 100000,
//                             thumbIcon: Container(
//                               width: 18,
//                               height: 18,
//                               decoration: const ShapeDecoration(
//                                 gradient: LinearGradient(
//                                   begin: Alignment(0.00, 1.00),
//                                   end: Alignment(0, -1),
//                                   colors: [
//                                     Color(0xFF6322EE),
//                                     Color(0xFF8572FF)
//                                   ],
//                                 ),
//                                 shape: OvalBorder(
//                                   side:
//                                       BorderSide(width: 1, color: Colors.white),
//                                 ),
//                                 shadows: [
//                                   BoxShadow(
//                                     color: Color(0x3F000000),
//                                     blurRadius: 1,
//                                     offset: Offset(0, 1),
//                                     spreadRadius: 0,
//                                   )
//                                 ],
//                               ),
//                             ),
//                             onChanged: (value) {
//                               setState(() {
//                                 currentAmount = value;
//                               });

//                               debugPrint(value.toString());
//                             },
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       Text("대출금액", style: Constants.defaultTextStyle),
//                       const SizedBox(height: 10),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.only(right: 2),
//                                   child: Text("100,000,000",
//                                       style: Constants.defaultTextStyle),
//                                 ),
//                                 const SizedBox(height: 3.5),
//                                 Container(
//                                   // width: 80,
//                                   height: 2,
//                                   color: Colors.white,
//                                 )
//                               ],
//                             ),
//                           ),
//                           const SizedBox(width: 8),
//                           Text("원", style: Constants.defaultTextStyle),
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Bounceable(
//                   duration: const Duration(seconds: 1),
//                   onTap: () {
//                     Get.back();
//                   },
//                   child: SizedBox(
//                     width: 184,
//                     height: 50,
//                     child: Stack(
//                       alignment: Alignment.center,
//                       children: [
//                         Image.asset("assets/icons/button_long_yellow.png"),
//                         Text(
//                           "확인",
//                           style:
//                               Constants.defaultTextStyle.copyWith(fontSize: 20),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// class TabButton extends StatelessWidget {
//   final String title;
//   final bool isSelected;
//   final Function() onPressed;
//   const TabButton({
//     super.key,
//     required this.title,
//     required this.isSelected,
//     required this.onPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return CupertinoButton(
//       padding: EdgeInsets.zero,
//       onPressed: onPressed,
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 6),
//             child: Text(
//               title,
//               style: Constants.titleTextStyle,
//             ),
//           ),
//           if (isSelected)
//             Container(
//               // width: 80,
//               height: 2,
//               color: Colors.white,
//             )
//         ],
//       ),
//     );
//   }
// }
