import 'package:flutter/material.dart';

class HeroPage extends StatelessWidget {
  final Color _color;
  final String tag;

  const HeroPage(this._color, {Key? key, required this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        body: Hero(
          tag: tag,
          child: Container(
            color: _color,
            child: Center(
              child: Text(
                tag,
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    ?.copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
      );
}
