import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pitstop_service/model/app_data.dart';

/// A service that stores and retrieves app data.
class AppDataService {
  /// Get local path to store files.
  ///
  /// Checks if external storage is available and returns path for external
  /// storage, else returns path for internal applications documents directory.
  Future<String> get _localPath async {
    // Get external storage directory
    // /storage/emulated/0/Android/data/in.co.tech4geek.pitstop_service/files
    var directory = await getExternalStorageDirectory();

    // Check if external storage not available. If not available use
    // internal applications directory
    // /data/user/0/in.co.tech4geek.pitstop_service/app_flutter
    directory ??= await getApplicationDocumentsDirectory();

    return directory.path;
  }

  /// Get the local file to store or retrieve data.
  ///
  /// Returns the [File] reference to a file on the file system.
  Future<File> get _localFile async {
    final path = await _localPath;

    return File('$path/counter.txt');
  }

  /// Loads the Vehicle's app data from storage.
  ///
  /// Returns the [AppData] instance from storage file. If file doesn't exist
  /// at storage location then returns [jsonDemoAppData] demo instance.
  Future<AppData> loadAppData() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return AppData.fromJson(json.decode(contents));
    } catch (e) {
      // print(e);
      // rethrow;
      // If encountering an error, return demo data
      return jsonDemoAppData;
    }
  }

  /// Persists the Vehicle's app data to storage.
  ///
  /// Writes a JSON string representing [AppData] instance to a file.
  Future<File> saveAppData(AppData data) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString(json.encode(data.toJson()));
  }
}
