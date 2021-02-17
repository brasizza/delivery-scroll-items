import 'dart:convert';

import 'dart:math';

class Photo {
  final String title;
  final String thumbnailUrl;
  final String url;
  Photo({
    this.title,
    this.thumbnailUrl,
    this.url,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'thumbnailUrl': 'assets/images/vaders/' + Random().nextInt(7).toString() + '.png',
      'url': 'assets/images/vaders/' + Random().nextInt(7).toString() + '.png',
    };
  }

  factory Photo.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Photo(
      title: map['title'],
      thumbnailUrl: 'assets/images/vaders/' + Random().nextInt(7).toString() + '.png',
      url: 'assets/images/vaders/' + Random().nextInt(7).toString() + '.png',
    );
  }

  String toJson() => json.encode(toMap());

  factory Photo.fromJson(String source) => Photo.fromMap(json.decode(source));

  @override
  String toString() => 'Photo(title: $title, thumbnailUrl: $thumbnailUrl, url: $url)';
}
