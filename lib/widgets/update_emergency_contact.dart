import 'package:flutter/material.dart';
import 'package:pitstop_service/model/emergency_contact.dart';
import 'package:pitstop_service/notifiers/app_data_notifier.dart';
import 'package:provider/provider.dart';

class EmergencyContactForm extends StatefulWidget {
  const EmergencyContactForm({
    super.key,
    required this.contact,
    required this.isPrimaryContact,
  });

  final EmergencyContact contact;
  final bool isPrimaryContact;

  @override
  State<EmergencyContactForm> createState() => _EmergencyContactFormState();
}

class _EmergencyContactFormState extends State<EmergencyContactForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  late ContactRelation _contactRelation;
  final TextEditingController _numberController = TextEditingController();

  @override
  void initState() {
    _nameController.text = widget.contact.name;
    _contactRelation = widget.contact.relation;
    _numberController.text = widget.contact.number;

    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _nameController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFormField(
            controller: _nameController,
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
                    value: _contactRelation,
                    isDense: true,
                    onChanged: <SpareType>(newValue) {
                      setState(() {
                        _contactRelation = newValue;
                        state.didChange(newValue);
                      });
                    },
                    items: ContactRelation.values.map(
                      (ContactRelation options) {
                        return DropdownMenuItem<ContactRelation>(
                          value: options,
                          child: Text(
                            options.value,
                            style:
                                const TextStyle(fontWeight: FontWeight.normal),
                          ),
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
            controller: _numberController,
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
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () {
              // Validate will return true if the form is valid, or false if
              // the form is invalid.
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                // Process data.
                // Prepare contact object with new data for processing
                EmergencyContact contact = EmergencyContact(
                  name: _nameController.text.trim(),
                  relation: _contactRelation,
                  number: _numberController.text.trim(),
                );

                // Update and persist the emergency contacts
                //
                // Check if to update primary contact or secondary contact,
                // accordingly pass new contact information to parameter
                widget.isPrimaryContact
                    ? context
                        .read<AppDataNotifier>()
                        .saveEmergencyContact(primary: contact)
                    : context
                        .read<AppDataNotifier>()
                        .saveEmergencyContact(secondary: contact);

                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                  'Emergency contact updated.',
                  textAlign: TextAlign.center,
                )));
              }
            },
            icon: const Icon(Icons.contacts_outlined),
            label: const Text('Update contact'),
          ),
        ],
      ),
    );
  }
}
