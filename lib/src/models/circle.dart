import 'dart:math' as math;

import 'package:geometry/src/behaviors/area.dart';
import 'package:geometry/src/behaviors/perimeter.dart';

class Circle with Perimeter, Area {
  final double radius;

  Circle(this.radius);

  @override
  double get area => math.pi * radius * radius;

  @override
  double get perimeter => math.pi * 2 * radius;
}
