import '../supabase_service.dart';

class ConceptsRemoteDataSource {
  ConceptsRemoteDataSource(this._supabaseService);

  final SupabaseService _supabaseService;

  SupabaseService get supabaseService => _supabaseService;
}
