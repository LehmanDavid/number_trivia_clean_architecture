import 'package:dartz/dartz.dart';

import '../error/failures.dart';

class NumberConverter {
  Either<Failure, int> convertNumber(String number) {
    final intNumber = int.parse(number);
    try {
      if (intNumber < 0) throw const FormatException();
      return Right(intNumber);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {
  @override
  List<Object?> get props => [];
}
