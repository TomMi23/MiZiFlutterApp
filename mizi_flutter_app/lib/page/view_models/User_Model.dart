import 'package:app/api/bean/UserEntity.dart';
import 'package:app/common/global/Storage_Manager.dart';
import 'package:app/common/provider/View_State_Model.dart';


class UserModel extends ViewStateModel {
  static const String kUser = 'kUser';

  UserEntity _user;

  UserEntity get user => _user;

  bool get hasUser => user != null;

  UserModel() {
    var userMap = StorageManager.localStorage.getItem(kUser);
    _user = userMap != null ? UserEntity.fromJson(userMap) : null;
  }

  saveUser(UserEntity user) {
    _user = user;
    notifyListeners();
    StorageManager.localStorage.setItem(kUser, user);
  }

  /// 清除持久化的用户数据
  clearUser() {
    _user = null;
    notifyListeners();
    StorageManager.localStorage.deleteItem(kUser);
  }
}