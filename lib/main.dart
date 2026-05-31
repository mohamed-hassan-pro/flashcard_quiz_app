import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/datasources/flashcard_local_data_source.dart';
import 'data/repositories/flashcard_repository_impl.dart';
import 'presentation/blocs/flashcard_cubit.dart';
import 'presentation/pages/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final localDataSource = FlashcardLocalDataSourceImpl();
  final repository = FlashcardRepositoryImpl(localDataSource: localDataSource);

  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final FlashcardRepositoryImpl repository;

  const MyApp({Key? key, required this.repository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FlashcardCubit(repository: repository)..loadFlashcards(),
      child: MaterialApp(
        title: 'Flashcard Quiz App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
