import 'package:hive/hive.dart';
import 'package:nekidaem/data/models/card_model.dart';
import 'package:path_provider/path_provider.dart';

class CacheService {
  static late Box<String> tokenBox;
  static late Box<CardModel> dataBox;

  static Future<void> initHive() async {
    final documentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(documentDirectory.path);
    Hive.registerAdapter(CardModelAdapter());
    tokenBox = await Hive.openBox<String>('tokenBox');
    dataBox = await Hive.openBox<CardModel>('dataBox');
  }

  Future<void> saveToken(String jwtToken) async {
    if (!tokenBox.containsKey('key')) {
      tokenBox.put('key', jwtToken);
    }
  }

  Future<void> saveData(Iterable<CardModel> data) async {
    if (dataBox.isEmpty) {
      dataBox.addAll(data);
    }
  }

  Future<void> clearTokenBox() async {
    await tokenBox.clear();
  }
}
