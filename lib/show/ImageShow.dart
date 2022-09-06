import 'package:flutter/material.dart';
import 'package:pintreset_flutter_samin/show/ButtonShow.dart';

class ImageShow extends StatelessWidget {
  String url;
  ImageShow({required this.url});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
          backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          actions: [
            IconButton(
                onPressed: () {
                  ShowBotton(context, height);
                },
                icon: const Icon(
                  Icons.more_horiz,
                )),
          ],
        ),
        body: 
            bachgroundBGCountiner(context, height, width),
            );
  }

  Widget bachgroundBGCountiner(context, height, width) {
    return  Container(
        width: double.infinity,
        height: height,
        decoration:
            BoxDecoration(image: DecorationImage(image: NetworkImage(url), fit: BoxFit.fill)),
    );
  }
}
