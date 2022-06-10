import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tNumberTrivialModel = NumberTriviaModel(text: 'text', number: 1);

  test('should be sa subclass of NumberTrivia', () async {
    expect(tNumberTrivialModel, isA<NumberTrivia>());
  });

  group('FromJSON', () {
    test(
      'should return a valid model when the JSON number is an integer',
      () async {
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('trivia_int.json'));

        final result = NumberTriviaModel.fromJSON(jsonMap);

        expect(result, tNumberTrivialModel);
      },
    );
    test(
      'should return a valid model when the JSON number is double',
      () async {
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('trivia_double.json'));

        final result = NumberTriviaModel.fromJSON(jsonMap);

        expect(result, tNumberTrivialModel);
      },
    );
  });

  group('ToJSON', () {
    test('description', () async {
      final result = tNumberTrivialModel.toJSON();

      final expextedMap = {
        "text": "text",
        "number": 1,
      };
      expect(result, expextedMap);
    });
  });
}
