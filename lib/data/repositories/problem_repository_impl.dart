import '../../domain/repositories/problem_repository.dart';
import '../remote/supabase/datasources/problems_remote_datasource.dart';

class ProblemRepositoryImpl implements ProblemRepository {
  ProblemRepositoryImpl(this.remoteDataSource);

  final ProblemsRemoteDataSource remoteDataSource;
}
