import 'package:supabase/supabase.dart';

class SupabaseClientProvider {
  const SupabaseClientProvider._();

  static SupabaseClient? _client;

  static void initialize(SupabaseClient client) {
    _client = client;
  }

  static SupabaseClient? get client => _client;
}
