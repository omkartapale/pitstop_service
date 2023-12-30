import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:o3d/o3d.dart';

class VehicleInfo extends StatefulWidget {
  const VehicleInfo({super.key});

  @override
  State<VehicleInfo> createState() => _VehicleInfoState();
}

class _VehicleInfoState extends State<VehicleInfo> {
  // to control the animation
  O3DController controller = O3DController();

  late DateTime fitnessExpiry, insuranceExpiry, pucExpiry;

  @override
  void initState() {
    // initiate vital dates for vehicle
    fitnessExpiry = DateTime.fromMillisecondsSinceEpoch(1949941800000);
    insuranceExpiry = DateTime.fromMillisecondsSinceEpoch(1729103400000);
    pucExpiry = DateTime.fromMillisecondsSinceEpoch(1702751400000);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            child: Text(
              'Vehicle specifications',
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
          const SizedBox(height: 16.0),
          Center(
            child: SizedBox(
              height: 200,
              width: 400,
              child: O3D.asset(
                src: 'assets/2021_bmw_m4_competition.glb',
                controller: controller,
                alt: '3D Vehicle Model',
                ar: false,
                autoPlay: true,
                autoRotate: true,
                rotationPerSecond: '30deg',
                cameraControls: true,
                cameraOrbit: CameraOrbit(310, 90, 8),
                maxCameraOrbit: 'auto 90deg auto',
                minCameraOrbit: 'auto 90deg auto',
                // cameraTarget: CameraTarget(0, 1, 0),
                loading: Loading.eager,
                interactionPrompt: InteractionPrompt.none,
                disablePan: true,
                disableZoom: true,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                child:
                    Text('Ameo', style: Theme.of(context).textTheme.titleLarge),
              ),
              const Divider(
                indent: 8.0,
                endIndent: 16.0,
              ),
              Container(
                padding: const EdgeInsets.only(
                    left: 8.0, right: 24.0, top: 8.0, bottom: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Max Power'.toUpperCase(),
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          Text(
                            '74bhp @ 5400rpm',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Cubic Capacity'.toUpperCase(),
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          Text(
                            '1198cc',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Cylinders'.toUpperCase(),
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          Text(
                            '3',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Card(
                  // color: Colors.purple.shade100,
                  shadowColor: Colors.transparent,
                  margin: const EdgeInsets.only(left: 8.0, right: 16.0),
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Key Specification',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Manufacturer'.toUpperCase(),
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                  Text(
                                    'Volkswagen',
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Model'.toUpperCase(),
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                  Text(
                                    'Ameo',
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Variant / Trim'.toUpperCase(),
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                  Text(
                                    '1.2L MPI Highline Plus',
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Make Year'.toUpperCase(),
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                  Text(
                                    '2016',
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Trasmission'.toUpperCase(),
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                  Text(
                                    'Manual',
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Fuel'.toUpperCase(),
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                  Text(
                                    'Petrol',
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Card(
                  color: Colors.purple.shade100,
                  shadowColor: Colors.transparent,
                  margin: const EdgeInsets.only(left: 8.0, right: 16.0),
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Vital Information',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Vehicle Fitness'.toUpperCase(),
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        DateFormat("dd MMM ''yy")
                                            .format(fitnessExpiry),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                      const SizedBox(width: 8.0),
                                      _isFitnessNearExpiry
                                          ? const Icon(
                                              Icons.error_outline_rounded,
                                              color: Colors.deepOrange,
                                            )
                                          : const Icon(
                                              Icons
                                                  .check_circle_outline_rounded,
                                              color: Colors.green,
                                            ),
                                      // const Spacer(),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              iconSize: 16,
                              padding: const EdgeInsets.all(0),
                              visualDensity: VisualDensity.compact,
                              onPressed: () => _updateRC(context),
                              icon: const Icon(Icons.edit_calendar_outlined),
                            ),
                            const SizedBox(width: 16.0),
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Insurance'.toUpperCase(),
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        DateFormat("dd MMM ''yy")
                                            .format(insuranceExpiry),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                      const SizedBox(width: 8.0),
                                      _isInsuranceNearExpiry
                                          ? const Icon(
                                              Icons.error_outline_rounded,
                                              color: Colors.deepOrange,
                                            )
                                          : const Icon(
                                              Icons
                                                  .check_circle_outline_rounded,
                                              color: Colors.green,
                                            ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              iconSize: 16,
                              padding: const EdgeInsets.all(0),
                              visualDensity: VisualDensity.compact,
                              onPressed: () => _updateInsurance(context),
                              icon: const Icon(Icons.edit_calendar_outlined),
                            ),
                            const SizedBox(width: 16.0),
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Pollution Check'.toUpperCase(),
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        DateFormat("dd MMM ''yy")
                                            .format(pucExpiry),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                      const SizedBox(width: 8.0),
                                      _isPucNearExpiry
                                          ? const Icon(
                                              Icons.error_outline_rounded,
                                              color: Colors.deepOrange,
                                            )
                                          : const Icon(
                                              Icons
                                                  .check_circle_outline_rounded,
                                              color: Colors.green,
                                            ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              iconSize: 16,
                              padding: const EdgeInsets.all(0),
                              visualDensity: VisualDensity.compact,
                              onPressed: () => _updatePUC(context),
                              icon: const Icon(Icons.edit_calendar_outlined),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
        ],
      ),
    );
  }

  /// Vehicle RC Fitness Validity Date update dialog
  ///
  /// Shows a Date Picker
  ///
  /// Once a new date is selected / provided, vehicle fitness date is updated
  /// and check for [_isFitnessNearExpiry] to set status for new date.
  Future<void> _updateRC(BuildContext context) {
    return showDatePicker(
      context: context,
      currentDate: DateTime.now(),
      // firstDate: DateTime(2016, 10, 17), // registration date or todays date can be good too
      firstDate: DateTime(2023), // 1st Jan 2023
      lastDate: DateTime(2100, 12, 31), // 31st Dec 2100
      initialDate: fitnessExpiry, // current expiry date
      helpText: 'Vehicle Fitness',
      confirmText: 'Update Fitness',
      fieldLabelText: 'Valid upto',
    ).then((pickedDate) {
      if (pickedDate != null) {
        setState(() {
          fitnessExpiry = pickedDate;
        });
      }
    });
  }

  /// Vehicle Insurance Expiry Date update dialog
  ///
  /// Shows a Date Picker
  ///
  /// Once a new date is selected / provided, vehicle insurance expiry date
  /// is updated and check for [_isInsuranceNearExpiry] to set status for
  /// new date.
  Future<void> _updateInsurance(BuildContext context) {
    return showDatePicker(
      context: context,
      currentDate: DateTime.now(),
      // firstDate: insuranceExpiry, // current expiry date
      firstDate: DateTime(2023), // 1st Jan 2023
      lastDate: DateTime(2100, 12, 31), // 31st Dec 2100
      initialDate: insuranceExpiry, // current expiry date
      helpText: 'Insurance',
      confirmText: 'Update Insurance',
      fieldLabelText: 'Valid upto',
    ).then((pickedDate) {
      if (pickedDate != null) {
        setState(() {
          insuranceExpiry = pickedDate;
        });
      }
    });
  }

  /// Vehicle Pollution Check Validity Date update dialog
  ///
  /// Shows a Date Picker
  ///
  /// Once a new date is selected / provided, vehicle PUC expiry date is
  /// updated and check for [_isPucNearExpiry] to set status for new date.
  Future<void> _updatePUC(BuildContext context) {
    return showDatePicker(
      context: context,
      currentDate: DateTime.now(),
      firstDate: DateTime(2023), // 1st Jan 2023
      lastDate: DateTime(2100, 12, 31), // 31st Dec 2100
      initialDate: pucExpiry, // current expiry date
      helpText: 'Pollution Check',
      confirmText: 'Update PUC',
      fieldLabelText: 'Valid upto',
    ).then((pickedDate) {
      if (pickedDate != null) {
        setState(() {
          pucExpiry = pickedDate;
        });
      }
    });
  }

  /// Checks if the vehicle fitness is less than or equal to 30 days
  /// close to expiry or expired already.
  bool get _isFitnessNearExpiry {
    return fitnessExpiry.difference(DateTime.now()).inDays <= 30;
  }

  /// Checks if the vehicle insurance is less than or equal to 30 days
  /// close to expiry or expired already.
  bool get _isInsuranceNearExpiry {
    return insuranceExpiry.difference(DateTime.now()).inDays <= 30;
  }

  /// Checks if the vehicle pollution check is less than or equal to 30 days
  /// close to expiry or expired already.
  bool get _isPucNearExpiry {
    return pucExpiry.difference(DateTime.now()).inDays <= 30;
  }
}
