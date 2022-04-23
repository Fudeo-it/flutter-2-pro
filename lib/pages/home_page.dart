import 'dart:math' as math;

import 'package:animated_app/pages/detail_page.dart';
import 'package:animated_app/pages/hero_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  bool _scrolling = false;
  bool _toggled = false;

  late final _rotationController = AnimationController(
    duration: const Duration(milliseconds: 125),
    vsync: this,
  );

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
        ),
        body: Stack(
          children: [
            _body(),
            ..._fabs(),
            _fab(),
          ],
        ),
      );

  Widget _body() => NotificationListener<ScrollNotification>(
        child: ListView.builder(
          itemBuilder: (context, index) => ListTile(
            title: Text('Title $index'),
            subtitle: Text('Subtitle $index'),
            onTap: () => Navigator.of(context).push(_createRoute()),
          ),
          itemCount: 30,
        ),
        onNotification: (notification) {
          if (notification is ScrollStartNotification) {
            setState(() {
              _scrolling = true;
            });
          } else if (notification is ScrollEndNotification) {
            setState(() {
              _scrolling = false;
            });
          }

          return false;
        },
      );

  Route _createRoute() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const DetailPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          final tween = Tween(begin: begin, end: end);
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: curve,
          );

          return SlideTransition(
            position: tween.animate(curvedAnimation),
            child: child,
          );
        });
  }

  Widget _fab() => AnimatedPositioned(
        duration: const Duration(milliseconds: 250),
        right: 24,
        bottom: _scrolling ? -100 : 24,
        child: FloatingActionButton(
          heroTag: 'fab',
          onPressed: () {
            setState(() {
              _toggled = !_toggled;

              if (_toggled) {
                _rotationController.forward();
              } else {
                _rotationController.reverse();
              }
            });
          },
          child: AnimatedBuilder(
            animation: _rotationController,
            builder: (context, child) => Transform.rotate(
              child: child,
              angle: _rotationController.value * math.pi / 4,
            ),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      );

  List<Widget> _fabs() => [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 250),
          right: 34,
          bottom: _scrolling
              ? -100
              : _toggled
                  ? 140
                  : 30,
          width: 40,
          height: 40,
          child: FloatingActionButton(
            heroTag: 'edit_fab',
            backgroundColor: Colors.red,
            child: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => const HeroPage(Colors.red, tag: 'edit_fab'),
            )),
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 250),
          right: 34,
          bottom: _scrolling
              ? -100
              : _toggled
                  ? 90
                  : 30,
          width: 40,
          height: 40,
          child: FloatingActionButton(
            heroTag: 'save_fab',
            backgroundColor: Colors.green,
            child: const Icon(
              Icons.save,
              color: Colors.white,
            ),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => const HeroPage(Colors.green, tag: 'save_fab'),
            )),
          ),
        ),
      ];
}
