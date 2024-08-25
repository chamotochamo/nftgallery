import 'package:flutter/material.dart';
import '../model/get_nft_model.dart';
import 'fetch_nft.dart';

class NFTDataProvider with ChangeNotifier {
  List<NFT> _nfts = [];
  List<String> _imageUrls = [];
  int _loadedImages = 0;

  List<NFT> get nfts => _nfts;
  List<String> get imageUrls => _imageUrls;
  int get loadedImages => _loadedImages;

  Future<void> fetchAndCacheNFTs(BuildContext context) async {
    _nfts = await fetchNFTs();
    _imageUrls = _nfts.map((nft) => nft.imageUrl).toList();
    print('Total NFTs fetched: ${_nfts.length}');
    notifyListeners();
    _loadImagesSequentially(context);
  }

  void _loadImagesSequentially(BuildContext context) async {
    for (int i = 0; i < _imageUrls.length; i++) {
      print('Loading image: ${_imageUrls[i]}');
      await precacheImage(NetworkImage(_imageUrls[i]), context);
      _loadedImages++;
      notifyListeners();
      print('Image loaded: ${_imageUrls[i]}');
      await Future.delayed(Duration(milliseconds: 500)); // Slight delay for visual effect
    }
  }
}
