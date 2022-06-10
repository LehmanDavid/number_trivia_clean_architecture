// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:number_trivia_clean_architecture/core/platform/network_info.dart';
// import 'package:number_trivia_clean_architecture/features/number_trivia/data/datasources/number_trivia_remote_datasource.dart';
// import 'package:number_trivia_clean_architecture/features/number_trivia/data/datasources/numner_trivia_local_datasource.dart';
// import 'package:number_trivia_clean_architecture/features/number_trivia/data/models/number_trivia_model.dart';
// import 'package:number_trivia_clean_architecture/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
// import 'package:number_trivia_clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';

// import '../../domain/usecases/get_concrete_number_trivia_test.dart';

// class MockNumberTriviaRemoteDatasource extends Mock
//     implements NumberTriviaRemoteDatasource {}

// class MockNumberTriviaLocalDatasource extends Mock
//     implements NumberTriviaLocalDatasource {}

// class MockNetworkInfo extends Mock implements NetworkInfo {}

// void main() {
//   late NumberTriviaRepositoryImpl repository;
//   late MockNumberTriviaRemoteDatasource mockRemoteDataSource;
//   late MockNumberTriviaLocalDatasource mockLocalDataSource;
//   late MockNetworkInfo mockNetworkInfo;
//   setUp(() {
//     mockLocalDataSource = MockNumberTriviaLocalDatasource();
//     mockRemoteDataSource = MockNumberTriviaRemoteDatasource();
//     mockNetworkInfo = MockNetworkInfo();
//     repository = NumberTriviaRepositoryImpl(
//       remoteDatasource: mockRemoteDataSource,
//       localDatasource: mockLocalDataSource,
//       networkInfo: mockNetworkInfo,
//     );
//   });

//   group('getConcreteNumberTrivia', () {
//     final tNumber = 1;
//     final tNumberTriviaModel = NumberTriviaModel(text: 'text', number: tNumber);
//     final NumberTrivia tNumberTrivia = tNumberTriviaModel;
//     test(
//       'should check if the device is online',
//       () async {
//         //arrange
//         when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
//         // act
//         repository.getConcreteNumberTrivia(tNumber);
//         // assert
//         verify(() => mockNetworkInfo.isConnected);
//       },
//     );
//   });
// }
