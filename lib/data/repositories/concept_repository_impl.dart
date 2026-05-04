import '../../domain/repositories/concept_repository.dart';
import '../remote/supabase/datasources/concepts_remote_datasource.dart';

class ConceptRepositoryImpl implements ConceptRepository {
  ConceptRepositoryImpl(this.remoteDataSource);

  final ConceptsRemoteDataSource remoteDataSource;
}
