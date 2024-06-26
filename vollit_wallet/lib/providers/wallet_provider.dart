import 'package:ed25519_hd_key/ed25519_hd_key.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3dart/credentials.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:hex/hex.dart';

abstract class WalletAddressServices{
  String generateMnemonic();
  Future<String> getPrivateKey(String mnemonic);
  Future<EthereumAddress> getPublicKey(String privateKey);
}

class WalletProvider extends ChangeNotifier implements WalletAddressServices{
  String? privateKey;

  Future<void> loadPrivateKey(String mnemonic) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    privateKey = prefs.getString('privatekey');


  }

  Future<void> setPrivateKey(String privateKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('privateKey', privateKey);
    notifyListeners();
  }


  @override 
  String generateMnemonic(){
    return bip39.generateMnemonic();
  }

  @override
  Future<String> getPrivateKey(String mnemonic) async {
    
    final seed = bip39.mnemonicToSeed(mnemonic);
    final master = await ED25519_HD_KEY.getMasterKeyFromSeed(seed);
    final privateKey = HEX.encode(master.key);
    await setPrivateKey(privateKey);
    return privateKey;
  }

  @override
  Future<EthereumAddress> getPublicKey(String privateKey)async{
    final private = EthPrivateKey.fromHex(privateKey);
    final address = await private.address;
    return address;

  }

}