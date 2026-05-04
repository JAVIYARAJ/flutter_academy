import 'package:supabase/supabase.dart';

import '../../../core/config/supabase_client.dart';

class SupabaseService {
  const SupabaseService();

  SupabaseClient? get client => SupabaseClientProvider.client;
}
