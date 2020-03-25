import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      body: Center(
        child: Center(child: PlatformCircularProgressIndicator()),
      ),
    );
  }
}
