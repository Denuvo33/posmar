import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posmar/bloc/bloc/parent_bloc.dart';
import 'package:posmar/firebase_options.dart';
import 'package:posmar/screen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Posmar',

      home: BlocProvider(
        create: (context) => ParentBloc(),
        child: HomeScreen(),
      ),
    );
  }
}
