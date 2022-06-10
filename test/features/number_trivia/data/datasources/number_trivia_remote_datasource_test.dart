import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:number_trivia_clean_architecture/core/error/exceptions.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/data/models/number_trivia_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/data/datasources/number_trivia_remote_datasource.dart';

class MockHttpClient extends Mock implements http.Client {}

class FakeUri extends Fake implements Uri {}

void main() {
  late MockHttpClient mockClient;
  late NumberTriviaRemoteDatasourceImpl repositoryImpl;

  setUp(() {
    registerFallbackValue(FakeUri());
    mockClient = MockHttpClient();
    repositoryImpl = NumberTriviaRemoteDatasourceImpl(client: mockClient);
  });

  group('GetConcreteNumberTrivia', () {
    const tNumber = 1;
    final tNumberTriviaModel =
        NumberTriviaModel.fromJSON(jsonDecode(fixture('trivia_int.json')));
    test('should preform a GET request on a URL with number being the endpoint',
        () async {
      when(() => mockClient.get(
                any(),
              ))
          .thenAnswer(
              (_) async => http.Response(fixture('trivia_int.json'), 200));

      repositoryImpl.getConcreteNumberTrivia(tNumber);

      verify(() => mockClient
          .get(Uri.parse('http://numbersapi.com/$tNumber/trivia?json')));
    });

    test('should perform get operation when status code is 200', () async {
      when(() => mockClient.get(any())).thenAnswer(
          (_) async => http.Response(fixture('trivia_int.json'), 200));

      final response = await repositoryImpl.getConcreteNumberTrivia(tNumber);

      expect(response, tNumberTriviaModel);
    });

    test('should throw an exception when status code is 404', () async {
      when(() => mockClient.get(any())).thenAnswer(
          (_) async => http.Response(fixture('trivia_int.json'), 404));

      final response = repositoryImpl.getConcreteNumberTrivia(tNumber);

      expect(() => response, throwsA(const TypeMatcher<ServerException>()));
    });
  });

  group('GetRandomTrivia', () {
    final tNumberTriviaModel =
        NumberTriviaModel.fromJSON(jsonDecode(fixture('trivia_int.json')));

    test('should perform GET request with provided URL', () async {
      when(() => mockClient.get(any())).thenAnswer(
          (invocation) async => http.Response(fixture('trivia_int.json'), 200));

      repositoryImpl.getRandomNumberTrivia();

      verify(() => mockClient
          .get(Uri.parse('http://numbersapi.com/random/trivia?json')));
    });

    test('should perform GET operation when status code is 200', () async {
      when(() => mockClient.get(any())).thenAnswer(
          (_) async => http.Response(fixture('trivia_int.json'), 200));

      final response = await repositoryImpl.getRandomNumberTrivia();

      expect(response, tNumberTriviaModel);
    });

    test('should throw ServerException when status code is 404 or other',
        () async {
      when(() => mockClient.get(any())).thenAnswer(
          (_) async => http.Response(fixture('trivia_int.json'), 404));

      final response = repositoryImpl.getRandomNumberTrivia();

      expect(() => response, throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
