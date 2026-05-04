import '../../domain/repositories/interview_repository.dart';
import '../remote/supabase/datasources/interview_remote_datasource.dart';

class InterviewRepositoryImpl implements InterviewRepository {
  InterviewRepositoryImpl(this.remoteDataSource);

  final InterviewRemoteDataSource remoteDataSource;
}
