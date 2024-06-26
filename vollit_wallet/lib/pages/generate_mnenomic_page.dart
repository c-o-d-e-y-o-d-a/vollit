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
        title: const Text('Generate Mnemonic', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: darkBackgroundColor
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Please store this mnemonic \nphrase safely:',
                style: TextStyle(fontSize: 18.0, color: borderColor),
              ),
              const SizedBox(height: 24.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: List.generate(
                  mnemonicWords.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Container(
                      decoration: BoxDecoration(
                        
                        border: Border.all( color: borderColor, width: 1),
                        borderRadius: BorderRadius.all(Radius.elliptical(8, 4))
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}. ${mnemonicWords[index]}',
                          style: const TextStyle(fontSize: 16.0, color: borderColor),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
              ElevatedButton.icon(
                onPressed: () {
                  copyToClipboard();
                },
                icon: const Icon(Icons.copy, color: borderColor,),
                label: const Text('Copy to Clipboard', style: TextStyle(color: borderColor),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 6),
                  textStyle: const TextStyle(fontSize: 16.0),
                  elevation: 4,
                  shadowColor: Colors.black.withOpacity(0.4),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          VerifyMnemonicPage(mnemonic: mnemonic),
                    ),
                  );

                },
                child: Container(
                  child:Text('I have safely stored the mnenomic \n ->', style: TextStyle(color: Colors.white),)
                ),
              )
                
              
            ],
          ),
        ),
      ),
    );
  }
}
