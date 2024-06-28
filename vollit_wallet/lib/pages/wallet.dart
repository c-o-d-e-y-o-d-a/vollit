import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vollit_wallet/components/nft_balances.dart';
import 'package:vollit_wallet/components/send_tokens.dart';
import 'package:vollit_wallet/pages/create_or_import_screen.dart';
import 'package:vollit_wallet/providers/wallet_provider.dart';
import 'package:vollit_wallet/utils/constants.dart';
import 'package:vollit_wallet/utils/get_balances.dart';
import 'package:web3dart/web3dart.dart';
import 'dart:convert';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  String walletAddress = '';
  String balance = '';
  String pvKey = '';

  @override
  void initState() {
    super.initState();
    loadWalletData();
  }

  Future<void> loadWalletData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? privateKey = prefs.getString('privateKey');
    if (privateKey != null) {
      final walletProvider = WalletProvider();
      await walletProvider.loadPrivateKey(privateKey);
      EthereumAddress address = await walletProvider.getPublicKey(privateKey);
      setState(() {
        walletAddress = address.hex;
        pvKey = privateKey;
      });

      String response = await getBalances(address.hex, 'sepolia');
      dynamic data = json.decode(response);
      String newBalance = data['balance'] ?? '0';

      EtherAmount latestBalance = EtherAmount.fromBigInt(EtherUnit.wei, BigInt.parse(newBalance));
      String latestBalanceInEther = latestBalance.getValueInUnit(EtherUnit.ether).toString();

      setState(() {
        balance = latestBalanceInEther;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Wallet',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: buttonColor,
      ),
      body: Container(
        decoration: BoxDecoration(color: darkBackgroundColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: buttonColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const Text(
                            'Wallet Address',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: borderColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16.0),
                          Text(
                            walletAddress,
                            style: const TextStyle(
                              fontSize: 20.0,
                              color: buttonColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Icon(
                              Icons.copy,
                              color: buttonColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  const Text(
                    'Balance',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: borderColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    balance,
                    style: const TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    FloatingActionButton(
                      heroTag: 'sendButton',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SendTokensPage(privateKey: pvKey),
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.send,
                        color: buttonColor,
                      ),
                      backgroundColor: borderColor,
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'Send',
                      style: TextStyle(
                        color: borderColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    FloatingActionButton(
                      heroTag: 'refreshButton',
                      onPressed: () {
                        setState(() {});
                      },
                      child: const Icon(
                        Icons.replay_outlined,
                        color: buttonColor,
                      ),
                      backgroundColor: borderColor,
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'Refresh',
                      style: TextStyle(
                        color: borderColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30.0),
            Expanded(
              child: DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    const TabBar(
                      labelColor: buttonColor,
                      tabs: [
                        Tab(text: 'Assets'),
                        Tab(text: 'NFTs'),
                        Tab(text: 'Options'),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          Column(
                            children: [
                              Card(
                                margin: const EdgeInsets.all(16.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Sepolia ETH',
                                        style: TextStyle(
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.bold,
                                          color: buttonColor,
                                        ),
                                      ),
                                      Text(
                                        balance,
                                        style: const TextStyle(
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.bold,
                                          color: buttonColor,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          SingleChildScrollView(
                            child: NFTListPage(address: walletAddress, chain: 'sepolia'),
                          ),
                          Center(
                            child: ListTile(
                              leading: const Icon(Icons.logout),
                              title: const Text(
                                'Logout',
                                style: TextStyle(
                                  color: buttonColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onTap: () async {
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                await prefs.remove('privateKey');
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const CreateOrImportPage(),
                                  ),
                                  (route) => false,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
