import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';

class FullScreen extends StatefulWidget {
  final String imageurl;

  const FullScreen({Key? key, required this.imageurl}) : super(key: key);

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  Future<void> setWallpaper() async {
     int location = WallpaperManager.HOME_SCREEN;
    //int location1 = WallpaperManager.LOCK_SCREEN;
    var file = await DefaultCacheManager().getSingleFile(widget.imageurl);
    String result =
        WallpaperManager.setWallpaperFromFile(file.path, location) as String;
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Image.network(widget.imageurl),
              ),
            ),
            InkWell(
              onTap: () {
                setWallpaper();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Container(
                    clipBehavior: Clip.antiAlias,
                    height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Set Wallpaper", style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ],
                      ),

                  ),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.white,
                  elevation: 0,
                ));
              },
              child: Container(
                width: double.infinity,
                height: 60,
                color: Colors.teal,
                child: Center(
                  child: Text(
                    "Set Wallpaper",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
