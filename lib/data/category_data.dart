import 'package:flutter/material.dart';
import 'package:travel/models/category_model.dart';

List categoryData = [
  CategoryModel(
    name: 'Hotels',
    routeName: 'hotel',
    icon: Icons.apartment_outlined,
  ),
  CategoryModel(
    name: 'Cars',
    routeName: 'car',
    icon: Icons.local_taxi_outlined,
  ),
  CategoryModel(
    name: 'Packages',
    routeName: 'package',
    icon: Icons.redeem_outlined,
  ),
];
