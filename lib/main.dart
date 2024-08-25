import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controller/nft_view_data_provider.dart';
import 'view/nft_list_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NFTDataProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: NFTListView(),
      ),
    );
  }
}
