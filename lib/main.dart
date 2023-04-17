import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mcapp/routes/routes.dart';
import 'package:mcapp/theme/light_theme.dart';
import 'package:mcapp/utils/navigator_key.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // systemUI init
  LightTheme.systemUI;
  // DeviceOrientation init
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then(
    (_) => runApp(
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: LightTheme.lightThemeData,
        initialRoute: '/',
        getPages: Routes.routes,
        navigatorKey: navigatorKey,
        builder: EasyLoading.init(),
      ),
    ),
  );
}
