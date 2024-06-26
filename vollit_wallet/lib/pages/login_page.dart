import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vollit_wallet/pages/create_or_import_screen.dart';
import 'package:vollit_wallet/providers/wallet_provider.dart';

import 'wallet.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final walletProvider = Provider.of<WalletProvider>(context);

    if (walletProvider.privateKey == null) {
      
      return const CreateOrImportPage();
    } else {
      
      return WalletPage();
    }
  }
}
