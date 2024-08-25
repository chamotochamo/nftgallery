import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/get_nft_model.dart';

Future<List<NFT>> fetchNFTs() async {
  try {
    final response = await http.get(
      Uri.parse('https://api.opensea.io/api/v2/chain/matic/account/0x64D965104b5872fdAf78f2dc049fc964c997cd5D/nfts'),
      headers: {
        'accept': 'application/json',
        'x-api-key': 'ec78aa595cb64b7086ac69f1ccb93fa0', // Replace with your API key
      },
    );

    if (response.statusCode == 200) {
      print('NFTs fetched successfully');
      final List<dynamic> data = jsonDecode(response.body)['nfts'];
      List<NFT> nfts = [];

      for (var json in data) {
        NFT nft = NFT.fromJson(json);
        nfts.add(nft);
        print('NFT Loaded: ${nft.name} - Image URL: ${nft.imageUrl}');
      }

      return nfts;
    } else {
      print('Failed to load NFTs: ${response.statusCode}');
      throw Exception('Failed to load NFTs');
    }
  } catch (e) {
    print('Error fetching NFTs: $e');
    throw Exception('Error fetching NFTs');
  }
}
