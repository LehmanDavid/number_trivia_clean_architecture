import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'number_trivia_test_event.dart';
part 'number_trivia_test_state.dart';

class NumberTriviaTestBloc extends Bloc<NumberTriviaTestEvent, NumberTriviaTestState> {
  NumberTriviaTestBloc() : super(NumberTriviaTestInitial()) {
    on<NumberTriviaTestEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
