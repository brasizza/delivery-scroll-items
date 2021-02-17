import 'package:menu_scroll_delivery_fluid/data/model/album_model.dart';
import 'package:menu_scroll_delivery_fluid/data/repository/menu_repository.dart';

class MenuService {
  static MenuService _instance;
  static MenuRepository _repository = MenuRepository.instance;

  MenuService._();
  static MenuService get instance {
    _instance ??= MenuService._();
    return _instance;
  }

/* This example i will use https://jsonplaceholder.typicode.com/ */
  Future<List<Album>> buildData() async {
    return await _repository.getAlbunsWithPhotos();
  }
}
