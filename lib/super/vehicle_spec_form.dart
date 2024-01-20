import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pitstop_service/model/vehicle_specification.dart';
import 'package:pitstop_service/notifiers/app_data_notifier.dart';
import 'package:pitstop_service/super/emergency_contacts_form.dart';
import 'package:pitstop_service/super/service_logs.dart';
import 'package:provider/provider.dart';

class SuperVehicleSpecificationForm extends StatefulWidget {
  const SuperVehicleSpecificationForm({super.key});

  @override
  State<SuperVehicleSpecificationForm> createState() =>
      _SuperVehicleSpecificationFormState();
}

class _SuperVehicleSpecificationFormState
    extends State<SuperVehicleSpecificationForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late VehicleSpecification vSpec;

  // Vehicle Key Spec state controllers
  final TextEditingController _manufacturerController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _variantController = TextEditingController();
  final TextEditingController _makeYearController = TextEditingController();
  late Transmission _transmission;
  late FuelType _fuelType;
  final TextEditingController _licensePlateController = TextEditingController();

  // Vehicle Engine Spec state controllers
  final TextEditingController _maxPowerController = TextEditingController();
  final TextEditingController _capacityController = TextEditingController();
  final TextEditingController _cylinderController = TextEditingController();

  // Vehicle Vital Spec state controllers
  late DateTime _fitnessValidUpto, _insuranceValidUpto, _pucValidUpto;
  final TextEditingController _fitnessValidUptoController =
      TextEditingController();
  final TextEditingController _insuranceValidUptoController =
      TextEditingController();
  final TextEditingController _pucValidUptoController = TextEditingController();

  @override
  initState() {
    // Initialize vehicles spec object
    vSpec = context.read<AppDataNotifier>().appData.vehicleSpec;

    // Populate controllers and state vars with vehicle specifications
    _manufacturerController.text = vSpec.manufacturer;
    _modelController.text = vSpec.model;
    _variantController.text = vSpec.variant;
    _makeYearController.text = vSpec.makeYear.toString();
    _transmission = vSpec.transmission;
    _fuelType = vSpec.fuel;
    _licensePlateController.text = vSpec.licensePlate;
    _maxPowerController.text = vSpec.maxPower;
    _capacityController.text = vSpec.capacity;
    _cylinderController.text = vSpec.cylinder;
    _fitnessValidUpto = vSpec.fitnessValidUpto;
    _fitnessValidUptoController.text =
        DateFormat("dd MMM ''yy").format(_fitnessValidUpto);
    _insuranceValidUpto = vSpec.insuranceValidUpto;
    _insuranceValidUptoController.text =
        DateFormat("dd MMM ''yy").format(_insuranceValidUpto);
    _pucValidUpto = vSpec.pucValidUpto;
    _pucValidUptoController.text =
        DateFormat("dd MMM ''yy").format(_pucValidUpto);

    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    _manufacturerController.dispose();
    _modelController.dispose();
    _variantController.dispose();
    _makeYearController.dispose();
    _licensePlateController.dispose();
    _maxPowerController.dispose();
    _capacityController.dispose();
    _cylinderController.dispose();
    _fitnessValidUptoController.dispose();
    _insuranceValidUptoController.dispose();
    _pucValidUptoController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('\$sudo'),
        actions: [
          IconButton.filledTonal(
            onPressed: () {},
            icon: const Icon(Icons.type_specimen),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const SuperServiceLogs(),
                ),
              );
            },
            icon: const Icon(Icons.warehouse),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) =>
                      const SuperEmergencyContactsForm(),
                ),
              );
            },
            icon: const Icon(Icons.emergency),
          ),
          IconButton(
            onPressed: () {
              SystemNavigator.pop();
            },
            icon: const Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(
            left: 12.0,
            right: 12.0,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4.0, vertical: 8.0),
                    child: Text(
                      'Vehicle Specification',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  Card(
                    shadowColor: Colors.transparent,
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.topLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Key Specification',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            controller: _manufacturerController,
                            keyboardType: TextInputType.name,
                            textCapitalization: TextCapitalization.words,
                            decoration: const InputDecoration(
                              isDense: true,
                              filled: true,
                              label: Text('Manufacturer *'),
                              hintText: 'Enter manufacturer name',
                            ),
                            validator: (String? value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter manufacturer name.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 8.0),
                          TextFormField(
                            controller: _modelController,
                            keyboardType: TextInputType.name,
                            textCapitalization: TextCapitalization.words,
                            decoration: const InputDecoration(
                              isDense: true,
                              filled: true,
                              label: Text('Model *'),
                              hintText: 'Enter model name',
                            ),
                            validator: (String? value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter model name.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 8.0),
                          TextFormField(
                            controller: _variantController,
                            keyboardType: TextInputType.name,
                            textCapitalization: TextCapitalization.words,
                            decoration: const InputDecoration(
                              isDense: true,
                              filled: true,
                              label: Text('Variant / Trim *'),
                              hintText: 'Enter variant or trim',
                            ),
                            validator: (String? value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter variant or trim name.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 8.0),
                          TextFormField(
                            controller: _makeYearController,
                            keyboardType: TextInputType.datetime,
                            decoration: const InputDecoration(
                              isDense: true,
                              filled: true,
                              label: Text('Make Year *'),
                              hintText: 'Enter manufacturing year',
                            ),
                            validator: (String? value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter manufacturing year.';
                              } else if (int.tryParse(value) == null) {
                                return 'Please enter a valid year';
                              } else if (int.parse(value) < 1900 ||
                                  int.parse(value) > 2100) {
                                return 'Please enter a year between 1900 and 2100';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 8.0),
                          FormField<Transmission>(
                            builder: (FormFieldState<Transmission> state) {
                              return InputDecorator(
                                decoration: const InputDecoration(
                                  isDense: true,
                                  filled: true,
                                  label: Text('Transmission Type *'),
                                  hintText: 'Please select transmission type',
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<Transmission>(
                                    value: _transmission,
                                    isDense: true,
                                    onChanged: <Transmission>(newValue) {
                                      setState(() {
                                        _transmission = newValue;
                                        state.didChange(newValue);
                                      });
                                    },
                                    items: Transmission.values.map(
                                      (Transmission options) {
                                        return DropdownMenuItem<Transmission>(
                                          value: options,
                                          child: Text(options.value),
                                        );
                                      },
                                    ).toList(),
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 8.0),
                          FormField<FuelType>(
                            builder: (FormFieldState<FuelType> state) {
                              return InputDecorator(
                                decoration: const InputDecoration(
                                  isDense: true,
                                  filled: true,
                                  label: Text('Fuel Type *'),
                                  hintText: 'Please select fuel type',
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<FuelType>(
                                    value: _fuelType,
                                    isDense: true,
                                    onChanged: <FuelType>(newValue) {
                                      setState(() {
                                        _fuelType = newValue;
                                        state.didChange(newValue);
                                      });
                                    },
                                    items: FuelType.values.map(
                                      (FuelType options) {
                                        return DropdownMenuItem<FuelType>(
                                          value: options,
                                          child: Text(options.value),
                                        );
                                      },
                                    ).toList(),
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 8.0),
                          TextFormField(
                            controller: _licensePlateController,
                            keyboardType: TextInputType.name,
                            textCapitalization: TextCapitalization.characters,
                            decoration: const InputDecoration(
                              isDense: true,
                              filled: true,
                              label: Text('Registration Plate *'),
                              hintText: 'Enter registration plate number',
                            ),
                            validator: (String? value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter registration plate number.';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    shadowColor: Colors.transparent,
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.topLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Engine Spec',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            controller: _maxPowerController,
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              isDense: true,
                              filled: true,
                              label: Text('Max Power *'),
                              hintText: '74bhp @ 5400rpm or 143bhp 215Nm',
                              helperText: 'Max power: bhp@rpm. For EV: bhp nm.',
                            ),
                            validator: (String? value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter max power.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 8.0),
                          TextFormField(
                            controller: _capacityController,
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              isDense: true,
                              filled: true,
                              label: Text('Capacity *'),
                              hintText: '1198cc or 40.5kWh 465km',
                              helperText:
                                  'Cubic Capacity(cc). For EV: kWh with KM.',
                            ),
                            validator: (String? value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter vehicle capacity.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 8.0),
                          TextFormField(
                            controller: _cylinderController,
                            keyboardType: TextInputType.name,
                            textCapitalization: TextCapitalization.words,
                            decoration: const InputDecoration(
                              isDense: true,
                              filled: true,
                              label: Text('Cylinder, Valves/Cylinder *'),
                              hintText: '3 Inline, 4 Valves/Cylinder, SOHC',
                              helperText:
                                  'Cylinder, Valves per Cylinder. For EV: NA.',
                            ),
                            validator: (String? value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter engine cylinder.';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    shadowColor: Colors.transparent,
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.topLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Vital Specification',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            controller: _fitnessValidUptoController,
                            readOnly: true,
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              isDense: true,
                              filled: true,
                              label: Text('Fitness Validity *'),
                              hintText: 'Select fitness expiry date',
                              suffixIcon: Icon(Icons.today),
                            ),
                            onTap: () => _selectFitnessDate(context),
                          ),
                          const SizedBox(height: 8.0),
                          TextFormField(
                            controller: _insuranceValidUptoController,
                            readOnly: true,
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              isDense: true,
                              filled: true,
                              label: Text('Insurance Validity *'),
                              hintText: 'Select insurance expiry date',
                              suffixIcon: Icon(Icons.today),
                            ),
                            onTap: () => _selectInsuranceExpiryDate(context),
                          ),
                          const SizedBox(height: 8.0),
                          TextFormField(
                            controller: _pucValidUptoController,
                            readOnly: true,
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              isDense: true,
                              filled: true,
                              label: Text('Pollution Certificate Validity *'),
                              hintText: 'Select PUC expiry date',
                              suffixIcon: Icon(Icons.today),
                            ),
                            onTap: () => _selectPUCExpiryDate(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4.0, vertical: 8.0),
                    child: Wrap(
                      alignment: WrapAlignment.end,
                      spacing: 8.0,
                      children: [
                        TextButton(
                          onPressed: () {
                            _saveForm(context);
                            Navigator.pop(context);
                          },
                          child: const Text('Save & Exit'),
                        ),
                        FilledButton(
                          onPressed: () => _saveForm(context),
                          child: const Text('Save'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _saveForm(BuildContext context) {
    // Validate will return true if the form is valid, or false if
    // the form is invalid.
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Remove form field focus and hide keyboard.
      FocusManager.instance.primaryFocus?.unfocus();
      // FocusScope.of(context).nearestScope.unfocus();
      // FocusScope.of(context).enclosingScope?.unfocus();

      // Process data.
      setState(() {
        // Prepare vehicle specification object with new data for processing
        vSpec = VehicleSpecification(
            manufacturer: _manufacturerController.text.trim(),
            model: _modelController.text.trim(),
            variant: _variantController.text.trim(),
            makeYear: int.parse(_makeYearController.text.trim()),
            transmission: _transmission,
            fuel: _fuelType,
            licensePlate: _licensePlateController.text.trim(),
            maxPower: _maxPowerController.text.trim(),
            capacity: _capacityController.text.trim(),
            cylinder: _cylinderController.text.trim(),
            fitnessValidUpto: _fitnessValidUpto,
            insuranceValidUpto: _insuranceValidUpto,
            pucValidUpto: _pucValidUpto);
      });

      // Update and persist the Vehicle Specifications
      context.read<AppDataNotifier>().saveVehicleSpecifications(vSpec);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
        'Vehicle specification updated.',
        textAlign: TextAlign.center,
      )));
    }
  }

  /// Vehicle RC Fitness Validity Date picker dialog
  ///
  /// Shows a Date Picker
  Future<void> _selectFitnessDate(BuildContext context) {
    return showDatePicker(
      context: context,
      currentDate: DateTime.now(),
      firstDate: DateTime(2023), // 1st Jan 2023
      lastDate: DateTime(2100, 12, 31), // 31st Dec 2100
      initialDate: _fitnessValidUpto, // current expiry date
      helpText: 'Vehicle Fitness',
      fieldLabelText: 'Valid upto',
    ).then((pickedDate) {
      if (pickedDate != null) {
        setState(() {
          _fitnessValidUpto = pickedDate;
        });
        _fitnessValidUptoController.text =
            DateFormat("dd MMM ''yy").format(_fitnessValidUpto);
      }
    });
  }

  /// Vehicle Insurance Expiry Date picker dialog
  ///
  /// Shows a Date Picker
  Future<void> _selectInsuranceExpiryDate(BuildContext context) {
    return showDatePicker(
      context: context,
      currentDate: DateTime.now(),
      firstDate: DateTime(2023), // 1st Jan 2023
      lastDate: DateTime(2100, 12, 31), // 31st Dec 2100
      initialDate: _insuranceValidUpto, // current expiry date
      helpText: 'Insurance',
      fieldLabelText: 'Valid upto',
    ).then((pickedDate) {
      if (pickedDate != null) {
        setState(() {
          _insuranceValidUpto = pickedDate;
        });
        _insuranceValidUptoController.text =
            DateFormat("dd MMM ''yy").format(_insuranceValidUpto);
      }
    });
  }

  /// Vehicle Pollution Check Validity Date picker dialog
  ///
  /// Shows a Date Picker
  Future<void> _selectPUCExpiryDate(BuildContext context) {
    return showDatePicker(
      context: context,
      currentDate: DateTime.now(),
      firstDate: DateTime(2023), // 1st Jan 2023
      lastDate: DateTime(2100, 12, 31), // 31st Dec 2100
      initialDate: _pucValidUpto, // current expiry date
      helpText: 'Pollution Check',
      fieldLabelText: 'Valid upto',
    ).then((pickedDate) {
      if (pickedDate != null) {
        setState(() {
          _pucValidUpto = pickedDate;
        });
        _pucValidUptoController.text =
            DateFormat("dd MMM ''yy").format(_pucValidUpto);
      }
    });
  }
}
