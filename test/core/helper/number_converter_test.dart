

import 'package:number_trivia_clean_architecture/core/helper/number_converter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';

void main() {
  late NumberConverter converter;

  setUp(() {
    converter = NumberConverter();
  });

  test('should convert number to int', () async{
    const number = '123';

    final result = converter.convertNumber(number);

    expect(result, const Right(123));
  });


  test('should throw exception if number is the type String', () {
    const str = 'acb';

    final result = converter.convertNumber(str);

    expect(result, Left(InvalidInputFailure()));
  });


  test('should throw exception if number is negative', () {
    const str = '-123';

    final result = converter.convertNumber(str);

    expect(result, Left(InvalidInputFailure()));
  });
}
