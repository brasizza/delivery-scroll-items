import 'dart:convert';

import 'package:menu_scroll_delivery_fluid/data/photo.dart';

class Album {
  final int userId;
  final int id;
  final String title;
  final List<Photo> photos;
  Album({
    this.userId,
    this.id,
    this.title,
    this.photos,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'photos': photos?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory Album.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Album(
      userId: map['userId'],
      id: map['id'],
      title: map['title'],
      photos: (map['photos'] == null) ? [] : List<Photo>.from(map['photos']?.map((x) => Photo.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Album.fromJson(String source) => Album.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Album(userId: $userId, id: $id, title: $title, photos: $photos)';
  }
}
