import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pintreset_flutter_samin/data/dataProducts.dart';
import 'package:pintreset_flutter_samin/page/Login.dart';
import 'package:pintreset_flutter_samin/show/ButtonShow.dart';
import 'package:pintreset_flutter_samin/show/ImageShow.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<ProductsList> futureProduct;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    futureProduct = fetchFruit();
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            actions: [
              PopupMenuButton(
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                        child: TextButton(
                            onPressed: () {},
                            child: const Text("My Account",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black)))),
                    PopupMenuItem(
                        child: TextButton(
                            onPressed: () {},
                            child: const Text("setting",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black)))),
                    PopupMenuItem(
                        child: TextButton(
                            onPressed: () async {
                              SharedPreferences p =
                                  await SharedPreferences.getInstance();
                              await p.clear();
                              // ignore: use_build_context_synchronously
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Login()));
                            },
                            child: const Text("Logout",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black)))),
                  ];
                },
              )
            ]),
        body: SafeArea(
          child: Center(
            child: FutureBuilder<ProductsList>(
              future: futureProduct,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return StaggeredGridView.countBuilder(
                    crossAxisCount: 2,
                    itemCount: snapshot.data!.product.length,
                    itemBuilder: (BuildContext context1, int index) =>
                        GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ImageShow(
                                    url: snapshot.data!.product[index].image)));
                      },
                      onLongPress: () {
                        showBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: ((context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                height: _height * 0.2,
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.push_pin_sharp,
                                              color: Colors.black,
                                            )),
                                      ),
                                      CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.hide_source_rounded,
                                                color: Colors.black,
                                              ))),
                                      CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.share,
                                              color: Colors.black,
                                            )),
                                      ),
                                      CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.comment_bank_rounded,
                                                color: Colors.black,
                                              )))
                                    ]),
                              );
                            }));
                      },
                      onLongPressEnd: (_) {
                        Navigator.pop(context);
                      },
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(19),
                              child: Image.network(
                                snapshot.data!.product[index].image,
                                fit: BoxFit.cover,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  ShowBotton(context, _height);
                                },
                                icon: const Icon(
                                  Icons.more_horiz,
                                  color: Colors.white,
                                  size: 20.0,
                                ))
                          ]),
                    ),
                    staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
                    mainAxisSpacing: 15.0,
                    crossAxisSpacing: 8.0,
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.blue),
                    strokeWidth: 5.0);
              },
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.white,
          onTap: (index) => setState(() {
            _currentIndex = index;
          }),
          currentIndex: _currentIndex,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'home'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                ),
                label: 'search'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.add,
                ),
                label: 'add'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.comment,
                ),
                label: 'comment'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person_sharp,
                ),
                label: 'person')
          ],
        ),
      ),
    );
  }
}
