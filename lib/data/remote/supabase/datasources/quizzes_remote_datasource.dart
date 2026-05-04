import '../supabase_service.dart';

class QuizzesRemoteDataSource {
  QuizzesRemoteDataSource(this._supabaseService);

  final SupabaseService _supabaseService;

  SupabaseService get supabaseService => _supabaseService;
}
