import 'package:flutter/foundation.dart';
import 'package:pitstop_service/model/app_data.dart';
import 'package:pitstop_service/model/emergency_contact.dart';
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

  /// Load the vehicle's app data from local file storage.
  ///
  /// It will read and parse [AppData] from a local file storage with the help
  /// of [AppDataService]. Inform listeners a change has occurred. The change
  /// notifier only knows it can load the app data from the service.
  Future<void> load() async {
    _appData = await _storageService.loadAppData();

    // Important! Inform listeners a change has occurred.
    notifyListeners();
  }

  /// Save the Emergency Contacts
  ///
  /// Update and persist the [EmergencyContact] in a local file storage.
  ///
  /// Check if either of [primary] and [secondary] contact provided or both
  /// provided while calling this method, else return.
  ///
  /// If primary or secondary [EmergencyContact] is provided then create a new
  /// instance of [AppData] update and [save] this instance to local file storage.
  Future<void> saveEmergencyContact(
      {EmergencyContact? primary, EmergencyContact? secondary}) async {
    // Check if either of primary and secondary contact supplied
    // or both supplied to update else return.
    if (primary == null && secondary == null) return;

    // Prepare new AppData instance with updated information
    AppData newAppData = AppData(
      vehicleSpec: _appData.vehicleSpec,
      serviceHistory: _appData.serviceHistory,
      // Check if primary is not available. If not use existing primary contact
      primaryContact: primary ?? _appData.primaryContact,
      // Check if secondary is not available. If not use existing secondary contact
      secondaryContact: secondary ?? _appData.secondaryContact,
      version: _appData.version,
    );

    // Persist the changes to a local file storage.
    await save(newAppData);
  }

  /// Save the [AppData] with [newAppData] in a local file storage.
  ///
  /// Validate old object and new object are not identical, then store new
  /// [AppData] in memory, [notifyListeners] a change has occured and save in
  /// local file storage with the help of [AppDataService].
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
