import 'package:get/get.dart';
import 'package:mcapp/screens/auth/login_screen.dart';
import 'package:mcapp/screens/customer_add_screen.dart';
import 'package:mcapp/screens/customer_details_screen.dart';
import 'package:mcapp/screens/customer_list_screen.dart';
import 'package:mcapp/screens/order_add_screen.dart';
import 'package:mcapp/screens/order_details_screen.dart';
import 'package:mcapp/screens/product_list_screen.dart';
import 'package:mcapp/screens/home_screen.dart';
import 'package:mcapp/screens/splash_screen.dart';

class Routes {
  static final routes = [
    GetPage(name: '/', page: () => const SplashScreen()),
    GetPage(name: '/login', page: () => const LoginScreen()),
    GetPage(name: '/home', page: () => const HomeScreen()),
    GetPage(name: '/product_list', page: () => const ProductListScreen()),
    GetPage(name: '/customer_list', page: () => const CustomerListScreen()),
    GetPage(
        name: '/customer_details', page: () => const CustomerDetailsScreen()),
    GetPage(name: '/add_order', page: () => const OrderAddScreen()),
    GetPage(name: '/add_customer', page: () => const CustomerAddScreen()),
    GetPage(name: '/order_details', page: () => const OrderDetailsScreen()),
  ];
}
