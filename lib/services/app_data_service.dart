import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
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
    // Data File Naming Convetion:
    //
    // Store AppData in a file storage with numeric name (Data in YMD format).
    // This will encourage to avoid data loss in migration of app data from
    // older version to newer one as the original file will not be overwritten
    // automatically.
    //
    // Consider assigning ".pad" (Pitstop Application Data file) extension to
    // such data files.

    // Get local path for AppData file storage
    final path = await _localPath;

    // Debug print data file path
    debugPrint('AppData file: $path/20240124.pad');

    return File('$path/20240124.pad');
  }

  /// Loads the Vehicle's app data from storage.
  ///
  /// Tries to read and deserialize the contents from local app data file to
  /// JSON and returns the [AppData] instance from storage file.
  ///
  /// If file doesn't exist at the storage location then returns
  /// [jsonDemoAppData] demo instance.
  Future<AppData> loadAppData() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      // Debug print file found and read
      debugPrint('File found and read');
      log(contents);

      return AppData.fromJson(json.decode(contents));
    } catch (e) {
      // Debug print error or exception thrown while accessing file
      debugPrint('Error/Exception: AppData file not found!\n'
          '${e.toString()}\n'
          'Loading dummy data into the application.');
      // rethrow;

      // If encountering an error, return demo data
      return jsonDemoAppData;
    }
  }

  /// Persists the Vehicle's app data to storage.
  ///
  /// Writes a serialized JSON string representing [AppData] instance to a file.
  Future<File> saveAppData(AppData data) async {
    final file = await _localFile;

    // Debug print data writing to file
    debugPrint('Writing data to file');
    log(json.encode(data.toJson()));

    // Write the file
    return file.writeAsString(json.encode(data.toJson()));
  }
}
