import 'package:flutter/material.dart';
import 'package:menu_scroll_delivery_fluid/data/model/album_model.dart';
import 'package:menu_scroll_delivery_fluid/modules/menu/menu_controller.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ListVertical extends StatelessWidget {
  final List<Album> albums;
  final int currTab;
  final Function update;
  final MenuDataController controller;
  const ListVertical({
    Key? key,
    required this.albums,
    required this.currTab,
    required this.update,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollablePositionedList.builder(
      itemScrollController: controller.itemScrollController,
      scrollDirection: Axis.horizontal,
      itemCount: albums.length,
      itemBuilder: (_, index) {
        Album _album = albums[index];

        return Container(
          child: InkWell(
            onTap: () {
              update(index);
            },
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: index == currTab ? Theme.of(context).primaryColor : null,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Text(_album.title,
                      style: TextStyle(
                        color: index == currTab
                            ? Theme.of(context).primaryColor.computeLuminance() < 0.5
                                ? Colors.black
                                : Colors.white
                            : null,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
