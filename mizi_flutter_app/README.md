# Mi App

## 我学习Flutter

致力于打造一套基础的Flutter框架

## 2020年4月24日 开发
### 开发内容
1.今天把持久化数据访问的问题解决了。主要在main.dart里增加了初始化事件。
runApp(Store.init(child: MyApp()));
这样就全局可以访问provider了。后续我会根据每个知识点写一点东西。

### 待解决的问题
深入研究provider、MultiProvider、GlobalKey、StatefulWidget、Widget、State等概念和定义还有使用方法。
在实践中去发现问题和解决问题。

## 2020年4月23日 开发
### 开发内容
1.今天就搞了一个数据持久化访问，但是报错。
Always use package imports. Ex: `import 'package:my_app/my_code.dart';
Ensure the correct `context` is being used.
context 使用有问题

### 文件解读
1.global ->  Storage_Manager.dart
这个文件主要是全局的一些信息，其中有LocalStorage用于数据访问。
在mian.dart 的构造函数中调用：await StorageManager.init();

2.api -> bean -> UserEntity.dart
用户的实体类

3.local -> LocalStorage.dart
SharedPreferences 本地存储类。这个类主要提供了save、remove、get三个方法。

4.provider -> Provider_Store.dart
数据状态管理类。提供数据访问的方法

5.provider ->View_State.dart
一个View的状态类，这里是一个枚举类型。我随便列了几个

6.provider ->View_State_Model.dart
页面状态的模型，包含disposed、idle, busy, empty, error, unAuthorized等。

7.utils -> Sp_Util.dart
工具类。getString、setSting等等。

8.page -> view_models -> User_Model.dart
用户模型类，主要处理UserEntity实体类的内容，clearUser清除数据、saveUser保存数据，获取数据等。

### 遗留问题
在MyTabPage.dart设置用户信息后，在LoginPage.dart读取，并且重新设置。但是报错。



## 2020年4月22日 开发
### 开发内容
1.把Heard的相关内容放到Config里。

### 遗留问题
1.虽然把Heard的相关内容放到Config里，但是有些变量需要在全局变量或者Native端取，还需要考虑获取方式。

## 2020年4月21日 开发

### 开发内容
1.今日把Splash页面单独出来，想想引导页也可能是个业务会有相关的处理。
2.把与Native交互的内容添加，方便日后使用

### 遗留问题
1.ConnectivityBroadcastReceiver.java使用或覆盖了已过时的 API。
  注: 有关详细信息, 请使用 -Xlint:deprecation 重新编译。
  有时间改进一下

2.DeviceUtils.java使用或覆盖了已过时的 API。
  注: 有关详细信息, 请使用 -Xlint:deprecation 重新编译。
 DeviceUtils.java是从别的项目里copy过来的，里面有很多内容还需要改。

3.Net 包未添加

4.Flutter Toast问题还没有解决





