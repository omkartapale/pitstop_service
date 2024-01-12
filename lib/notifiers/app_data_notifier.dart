import 'package:flutter/foundation.dart';
import 'package:pitstop_service/model/app_data.dart';
import 'package:pitstop_service/services/app_data_service.dart';

/// A class that many Widgets can interact with to read [AppData], update on
/// user's request, or listen to vehicle's app data changes across widgets.
///
/// [ChangeNotifier] glue Data Services to Flutter Widgets. The [AppDataNotifier]
/// uses the [AppDataService] to store and retrieve vehicle's app data.
class AppDataNotifier with ChangeNotifier {
  /// Create [AppDataNotifier] ChangeNotifier instance with intializing
  /// [AppDataService].
  AppDataNotifier(this._storageService);

  // Make AppDataService a private variable so it is not used directly.
  //
  // This can be initialized locally, that way it'll be easier to create
  // instance of AppDataNotifier class without initializing or passing
  // AppDataStorage constructor. Initialize it as shown in comment below.
  final AppDataService _storageService;

  // Make AppDataService a private variable so it is not used directly and
  // intialize its instance.
  // final AppDataService _storageService = AppDataService();

  // Make AppData a private variable so it is not updated directly without
  // also persisting the changes with the AppDataService.
  late AppData _appData;

  // Allow Widgets to read the Vehicle's AppData.
  AppData get appData => _appData;

  /// Load the vehicle's app data from the [AppDataService]. It will load from
  /// a local file storage. The change notifier only knows it can load the
  /// app data from the service.
  Future<void> load() async {
    _appData = await _storageService.loadAppData();

    // Important! Inform listeners a change has occurred.
    notifyListeners();
  }

  /// Update and persist the AppData in a local file storage based on the
  /// user's or superuser's interaction.
  Future<void> save(AppData? newAppData) async {
    if (newAppData == null) return;

    // Do not perform any work if new and old AppData are identical
    if (newAppData == _appData) return;

    // Otherwise, store the new AppData in memory
    _appData = newAppData;

    // Important! Inform listeners a change has occurred.
    notifyListeners();

    // Persist the changes to a local storage using the AppData service.
    await _storageService.saveAppData(newAppData);
  }
}
