import 'package:flutter/material.dart';
import 'package:provider_uy_ishi_http/model/model.dart';
import 'package:provider_uy_ishi_http/servis/network.dart';

class CounterViewModel extends ChangeNotifier {

  List<Todo> _todo = [];
  List<Album> _album = [];
  List<Posts> _post = [];
  List<User> _users = [];
  List<Comment> _coment = [];
  List<Photos> _photos = [];
  bool _setLoading = true;

  bool get setLoading => _setLoading;


  List<User> get users => _users;
  List<Todo> get todo => _todo;
  List<Posts> get posts => _post;
  List<Album> get albums => _album;
  List<Comment> get coment => _coment;
  List<Photos> get photos => _photos;

  void onPressUsers() {
    Network.getUser(Network.apiUser, null).then((value) {
      if (value != null) {
        _users = value;
        notifyListeners();
      }
    });
  }
  void onPressTodo(int userId) {
    Network.getTodo(Network.apiTodo, {"userId": "$userId"}).then((value) {
      if (value != null) {
        _todo = value;
        notifyListeners();
      }
    });
  }
  void onPressAlbum(int userId) {
    Network.getAlbums(Network.apiAlbum, {"userId": "$userId"}).then((value) {
      if (value != null) {
        _album = value;
        notifyListeners();
      }
    });
  }
  void onPressPosts(int userId) {
    Network.getPosts(Network.apiPost, {"userId": "$userId"}).then((value) {
      if (value != null) {
        _post = value;
        notifyListeners();
      }
    });
  }
  void onPressComment(int id) {
    Network.getComment(Network.apiComment, {"postId": "${id + 1}"}).then((value) {
      if (value != null) {
        _coment = value;
        notifyListeners();
      }
    });
  }
  void onPressPhotos(int albumId) {
    Network.getPhoto(Network.apiPhoto, {"albumId": "$albumId"}).then((value) {
      if (value != null) {
        _photos = value;
        notifyListeners();
      }
    });
  }

  void onPressLoading() {
    _setLoading = false;
    notifyListeners();
  }
}
