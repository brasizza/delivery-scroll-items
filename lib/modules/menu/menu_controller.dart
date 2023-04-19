import 'package:flutter/material.dart';
import 'package:menu_scroll_delivery_fluid/core/consts.dart';
import 'package:menu_scroll_delivery_fluid/data/model/album_model.dart';
import 'package:menu_scroll_delivery_fluid/data/service/menu_service.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class MenuDataController {
  final MenuService _service = MenuService.instance;
  final scrollController = ScrollController();

  final ItemScrollController itemScrollController = ItemScrollController();
  List<int> offsets = [];
  int inicio = 1;

  Future<List<Album>> initializeData() async {
    List<Album> _albums = await _service.buildData();
    _buildOffsets(_albums);
    return _albums;
  }

  _buildOffsets(List<Album> albums) {
    int index = 1;
    double totals = 0;
    offsets.clear();

    albums.forEach((val) async {
      totals += val.photos.length;

      double _d = (Consts.heightList * totals) + (index * (Consts.paddingTopItems + Consts.heightHeader));
      //(totais * Consts.heightList) + (index * (Consts.heightList + Consts.paddingTopItems + Consts.heightHeader));
      offsets.add(_d.toInt());
      index++;
    });

    // albums.forEach((element) {
    //   totais += element;

    //   //offsets.add((((totais * altura) + (inicio * 40)).toInt() - 100).toString());
    //   inicio++;
    // });
  }

  calculateJumpToPosition(newValue, List<Album> albums) {
    int _jump = 0;
    double _position = 0.0;
    for (int i = 0; i < newValue; i++) {
      _jump = albums[i].photos.length;
      _position += (_jump * Consts.heightList) + Consts.paddingTopItems + Consts.heightHeader;
    }
    scrollController.jumpTo(_position);
    itemScrollController.jumpTo(index: newValue);
  }
}
