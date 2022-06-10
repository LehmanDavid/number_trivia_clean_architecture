import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/helper/number_converter.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/usecases/get_concrete_number_trivia.dart';
import '../../domain/usecases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia concrete;
  final GetRandomNumberTrivia random;
  final NumberConverter numberConverter;
  NumberTriviaBloc(
      {required this.concrete,
      required this.random,
      required this.numberConverter})
      : super(EmptyState()) {
    on<GetConcreteNumberEvent>((event, emit) async {
      final inputEither = numberConverter.convertNumber(event.number);

      await inputEither.fold(
          (failure) async => emit(ErrorState(
              message:
                  'Couldnt perform the operation GetConcreteNumberTrivia')),
          (integer) async {
        emit(LoadingState());
        final failureOrTrivia = await concrete(Params(number: integer));
        await failureOrTrivia.fold(
          (failure) async => 'Something went wrong...',
          (numberTrivia) async {
            emit(
              LoadedState(numberTrivia: numberTrivia),
            );
          },
        );
      });
    });

    on<GetRandomNumberEvent>(
      ((event, emit) async {
        emit(LoadingState());
        final failureOrTrivia = await random(NoParams());

        await failureOrTrivia.fold(
          (failure) async => 'Ooops, something went wrong',
          (trivia) async => emit(
            LoadedState(numberTrivia: trivia),
          ),
        );
      }),
    );
  }
}
