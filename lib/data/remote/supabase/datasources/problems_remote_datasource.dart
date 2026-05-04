import '../supabase_service.dart';

class ProblemsRemoteDataSource {
  ProblemsRemoteDataSource(this._supabaseService);

  final SupabaseService _supabaseService;

  SupabaseService get supabaseService => _supabaseService;
}
