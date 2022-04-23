import 'dart:math' as math;

import 'package:geometry/src/behaviors/area.dart';

import '../behaviors/perimeter.dart';

class Triangle with Perimeter, Area {
  final double a;
  final double b;
  final double c;

  Triangle({
    required this.a,
    required this.b,
    required this.c,
  });

  factory Triangle.equilateral(double side) => Triangle(
        a: side,
        b: side,
        c: side,
      );

  factory Triangle.isosceles(double seq, double base) => Triangle(
        a: seq,
        b: seq,
        c: base,
      );

  @override
  double get area =>
      math.sqrt((a + b + c) * (-a + b + c) * (a - b + c) * (a + b - c)) / 4;

  @override
  double get perimeter => a + b + c;
}
