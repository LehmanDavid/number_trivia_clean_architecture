import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/error/exceptions.dart';

import '../../../../injection_container.dart';
import '../bloc/number_trivia_bloc.dart';
import '../widgets/trivia_control_state.dart';
import '../widgets/trivia_display.dart';

class NumberTriviaPage extends StatelessWidget {
  NumberTriviaPage({Key? key}) : super(key: key);
  var controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Trivia'),
        backgroundColor: Colors.green[800],
      ),
      body: SingleChildScrollView(child: buildBody(context)),
    );
  }

  BlocProvider<NumberTriviaBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<NumberTriviaBloc>(),
      child: Builder(
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                  builder: (context, state) {
                    if (state is EmptyState) {
                      return const MessageDisplay(
                        message: 'Start Searching',
                      );
                    }
                    if (state is LoadingState) {
                      return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3,
                          child:
                              const Center(child: CircularProgressIndicator()));
                    }
                    if (state is LoadedState) {
                      return TriviaDisplay(
                        numberTrivia: state.numberTrivia,
                      );
                    }
                    if (state is ErrorState) {
                      return MessageDisplay(message: state.message);
                    }
                    throw ServerException();
                  },
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const TriviaControlState(),
              ],
            ),
          );
        },
      ),
    );
  }
}
