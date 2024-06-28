import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vollit_wallet/pages/wallet.dart';
import 'package:vollit_wallet/providers/wallet_provider.dart';
import 'package:vollit_wallet/utils/constants.dart';

class ImportWallet extends StatefulWidget {
  const ImportWallet({Key? key}) : super(key: key);

  @override
  _ImportWalletState createState() => _ImportWalletState();
}

class _ImportWalletState extends State<ImportWallet> {
  String verificationText = '';

  void navigateToWalletPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const WalletPage()),
    );
  }

  void verifyMnemonic() async {
    final walletProvider = Provider.of<WalletProvider>(context, listen: false);

    // Call the getPrivateKey function from the WalletProvider
    await walletProvider.getPrivateKey(verificationText);

    // Navigate to the WalletPage
    navigateToWalletPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Import from Seed',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: buttonColor,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: darkBackgroundColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Please Enter your mnemonic phrase:',
                style: TextStyle(fontSize: 18.0, color: borderColor),
              ),
              const SizedBox(height: 24.0),
              TextField(
                onChanged: (value) {
                  setState(() {
                    verificationText = value;
                  });
                },
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Enter mnemonic phrase',
                  labelStyle: const TextStyle(color: borderColor),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.1),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: borderColor),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: borderColor),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: verifyMnemonic,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: buttonColor,
                  padding: const EdgeInsets.all(16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text(
                  'Import',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'RetroFont',
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
            ],
          ),
        ),
      ),
    );
  }
}
