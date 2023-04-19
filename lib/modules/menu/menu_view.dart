import 'package:flutter/material.dart';
import 'package:menu_scroll_delivery_fluid/core/consts.dart';
import 'package:menu_scroll_delivery_fluid/data/model/album_model.dart';
import 'package:menu_scroll_delivery_fluid/data/photo.dart';
import 'package:menu_scroll_delivery_fluid/modules/menu/menu_controller.dart';
import 'package:menu_scroll_delivery_fluid/modules/menu/widgets/list_vertical.dart';
import 'package:menu_scroll_delivery_fluid/modules/menu/widgets/single_item_list.dart';
import 'package:sticky_headers/sticky_headers.dart';

class MenuView extends StatefulWidget {
  @override
  _MenuViewState createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  int currTab = 0;
  MenuDataController _controller = MenuDataController();
  var _futureAlbums;
  List<Album> albums = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futureAlbums = _controller.initializeData();

    _controller.scrollController.addListener(() {
      if (_controller.scrollController.offset.toInt() <= 0) {
        _controller.itemScrollController.jumpTo(index: 0);
        setState(() {
          currTab = 0;
        });
        return null;
      }
      int iii = 0;
      var index = _controller.offsets.indexWhere((note) {
        int valor = (note);
        int offsetmin = _controller.scrollController.offset.toInt();
        int offsetMax;
        try {
          offsetMax = (_controller.offsets[iii]);
        } catch (e) {
          offsetMax = offsetmin;
        }

        iii++;
        return (valor >= offsetmin && valor <= offsetMax ? true : false);
      });
      if (index != -1) {
        setState(() {
          currTab = index;
          _controller.itemScrollController.jumpTo(index: currTab);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: FutureBuilder<List<Album>>(
            future: _futureAlbums,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                case ConnectionState.active:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("ERRO"),
                    );
                  }
                  if (!snapshot.hasData) {
                    return Center(child: Text("No data!"));
                  }
                  albums = snapshot.data ?? [];

                  return Column(
                    children: [
                      Container(height: Consts.heightListMenu, child: ListVertical(controller: _controller, albums: albums, currTab: currTab, update: _updateCurrTab)),
                      Expanded(
                        child: ListView.builder(
                            controller: _controller.scrollController,
                            itemCount: albums.length,
                            itemBuilder: (context, index) {
                              Album _album = albums[index];
                              return StickyHeaderBuilder(
                                controller: _controller.scrollController,
                                builder: (BuildContext context, double stuckAmount) {
                                  return Container(
                                    height: Consts.heightHeader,
                                    color: Colors.blueGrey[700],
                                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      _album.title,
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                  );
                                },
                                content: ListView.builder(
                                  padding: EdgeInsets.only(top: Consts.paddingTopItems),
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: _album.photos.length,
                                  itemBuilder: (BuildContext context, int indexPhoto) {
                                    Photo _photo = _album.photos[indexPhoto];
                                    return SingleItem(photo: _photo);
                                  },
                                ),
                              );
                            }),
                      ),
                    ],
                  );

                default:
                  return Container();
              }
            }),
      ),
    );
  }

  _updateCurrTab(newValue) {
    _controller.calculateJumpToPosition(newValue, albums);
    setState(() {
      currTab = newValue;
    });
  }
}
