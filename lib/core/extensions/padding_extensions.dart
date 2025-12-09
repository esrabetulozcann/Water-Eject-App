import 'package:flutter/material.dart';

extension PaddingExtension on Widget {
  Widget allPadding(double value) {
    return Padding(padding: EdgeInsets.all(value), child: this);
  }

  Widget symmetricPadding({double vertical = 0, double horizontal = 0}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
      child: this,
    );
  }

  Widget onlyPadding({
    double bottom = 0,
    double left = 0,
    double right = 0,
    double top = 0,
  }) {
    return Builder(
      builder: (context) {
        final isRTL = Directionality.of(context) == TextDirection.rtl;
        return Padding(
          padding: EdgeInsets.only(
            bottom: bottom,
            left: isRTL ? right : left, // RTL'de left ve right yer değiştirir
            right: isRTL ? left : right, // RTL'de left ve right yer değiştirir
            top: top,
          ),
          child: this,
        );
      },
    );
  }
}
