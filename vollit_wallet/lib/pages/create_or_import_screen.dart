import 'package:flutter/material.dart';
import 'package:vollit_wallet/pages/generate_mnenomic_page.dart';
import 'package:vollit_wallet/utils/constants.dart';
import 'import_wallet.dart';

class CreateOrImportPage extends StatelessWidget {
  const CreateOrImportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackgroundColor,
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Container(
              alignment: Alignment.center,
              child: const Text(
                'Vollit',
                style: TextStyle(
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily:
                      'RetroFont', // Replace with your desired retro font
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            const SizedBox(height: 50.0),

            // Create Wallet button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GenerateMnemonicPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: buttonColor, // Customize button text color
                padding: const EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 10,
                shadowColor: Colors.black.withOpacity(0.3),
              ),
              child: const Text(
                'Create Wallet',
                style: TextStyle(
                  fontSize: 18.0,
                  fontFamily:
                      'RetroFont', // Replace with your desired retro font
                ),
              ),
            ),
            const SizedBox(height: 16.0),

            // Import from Seed button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ImportWallet(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: borderColor, // Customize button text color
                padding: const EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 10,
                shadowColor: Colors.black.withOpacity(0.3),
              ),
              child: const Text(
                'Import from Seed',
                style: TextStyle(
                  fontSize: 18.0,
                  fontFamily:
                      'RetroFont', // Replace with your desired retro font
                ),
              ),
            ),
            const SizedBox(height: 24.0),

            // Footer
            Container(
              alignment: Alignment.center,
              child: const Text(
                '© 2024 Nischal. All rights reserved.',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey,
                  fontFamily:
                      'RetroFont', // Replace with your desired retro font
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
