import 'package:http/http.dart' as http;

Future<String> getBalances(String address, String chain) async {
  final url = Uri.http(' http://192.168.29.148:5002', '/get_token_balances',{
    'address': address,
    'chain' : chain
  });

  final response = await http.get(url);

  if(response.statusCode == 200){
    return response.body;
  }
  else{
    throw Exception('Failed to load data');
  }

}