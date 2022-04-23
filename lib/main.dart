import 'package:flutter/widgets.dart';
import 'package:news_app/app.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  await SentryFlutter.init(
    (options) {
      options.dsn = ''; //TODO
      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(const App()),
  );
}
