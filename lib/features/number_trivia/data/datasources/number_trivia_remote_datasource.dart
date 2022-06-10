import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDatasource {
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDatasourceImpl implements NumberTriviaRemoteDatasource {
  final http.Client client;
  NumberTriviaRemoteDatasourceImpl({required this.client});
  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) async {
    final response = await client
        .get(Uri.parse('http://numbersapi.com/$number/trivia?json'));

    if (response.statusCode == 200) {
      return NumberTriviaModel.fromJSON(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() async{
    final response = await client
        .get(Uri.parse('http://numbersapi.com/random/trivia?json'));

    if (response.statusCode == 200) {
      return NumberTriviaModel.fromJSON(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}
