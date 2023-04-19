// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:menu_scroll_delivery_fluid/data/photo.dart';

class Album {
  final int userId;
  final int id;
  final String title;
  List<Photo> photos;
  Album({
    required this.userId,
    required this.id,
    required this.title,
    required this.photos,
  });

  Album copyWith({
    int? userId,
    int? id,
    String? title,
    List<Photo>? photos,
  }) {
    return Album(
      userId: userId ?? this.userId,
      id: id ?? this.id,
      title: title ?? this.title,
      photos: photos ?? this.photos,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'id': id,
      'title': title,
      'photos': photos.map((x) => x.toMap()).toList(),
    };
  }

  factory Album.fromMap(Map<String, dynamic> map) {
    return Album(
      userId: map['userId'] as int,
      id: map['id'] as int,
      title: map['title'] as String,
      photos: (map['photos'] == null)
          ? []
          : List<Photo>.from(
              (map['photos'] as List<dynamic>).map<Photo>(
                (x) => Photo.fromMap(x as Map<String, dynamic>),
              ),
            ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Album.fromJson(String source) => Album.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Album(userId: $userId, id: $id, title: $title, photos: $photos)';
  }

  @override
  bool operator ==(covariant Album other) {
    if (identical(this, other)) return true;

    return other.userId == userId && other.id == id && other.title == title && listEquals(other.photos, photos);
  }

  @override
  int get hashCode {
    return userId.hashCode ^ id.hashCode ^ title.hashCode ^ photos.hashCode;
  }
}
