import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


import 'full_screen.dart';

class wallpapers extends StatefulWidget {
  const wallpapers({Key? key}) : super(key: key);

  @override
  State<wallpapers> createState() => _wallpapersState();
}

class _wallpapersState extends State<wallpapers> {
  List images = [];
  int page = 1;
  void initState() {
    super.initState();
    fetchapi();
  }

  fetchapi() async {
    await http.get(Uri.parse('https://api.pexels.com/v1/curated?per_page=80'),
        headers: {
          'Authorization':
          '563492ad6f917000010000013a9f92129df3427f8836c53d0d8e0e9f'
        }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images = result['photos'];
      });
      print(images[0]);
    });
  }

  loadmore()async {
    setState(() {
      page = page+1;
    });
    String url = 'https://api.pexels.com/v1/curated?per_page=80&page=' + page.toString();
    await http.get(Uri.parse(url),
        headers: {
          'Authorization':
          '563492ad6f917000010000013a9f92129df3427f8836c53d0d8e0e9f'
        }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images.addAll(result['photos']);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: Container(
                child: GridView.builder(
                    itemCount: images.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 2,
                        childAspectRatio: 2 / 3,
                        mainAxisSpacing: 2),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>FullScreen(imageurl: images[index]['src']['large2x'],)));
                        },
                        child: Container(
                          color: Colors.white,
                          child: Image.network(images[index]['src']['tiny'],fit: BoxFit.cover,),
                        ),
                      );
                    }),
              )),
          InkWell(
            onTap: () {
              loadmore();
            },
            child: Container(
              width: double.infinity,
              height: 60,
              color: Colors.teal,
              child: Center(
                  child: Text(
                    "Load More",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
            ),
          )
        ],
      ),
    );
  }
}