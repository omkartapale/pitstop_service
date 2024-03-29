import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pitstop_service/model/emergency_contact.dart';
import 'package:pitstop_service/notifiers/app_data_notifier.dart';
import 'package:pitstop_service/super/service_logs.dart';
import 'package:pitstop_service/super/vehicle_spec_form.dart';
import 'package:provider/provider.dart';

class SuperEmergencyContactsForm extends StatefulWidget {
  const SuperEmergencyContactsForm({super.key});

  @override
  State<SuperEmergencyContactsForm> createState() =>
      _SuperEmergencyContactsFormState();
}

class _SuperEmergencyContactsFormState
    extends State<SuperEmergencyContactsForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late EmergencyContact primary;
  late EmergencyContact secondary;

  // Primary Contact controllers
  final TextEditingController _primaryNameController = TextEditingController();
  late ContactRelation _primaryContactRelation;
  final TextEditingController _primaryNumberController =
      TextEditingController();

  // Secondary Contact controllers
  final TextEditingController _secondaryNameController =
      TextEditingController();
  late ContactRelation _secondaryContactRelation;
  final TextEditingController _secondaryNumberController =
      TextEditingController();

  @override
  void initState() {
    // Initialize primary and secondary contacts
    primary = context.read<AppDataNotifier>().appData.primaryContact;
    secondary = context.read<AppDataNotifier>().appData.secondaryContact;

    // Init controllers for primary contact
    _primaryNameController.text = primary.name;
    _primaryContactRelation = primary.relation;
    _primaryNumberController.text = primary.number;

    // Init controllers for secondary contact
    _secondaryNameController.text = secondary.name;
    _secondaryContactRelation = secondary.relation;
    _secondaryNumberController.text = secondary.number;

    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    _primaryNameController.dispose();
    _primaryNumberController.dispose();
    _secondaryNameController.dispose();
    _secondaryNumberController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('\$sudo'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) =>
                      const SuperVehicleSpecificationForm(),
                ),
              );
            },
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
          IconButton.filledTonal(
            onPressed: () {},
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
                      'Emergency Contacts',
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
                            'Primary contact',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            controller: _primaryNameController,
                            keyboardType: TextInputType.name,
                            textCapitalization: TextCapitalization.words,
                            decoration: const InputDecoration(
                              isDense: true,
                              filled: true,
                              label: Text('Person Name *'),
                              hintText: 'Enter contact person name',
                            ),
                            validator: (String? value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please contact person name.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          FormField<ContactRelation>(
                            builder: (FormFieldState<ContactRelation> state) {
                              return InputDecorator(
                                decoration: const InputDecoration(
                                  isDense: true,
                                  filled: true,
                                  label: Text('Relation *'),
                                  hintText: 'Please select relation',
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<ContactRelation>(
                                    value: _primaryContactRelation,
                                    isDense: true,
                                    onChanged: <ContactRelation>(newValue) {
                                      setState(() {
                                        _primaryContactRelation = newValue;
                                        state.didChange(newValue);
                                      });
                                    },
                                    items: ContactRelation.values.map(
                                      (ContactRelation options) {
                                        return DropdownMenuItem<
                                            ContactRelation>(
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
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _primaryNumberController,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              isDense: true,
                              filled: true,
                              prefixText: '+91 ',
                              label: Text('Contact Number *'),
                              hintText: 'Enter contact number',
                            ),
                            validator: (String? value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter contact number.';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
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
                            'Secondary contact',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            controller: _secondaryNameController,
                            keyboardType: TextInputType.name,
                            textCapitalization: TextCapitalization.words,
                            decoration: const InputDecoration(
                              isDense: true,
                              filled: true,
                              label: Text('Person Name *'),
                              hintText: 'Enter contact person name',
                            ),
                            validator: (String? value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please contact person name.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          FormField<ContactRelation>(
                            builder: (FormFieldState<ContactRelation> state) {
                              return InputDecorator(
                                decoration: const InputDecoration(
                                  isDense: true,
                                  filled: true,
                                  label: Text('Relation *'),
                                  hintText: 'Please select relation',
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<ContactRelation>(
                                    value: _secondaryContactRelation,
                                    isDense: true,
                                    onChanged: <ContactRelation>(newValue) {
                                      setState(() {
                                        _secondaryContactRelation = newValue;
                                        state.didChange(newValue);
                                      });
                                    },
                                    items: ContactRelation.values.map(
                                      (ContactRelation options) {
                                        return DropdownMenuItem<
                                            ContactRelation>(
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
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _secondaryNumberController,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              isDense: true,
                              filled: true,
                              prefixText: '+91 ',
                              label: Text('Contact Number *'),
                              hintText: 'Enter contact number',
                            ),
                            validator: (String? value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter contact number.';
                              }
                              return null;
                            },
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
        // Prepare primary contact object with new data for processing
        primary = EmergencyContact(
          name: _primaryNameController.text.trim(),
          relation: _primaryContactRelation,
          number: _primaryNumberController.text.trim(),
        );
        // Prepare secondary contact object with new data for processing
        secondary = EmergencyContact(
          name: _secondaryNameController.text.trim(),
          relation: _secondaryContactRelation,
          number: _secondaryNumberController.text.trim(),
        );
      });

      // Update and persist the emergency contacts
      context.read<AppDataNotifier>().saveEmergencyContact(
            primary: primary,
            secondary: secondary,
          );

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
        'Emergency contacts updated.',
        textAlign: TextAlign.center,
      )));
    }
  }
}
