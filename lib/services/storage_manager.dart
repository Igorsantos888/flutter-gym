import 'package:flutter/foundation.dart';
import 'storage_service.dart';
import 'local_storage_service.dart';
import 'mongodb_service.dart';

class StorageManager {
  static StorageService create() {
    if (kIsWeb) {
      // No Flutter Web: Armazena via Local Storage (localStorage do navegador)
      return LocalStorageService();
    } else {
      // No Aplicativo Mobile (Android/iOS): Armazena via MongoDB
      return MongoDbService();
    }
  }
}
