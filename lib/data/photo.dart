// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Photo {
  final String title;
  final String thumbnailUrl;
  final String url;
  Photo({
    required this.title,
    required this.thumbnailUrl,
    required this.url,
  });

  Photo copyWith({
    String? title,
    String? thumbnailUrl,
    String? url,
  }) {
    return Photo(
      title: title ?? this.title,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'thumbnailUrl': thumbnailUrl,
      'url': url,
    };
  }

  factory Photo.fromMap(Map<String, dynamic> map) {
    return Photo(
      title: map['title'] as String,
      thumbnailUrl: map['thumbnailUrl'] as String,
      url: map['url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Photo.fromJson(String source) => Photo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Photo(title: $title, thumbnailUrl: $thumbnailUrl, url: $url)';

  @override
  bool operator ==(covariant Photo other) {
    if (identical(this, other)) return true;

    return other.title == title && other.thumbnailUrl == thumbnailUrl && other.url == url;
  }

  @override
  int get hashCode => title.hashCode ^ thumbnailUrl.hashCode ^ url.hashCode;
}
