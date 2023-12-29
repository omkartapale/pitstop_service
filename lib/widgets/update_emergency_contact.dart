import 'package:flutter/material.dart';
import 'package:pitstop_service/model/emergency_contact.dart';

class EmergencyContactForm extends StatefulWidget {
  const EmergencyContactForm({super.key, required this.contact});

  final EmergencyContact contact;

  @override
  State<EmergencyContactForm> createState() => _EmergencyContactFormState();
}

class _EmergencyContactFormState extends State<EmergencyContactForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  late ContactRelation _contactRelation;
  TextEditingController numberController = TextEditingController();

  @override
  void initState() {
    nameController.text = widget.contact.name;
    _contactRelation = widget.contact.relation;
    numberController.text = widget.contact.number;

    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    numberController.dispose();
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
            controller: nameController,
            keyboardType: TextInputType.name,
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
            controller: numberController,
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
                // EmergencyContact temp = EmergencyContact(
                //   name: nameController.text.trim(),
                //   relation: _contactRelation,
                //   number: numberController.text.trim(),
                // );
                setState(() {});

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
