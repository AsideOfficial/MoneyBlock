// extension StringExtension on String {
//   String addCommasToNumber(int number) {
//     String strNumber = number.toString();
//     RegExp regExp = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
//     Iterable<Match> matches = regExp.allMatches(strNumber);
//     String result =
//         strNumber.replaceAllMapped(regExp, (Match match) => '${match[1]},');
//     return result;
//   }
// }

