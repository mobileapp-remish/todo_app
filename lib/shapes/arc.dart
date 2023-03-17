import 'package:flutter/material.dart';
import 'package:todo_app/shapes/shape_of_view_null_safe.dart';

enum ArcPosition { Bottom, Top, Left, Right }

class ArcShape extends Shape {
  final ArcPosition position;
  final double height;

  ArcShape({
    this.position = ArcPosition.Bottom,
    this.height = 10,
  });

  @override
  Path build({Rect? rect, double? scale}) {
    return generatePath(rect!, scale);
  }

  Path generatePath(Rect rect, double? scale) {
    final size = rect.size;
    switch (position) {
      case ArcPosition.Top:
        return Path()
          ..moveTo(0.0, height)
          ..quadraticBezierTo(size.width / 4, 0.0, size.width / 2, 0.0)
          ..quadraticBezierTo(size.width * 3 / 4, 0.0, size.width, height)
          ..lineTo(size.width, size.height)
          ..lineTo(0.0, size.height)
          // ..fillType = PathFillType.evenOdd
          ..close();
      case ArcPosition.Bottom:
        return Path()
          ..lineTo(0.0, size.height - height)
          ..quadraticBezierTo(
              size.width / 4, size.height, size.width / 2, size.height)
          ..quadraticBezierTo(
              size.width * 3 / 4, size.height, size.width, size.height - height)
          ..lineTo(size.width, 0.0)
          ..close();

      case ArcPosition.Left:
        return Path()
          ..moveTo(height, 0.0)
          ..quadraticBezierTo(0.0, size.height / 4, 0.0, size.height / 2)
          ..quadraticBezierTo(0.0, size.height * 3 / 4, height, size.height)
          ..lineTo(size.width, size.height)
          ..lineTo(size.width, 0.0)
          ..close();
      default: //right
        return Path()
          ..moveTo(size.width - height, 0.0)
          ..quadraticBezierTo(
              size.width, size.height / 4, size.width, size.height / 2)
          ..quadraticBezierTo(
              size.width, size.height * 3 / 4, size.width - height, size.height)
          ..lineTo(0.0, size.height)
          ..lineTo(0.0, 0.0)
          ..close();
    }
  }
}
