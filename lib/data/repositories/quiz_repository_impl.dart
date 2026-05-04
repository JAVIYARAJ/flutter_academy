import '../../domain/repositories/quiz_repository.dart';
import '../remote/supabase/datasources/quizzes_remote_datasource.dart';

class QuizRepositoryImpl implements QuizRepository {
  QuizRepositoryImpl(this.remoteDataSource);

  final QuizzesRemoteDataSource remoteDataSource;
}
