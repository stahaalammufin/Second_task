import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/screens/total_participation/bloc/participation_bloc.dart';
import 'package:task/screens/total_participation/view/participation_screen.dart';

void main() {
  runApp(BlocProvider(
    create: (_) => ParticipationBloc()
      ..add(
        const GetParticipationHistory(),
      ),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
      home:  ParticipationScren(),
    );
  }
}
