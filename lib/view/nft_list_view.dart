import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import '../controller/nft_view_data_provider.dart';

class NFTListView extends StatefulWidget {
  @override
  _NFTListViewState createState() => _NFTListViewState();
}

class _NFTListViewState extends State<NFTListView> {
  @override
  void initState() {
    super.initState();
    // Load cached data and start fetching with context
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NFTDataProvider>(context, listen: false).fetchAndCacheNFTs(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NFT Gallery'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Consumer<NFTDataProvider>(
          builder: (context, nftDataProvider, child) {
            if (nftDataProvider.imageUrls.isEmpty) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: MasonryGridView.builder(
                  gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                  ),
                  itemCount: nftDataProvider.loadedImages,
                  itemBuilder: (context, index) {
                    final imageUrl = nftDataProvider.imageUrls[index];
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        placeholder: (context, url) =>
                            SizedBox(height: 20, width: 20, child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
