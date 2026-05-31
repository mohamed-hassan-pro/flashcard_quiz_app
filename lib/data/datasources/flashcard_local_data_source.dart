import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/flashcard_model.dart';

abstract class FlashcardLocalDataSource {
  Future<List<FlashcardModel>> getFlashcards();
  Future<void> addFlashcard(FlashcardModel flashcard);
  Future<void> updateFlashcard(FlashcardModel flashcard);
  Future<void> deleteFlashcard(int id);
}

class FlashcardLocalDataSourceImpl implements FlashcardLocalDataSource {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('flashcards.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE flashcards(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        question TEXT NOT NULL,
        answer TEXT NOT NULL
      )
    ''');
    // Insert some initial data
    await db.insert('flashcards', {'question': 'What is Flutter?', 'answer': 'An open-source UI software development kit created by Google.'});
    await db.insert('flashcards', {'question': 'What is Dart?', 'answer': 'A client-optimized language for fast apps on any platform.'});
  }

  @override
  Future<List<FlashcardModel>> getFlashcards() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('flashcards');
    return List.generate(maps.length, (i) {
      return FlashcardModel.fromMap(maps[i]);
    });
  }

  @override
  Future<void> addFlashcard(FlashcardModel flashcard) async {
    final db = await database;
    await db.insert('flashcards', flashcard.toMap());
  }

  @override
  Future<void> updateFlashcard(FlashcardModel flashcard) async {
    final db = await database;
    await db.update(
      'flashcards',
      flashcard.toMap(),
      where: 'id = ?',
      whereArgs: [flashcard.id],
    );
  }

  @override
  Future<void> deleteFlashcard(int id) async {
    final db = await database;
    await db.delete(
      'flashcards',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
