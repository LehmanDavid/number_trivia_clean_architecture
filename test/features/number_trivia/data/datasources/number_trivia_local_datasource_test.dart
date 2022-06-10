import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/data/datasources/number_trivia_local_datasource.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockSharedPreferences;
  late NumberTriviaLocalDatasourceImpl numberTriviaLocalDatasourceImpl;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    numberTriviaLocalDatasourceImpl = NumberTriviaLocalDatasourceImpl(
        sharedPreferences: mockSharedPreferences);
  });

  group('GetLastNumberTrivia', () {
    final tNumberTriviaModel =
        NumberTriviaModel.fromJSON(json.decode(fixture('cache_trivia.json')));
    test('should return NumberTrivia, when there is something in the cache',
        () async {
      when(() => mockSharedPreferences.getString(any()))
          .thenReturn(fixture('cache_trivia.json'));

      final result = await numberTriviaLocalDatasourceImpl.getLastNumberTrivia();

      verify(() => mockSharedPreferences.getString('CACHED_NUMBER_TRIVIA'));

      expect(result, equals(tNumberTriviaModel));
    });
  });

  group('CacheNumberTrivia', () {
    test('should return ', () {});
  });
}
