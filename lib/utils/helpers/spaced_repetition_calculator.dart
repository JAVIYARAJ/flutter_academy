import '../../domain/entities/enums.dart';

class SpacedRepetitionCalculator {
  const SpacedRepetitionCalculator._();

  static Duration nextInterval(ReviewRating rating) {
    switch (rating) {
      case ReviewRating.again:
        return const Duration(hours: 12);
      case ReviewRating.hard:
        return const Duration(days: 2);
      case ReviewRating.good:
        return const Duration(days: 4);
      case ReviewRating.easy:
        return const Duration(days: 7);
    }
  }
}
