import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vollit_wallet/providers/wallet_provider.dart';
import 'package:vollit_wallet/pages/verify_mnemonic_page.dart';
import 'package:vollit_wallet/utils/constants.dart';

class GenerateMnemonicPage extends StatelessWidget {
  const GenerateMnemonicPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final walletProvider = Provider.of<WalletProvider>(context);
    final mnemonic = walletProvider.generateMnemonic();
    final mnemonicWords = mnemonic.split(' ');

    void copyToClipboard() {
      Clipboard.setData(ClipboardData(text: mnemonic));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mnemonic Copied to Clipboard')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: buttonColor,
        centerTitle: true,
        title: const Text(
          'Generate Mnemonic',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: darkBackgroundColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Please store this mnemonic \nphrase safely:',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22.0,
                  color: borderColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 36.0),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 16.0,
                    crossAxisSpacing: 8.0,
                    childAspectRatio: 3,
                  ),
                  itemCount: mnemonicWords.length,
                  itemBuilder: (context, index) => Card(
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(color: borderColor, width: 1),
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}. ${mnemonicWords[index]}',
                        style:
                            const TextStyle(fontSize: 16.0, color: borderColor),
                      ),
                    ),
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: copyToClipboard,
                icon: const Icon(Icons.copy, color: Colors.black),
                label: const Text('Copy to Clipboard',
                    style: TextStyle(color: Colors.black)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: borderColor,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 12.0),
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6D34D3), Color(0xFF5A15AB)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            VerifyMnemonicPage(mnemonic: mnemonic),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 24.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Row(
                    children: const [
                      Text(
                        'I have safely stored the mnemonic',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontFamily: 'RetroFont',
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(Icons.arrow_forward),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
