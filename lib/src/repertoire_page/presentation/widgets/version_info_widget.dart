import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VersionInfoWidget extends StatelessWidget {
  const VersionInfoWidget({super.key});

  Future<PackageInfo> _getPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    return info;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackageInfo>(
      future: _getPackageInfo(),
      builder: (BuildContext context, AsyncSnapshot<PackageInfo> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final packageInfo = snapshot.data;
          return Center(
            child: Text(
              'Version: ${packageInfo!.version}+${packageInfo.buildNumber}',
            ),
          );
        }
      },
    );
  }
}
