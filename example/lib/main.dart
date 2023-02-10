import 'package:card_actions/card_action_button.dart';
import 'package:card_actions/card_actions.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int counter = 0;

  void increment() {
    setState(() {
      counter++;
    });
  }

  void decrement() {
    setState(() {
      counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xfff7f8fd),
        body: Center(
          child: CardActions(
            buttonsCursor: SystemMouseCursors.click,
            backgroundColor: const Color(0xffff7270),
            axisDirection: CardActionAxis.bottom,
            borderRadius: 15,
            width: 600,
            height: 420,
            actions: [
              CardActionButton(
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 30,
                ),
                label: 'Increment',
                onPress: increment,
              ),
              CardActionButton(
                icon: const Icon(
                  Icons.restore_sharp,
                  color: Colors.white,
                  size: 30,
                ),
                label: 'Reset',
                onPress: () {
                  setState(() {
                    counter = 0;
                  });
                },
              ),
              CardActionButton(
                icon: const Icon(
                  Icons.remove,
                  color: Colors.white,
                  size: 30,
                ),
                label: 'Decrement',
                onPress: decrement,
              ),
            ],
            child: UserCard(counter: counter),
          ),
        ),
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  const UserCard({
    super.key,
    required this.counter,
  });
  final int counter;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      height: 420,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 51, 49, 49),
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(10, 10),
            blurRadius: 20,
            // spreadRadius: 20,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Counter Example',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 50,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              counter.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 60,
              ),
            )
          ],
        ),
      ),
    );
  }
}
