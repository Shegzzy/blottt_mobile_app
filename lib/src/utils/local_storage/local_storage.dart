import 'package:get_storage/get_storage.dart';

class BlottLocalStorage {
  static final BlottLocalStorage _instance = BlottLocalStorage._internal();

  factory BlottLocalStorage() {
    return _instance;
  }

  BlottLocalStorage._internal();

  final GetStorage _storage = GetStorage();

  Future<void> saveData<T>(String key, T value) async {
    await _storage.write(key, value);
  }

  T? readData<T>(String key) {
    return _storage.read(key);
  }

  Future<void> removeData(String key) async {
    await _storage.remove(key);
  }

  Future<void> clearAll() async {
    await _storage.erase();
  }

  bool hasData(String key) {
    return _storage.hasData(key);
  }
}
