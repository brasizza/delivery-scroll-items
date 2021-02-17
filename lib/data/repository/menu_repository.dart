import 'package:dio/dio.dart';
import 'package:menu_scroll_delivery_fluid/data/model/album_model.dart';
import 'package:menu_scroll_delivery_fluid/data/photo.dart';

class MenuRepository {
  static MenuRepository _instance;
  final _dio = Dio();
  MenuRepository._();
  static MenuRepository get instance {
    _instance ??= MenuRepository._();
    return _instance;
  }

  Future<List<Album>> getAlbunsWithPhotos() async {
    Response responseAlbum = await _dio.get('https://jsonplaceholder.typicode.com/albums');
    List<dynamic> resultAlbum = [];
    List<Album> albums = [];
    if (responseAlbum.statusCode != 200) {
      throw Exception("Error to get some data!");
    }

    try {
      resultAlbum = responseAlbum.data;

      await Future.forEach(resultAlbum, (data) async {
        List<Photo> _photo = await getPhotosFromAlbum(data['id']);
        Album _album = Album.fromMap(data);
        _album.photos.clear();
        _album.photos.addAll(_photo);
        albums.add(_album);
      });

      return albums;
      // await Future.forEach((data) async {
      //   List<Photo> _photo = await getPhotosFromAlbum(data['id']);

      //   Album _album = Album.fromMap(data);
      //   _album.photos.addAll(_photo);
      //   albums.add(_album);
      // });
      // return resultAlbum.data.map<Album>((map) {
      //   return Album.fromMap(map);
      // }).toList();
    } catch (e) {
      throw Exception("Fail to get the albums");
    }
  }

  Future<List<Photo>> getPhotosFromAlbum(int id) async {
    try {
      Response responsePhoto = await _dio.get("https://jsonplaceholder.typicode.com/photos?albumId=$id");
      if (responsePhoto.statusCode == 200) {
        List<Photo> listPhotos = responsePhoto.data.map<Photo>((map) {
          return Photo.fromMap(map);
        }).toList();

        return listPhotos;
      } else {
        throw Exception("Fail to get the photos");
      }
    } catch (e) {
      throw Exception("Fail to get the photos");
    }
  }
}
