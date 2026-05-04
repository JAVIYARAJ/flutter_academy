import 'package:supabase/supabase.dart';

import '../logger.dart';
import 'app_environment.dart';
import 'supabase_client.dart';

class SupabaseBootstrap {
  const SupabaseBootstrap._();

  static Future<void> initialize() async {
    if (!AppEnvironment.hasSupabaseConfig) {
      AppLogger.warning(
        'Supabase is not configured. Pass SUPABASE_URL and SUPABASE_ANON_KEY with --dart-define.',
      );
      return;
    }

    SupabaseClientProvider.initialize(
      SupabaseClient(
        AppEnvironment.supabaseUrl,
        AppEnvironment.supabaseAnonKey,
      ),
    );
  }
}
