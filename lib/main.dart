import 'package:flutter/widgets.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'app.dart';
import 'core/config/app_bloc_observer.dart';
import 'core/config/supabase_bootstrap.dart';

Future<void> main() async {
  usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  AppBlocObserver.register();
  await SupabaseBootstrap.initialize();
  runApp(const FlutterLearningApp());
}
