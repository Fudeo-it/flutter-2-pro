import 'package:geometry/src/behaviors/area.dart';
import 'package:geometry/src/behaviors/perimeter.dart';

class Square with Perimeter, Area {
  final double side;

  Square(this.side);

  @override
  double get area => side * side;

  @override
  double get perimeter => side * 4;
}
