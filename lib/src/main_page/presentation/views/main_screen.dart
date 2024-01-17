import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ticket_prod_v2/router/auto_routes.dart';

@RoutePage()
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Scan QR',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/qr_code.gif',
              width: 300,
              height: 300,
            ),
            const SizedBox(
              height: 80,
            ),
            ElevatedButton(
              onPressed: () {
                AutoRouter.of(context).push(const QRScannerRoute());
              },
              child: const Text(
                'Scan QR',
                style: TextStyle(fontSize: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
