import '../supabase_service.dart';

class ProgressRemoteDataSource {
  ProgressRemoteDataSource(this._supabaseService);

  final SupabaseService _supabaseService;

  SupabaseService get supabaseService => _supabaseService;
}
