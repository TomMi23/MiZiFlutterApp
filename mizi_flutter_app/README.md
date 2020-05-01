# Mi App

## 我学习Flutter

致力于打造一套基础的Flutter框架
## 2020年5月01日
### 开发内容
1.终于把执行Flutter upgrade造成的"崩溃"问题解决了。
记录一下新路历程太难了。
执行完Flutter upgrade之后就无法运行了，怎么办那？
在Android Studio里重新设置SDK路径，无果。
那么就索性根据提示咱就升级，升级之后翻墙也不行，只能下载升级包来手动处理。
（不明白我都能翻墙下载升级包了，而自动升级就是下载不下来升级包？？？？）
接下来把升级包"dart-sdk-darwin-x64.zip"放到"flutter-sdk/bin/cache/" 目录下，
放置好之后打开/bin/internal/update_dart_sdk.sh文件，<font color='red'>注释掉以下行.
(注意以下行，有些内容不用注释掉，看清楚)
</font>
~~~
  rm -rf -- "$DART_SDK_PATH"
  mkdir -m 755 -p -- "$DART_SDK_PATH"

  curl --continue-at - --location --output "$DART_SDK_ZIP" "$DART_SDK_URL" 2>&1 || {
    echo
    echo "Failed to retrieve the Dart SDK from: $DART_SDK_URL"
    echo "If you're located in China, please see this page:"
    echo "  https://flutter.io/community/china"
    echo
    rm -f -- "$DART_SDK_ZIP"
    exit 1
  }
~~~

紧接着修改"flutter.gradle"文件，目录在"flutter-sdk/packages/flutter_tools/gradle"下。
修改如下：
~~~ python
repositories {
        //google()
        //jcenter()
        maven { url 'https://maven.aliyun.com/repository/google' }
        maven { url 'https://maven.aliyun.com/repository/jcenter' }
        maven { url 'http://maven.aliyun.com/nexus/content/groups/public' }
}
~~~
执行flutter doctor 命令，可能会报错等待时间过长的问题。直接关掉重新来，多来几次就好了

如果还不行执行以下命令
~~~
   export PUB_HOSTED_URL=https://pub.flutter-io.cn
   export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
   flutter doctor
~~~

等待成功吧。

## 2020年4月30日 开发
### 开发内容
1.今天把蓝牙插件开发了，但是Flutter由于我昨天执行了一个Flutter upgrade命令
结果今天就崩了。晚上回家翻墙倒腾一下。


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





