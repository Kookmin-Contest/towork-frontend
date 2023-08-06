import 'package:flutter/cupertino.dart';

double scaleWidth(BuildContext context) {
  const double standardWidth = 411.42857142857144;
  final diff = MediaQuery.of(context).size.width / standardWidth;
  print(diff);
  return diff;
}

double scaleHeight(BuildContext context) {
  const double standardHeight = 867.4285714285714;
  final diff = MediaQuery.of(context).size.height / standardHeight;
  print(diff);
  return diff;
}
