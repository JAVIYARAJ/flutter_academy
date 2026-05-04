import '../supabase_service.dart';

class InterviewRemoteDataSource {
  InterviewRemoteDataSource(this._supabaseService);

  final SupabaseService _supabaseService;

  SupabaseService get supabaseService => _supabaseService;
}
