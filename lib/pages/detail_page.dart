import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Detail'),
        ),
        body: Center(
          child: Text(
            'Detailed Page',
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
      );
}
