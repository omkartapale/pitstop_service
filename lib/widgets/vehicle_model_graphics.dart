import 'package:flutter/material.dart';
import 'package:o3d/o3d.dart';

/// Widget Class: Renders vehicle 3d model
class VehicleModelGraphic extends StatelessWidget {
  /// Vehicle 3d Model widget
  ///
  /// Renders vehicle's 3d model box.
  const VehicleModelGraphic({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 200,
        width: 400,
        child: O3D.asset(
          src: 'assets/2021_bmw_m4_competition.glb',
          alt: 'Vehicle 3D Model',
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
    );
  }
}
