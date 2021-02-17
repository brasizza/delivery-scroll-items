import 'package:flutter/material.dart';
import 'package:menu_scroll_delivery_fluid/core/consts.dart';
import 'package:menu_scroll_delivery_fluid/data/photo.dart';

class SingleItem extends StatelessWidget {
  final Photo photo;

  const SingleItem({Key key, this.photo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Consts.heightList,
      child: ListTile(
        trailing: Image.asset(photo.thumbnailUrl),
        title: Text(photo.title),
      ),
    );
  }
}
