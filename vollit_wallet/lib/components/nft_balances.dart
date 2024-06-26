import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NFTListPage extends StatefulWidget {
  final String address;
  final String chain;

  const NFTListPage({
    Key? key,
    required this.address,
    required this.chain,
  }) : super(key: key);

  @override
  _NFTListPageState createState() => _NFTListPageState();
}

class _NFTListPageState extends State<NFTListPage> {
  List<dynamic> _nftList = [];

  @override
  void initState() {
    super.initState();
    _loadNFTList();
  }

 Future<void> _loadNFTList() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://192.168.29.148:5002/get-user-nfts//${widget.chain}//${widget.address}'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        setState(() {
          _nftList =
              jsonData['result'] ?? []; 
        });
      } else {
        throw Exception('Failed to load NFT list: ${response.statusCode}');
      }
    } catch (e) {
      print('Error loading NFT list: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var nft in _nftList)
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  '${nft['name']}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 200, 
                  child: nft['normalized_metadata']['image'] != null
                      ? Image.network(
                          nft['normalized_metadata']['image'],
                          fit: BoxFit.contain,
                        )
                      : const Center(
                          child: Text('Img'),
                        ),
                ),
                Text(
                  '${nft['normalized_metadata']['description']}',
                ),
              ],
            ),
          ),
      ],
    );
  }
}
