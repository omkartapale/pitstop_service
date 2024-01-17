import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pitstop_service/model/service_log.dart';
import 'package:pitstop_service/notifiers/app_data_notifier.dart';
import 'package:provider/provider.dart';

/// Creates a Service log information Form
///
/// Constructor receives optional param [serviceLogItem] of type [ServiceLog].
///
/// If [serviceLogItem] is provided ServiceLogForm creates a form to update
/// service log with populated information of provided service log. Else
/// creates an empty form to add new service log.
class ServiceLogForm extends StatefulWidget {
  /// Creates a form for service log.
  ///
  /// The [serviceLogItem] argument is optional.
  const ServiceLogForm({super.key, this.serviceLogItem, this.index});

  /// Service log to load information about.
  final ServiceLog? serviceLogItem;

  /// Service log index number
  final int? index;

  @override
  State<ServiceLogForm> createState() => _ServiceLogFormState();
}

/// State associated with a [VehicleForm] widget.
///
/// Boolean [_isNewVehicle] used to decide form should be provided to create
/// a new vehicle or update existing vehicle.
class _ServiceLogFormState extends State<ServiceLogForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// Boolean states that the form should be used to Create or Update vehicle.
  bool _isUpdate = false;

  /// Text editing controllers states
  late DateTime _lastServiceDate, _dueServiceDate;
  final TextEditingController _lastServiceDateController =
      TextEditingController();
  final TextEditingController _lastOdometerController = TextEditingController();
  final TextEditingController _worknotesController = TextEditingController();
  final TextEditingController _dueServiceDateController =
      TextEditingController();
  final TextEditingController _dueOdometerController = TextEditingController();
  final TextEditingController _suggestionsController = TextEditingController();

  @override
  void initState() {
    // Check if service log is provided while loading and not null
    // and set [_isUpdate] state accordingly.
    if (widget.serviceLogItem != null) {
      setState(() {
        _isUpdate = true;
      });
    }

    // Populate controllers and state vars with vehicle service details
    // or prepare for new service log
    _lastServiceDate =
        (_isUpdate) ? widget.serviceLogItem!.lastServiceDate : DateTime.now();
    _lastServiceDateController.text =
        DateFormat("dd MMM ''yy").format(_lastServiceDate);
    _lastOdometerController.text =
        (_isUpdate) ? widget.serviceLogItem!.lastOdometer.toString() : '';
    _worknotesController.text =
        (_isUpdate) ? widget.serviceLogItem!.worknotes.toString() : '';
    _dueServiceDate = (_isUpdate)
        ? widget.serviceLogItem!.dueServiceDate
        : DateTime.now().add(const Duration(days: 60));
    _dueServiceDateController.text =
        DateFormat("dd MMM ''yy").format(_dueServiceDate);
    _dueOdometerController.text =
        (_isUpdate) ? widget.serviceLogItem!.dueOdometer.toString() : '';
    _suggestionsController.text =
        (_isUpdate) ? widget.serviceLogItem!.suggestions.toString() : '';

    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    _lastServiceDateController.dispose();
    _lastOdometerController.dispose();
    _worknotesController.dispose();
    _dueServiceDateController.dispose();
    _dueOdometerController.dispose();
    _suggestionsController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _lastServiceDateController,
              readOnly: true,
              decoration: const InputDecoration(
                isDense: true,
                filled: true,
                label: Text('Service Date *'),
                hintText: 'Select service date',
                suffixIcon: Icon(Icons.today),
              ),
              onTap: () => _selectLastServiceDate(context),
            ),
            const SizedBox(height: 8.0),
            TextFormField(
              controller: _lastOdometerController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                isDense: true,
                filled: true,
                label: Text('Service Odometer Reading *'),
                hintText: 'Enter odometer km for current service',
              ),
              validator: (String? value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter odometer reading for current service.';
                } else if (int.tryParse(value) == null) {
                  return 'Please enter a valid odometer reading.';
                } else if (int.parse(value) < 0 || int.parse(value) > 999999) {
                  return 'Please enter a reading between 0 and 999999';
                }
                return null;
              },
            ),
            const SizedBox(height: 8.0),
            TextFormField(
              controller: _worknotesController,
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                isDense: true,
                filled: true,
                label: Text('Worknotes *'),
                hintText: 'Enter worknotes separated by commas',
              ),
            ),
            const SizedBox(height: 8.0),
            TextFormField(
              controller: _dueServiceDateController,
              readOnly: true,
              decoration: const InputDecoration(
                isDense: true,
                filled: true,
                label: Text('Next Service Due Date *'),
                hintText: 'Select next service due date',
                suffixIcon: Icon(Icons.today),
              ),
              onTap: () => _selectServiceDueDate(context),
            ),
            const SizedBox(height: 8.0),
            TextFormField(
              controller: _dueOdometerController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                isDense: true,
                filled: true,
                label: Text('Next Service Odometer Reading *'),
                hintText: 'Enter odometer km for next service',
              ),
              validator: (String? value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter odometer reading for next service.';
                } else if (int.tryParse(value) == null) {
                  return 'Please enter a valid odometer reading.';
                } else if (int.parse(value) < 0 || int.parse(value) > 999999) {
                  return 'Please enter a reading between 0 and 999999';
                }
                return null;
              },
            ),
            const SizedBox(height: 8.0),
            TextFormField(
              controller: _suggestionsController,
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                isDense: true,
                filled: true,
                label: Text('Suggestions *'),
                hintText: 'Enter suggestions separated by commas',
              ),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  // Process data.
                  // Prepare contact object with new data for processing
                  ServiceLog serviceLog = ServiceLog(
                    lastServiceDate: _lastServiceDate,
                    lastOdometer:
                        int.parse(_lastOdometerController.text.trim()),
                    worknotes: _worknotesController.text.trim(),
                    dueServiceDate: _dueServiceDate,
                    dueOdometer: int.parse(_dueOdometerController.text.trim()),
                    suggestions: _suggestionsController.text.trim(),
                  );

                  // Add / Update and persist the Service Log
                  (_isUpdate)
                      ? context
                          .read<AppDataNotifier>()
                          .updateServiceLog(widget.index!, serviceLog)
                      : context
                          .read<AppDataNotifier>()
                          .addServiceLog(serviceLog);

                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                    'Service log ${(_isUpdate) ? 'updated' : 'created'}.',
                    textAlign: TextAlign.center,
                  )));
                }
              },
              icon: const Icon(Icons.inventory_rounded),
              label: Text('${(_isUpdate) ? 'Update' : 'Add'} Service Log'),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  /// Vehicle service date picker dialog.
  ///
  /// Shows a Date Picker.
  Future<void> _selectLastServiceDate(BuildContext context) {
    return showDatePicker(
      context: context,
      currentDate: DateTime.now(),
      firstDate: DateTime(2023), // 1st Jan 2023
      lastDate: DateTime(2100, 12, 31), // 31st Dec 2100
      initialDate: _lastServiceDate, // current expiry date
      helpText: 'Last Serviced on',
      fieldLabelText: 'Last / Current service date',
    ).then((pickedDate) {
      if (pickedDate != null) {
        setState(() {
          _lastServiceDate = pickedDate;
        });
        _lastServiceDateController.text =
            DateFormat("dd MMM ''yy").format(_lastServiceDate);
      }
    });
  }

  /// Vehicle next service due date picker dialog.
  ///
  /// Shows a Date Picker.
  Future<void> _selectServiceDueDate(BuildContext context) {
    return showDatePicker(
      context: context,
      currentDate: DateTime.now(),
      firstDate: DateTime(2023), // 1st Jan 2023
      lastDate: DateTime(2100, 12, 31), // 31st Dec 2100
      initialDate: _dueServiceDate, // current expiry date
      helpText: 'Service Due on',
      fieldLabelText: 'Next service date',
    ).then((pickedDate) {
      if (pickedDate != null) {
        setState(() {
          _dueServiceDate = pickedDate;
        });
        _dueServiceDateController.text =
            DateFormat("dd MMM ''yy").format(_dueServiceDate);
      }
    });
  }
}
