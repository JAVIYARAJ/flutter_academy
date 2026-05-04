import '../../domain/repositories/progress_repository.dart';
import '../remote/supabase/datasources/progress_remote_datasource.dart';

class ProgressRepositoryImpl implements ProgressRepository {
  ProgressRepositoryImpl(this.remoteDataSource);

  final ProgressRemoteDataSource remoteDataSource;
}
