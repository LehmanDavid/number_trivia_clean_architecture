import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/number_trivia_bloc.dart';

class TriviaControlState extends StatefulWidget {
  const TriviaControlState({
    Key? key,
  }) : super(key: key);

  @override
  State<TriviaControlState> createState() => _TriviaControlStateState();
}

class _TriviaControlStateState extends State<TriviaControlState> {
  final controller = TextEditingController();
  late String inputStr;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(
            hintText: 'Input a number',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
          controller: controller,
          onChanged: (value) {
            inputStr = value;
          },
          onSubmitted: (_) {
            context
                .read<NumberTriviaBloc>()
                .add(GetConcreteNumberEvent(number: inputStr));
          },
        ),
        const SizedBox(
          height: 10.0,
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => triggerGetConcreteNumberEvent(context),
                style: ElevatedButton.styleFrom(primary: Colors.green[600]),
                child: const Text('Search'),
              ),
            ),
            const SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: triggerGetRandomNumberEvent,
                style: ElevatedButton.styleFrom(primary: Colors.grey[350]),
                child: const Text(
                  'Get random trivia',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  void triggerGetConcreteNumberEvent(BuildContext context) {
    controller.clear();
    context
        .read<NumberTriviaBloc>()
        .add(GetConcreteNumberEvent(number: inputStr));
  }

  void triggerGetRandomNumberEvent() {
    controller.clear();
    context.read<NumberTriviaBloc>().add(GetRandomNumberEvent());
  }
}

class MessageDisplay extends StatelessWidget {
  final String message;

  const MessageDisplay({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Center(
        child: SingleChildScrollView(
          child: Text(
            message,
            style: const TextStyle(fontSize: 25),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
