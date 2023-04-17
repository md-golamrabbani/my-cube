import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mcapp/utils/dimensions_utils.dart';
import 'package:mcapp/utils/rgb_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomerDetailsScreen extends StatefulWidget {
  const CustomerDetailsScreen({super.key});

  @override
  State<CustomerDetailsScreen> createState() => _CustomerDetailsScreenState();
}

class _CustomerDetailsScreenState extends State<CustomerDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RGB.white,
      appBar: AppBar(
        title: const Text('Customer Details'),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: Dimensions.defaultSize,
              ),
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                  imageUrl: Get.parameters['ic_picture'].toString(),
                  width: 140,
                  height: 140,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Image.asset(
                    'assets/images/no.jpg',
                    width: 140,
                    height: 140,
                    fit: BoxFit.cover,
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/images/no.jpg',
                    width: 140,
                    height: 140,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            customerView('Name', Get.parameters['name'].toString()),
            customerView('Address', Get.parameters['address'].toString()),
            customerView('Contact', Get.parameters['contact'].toString()),
            customerView(
                'Contact Person', Get.parameters['contact_person'].toString()),
            customerView('SSM', Get.parameters['ssm'].toString()),
            customerView(
              'Register Date',
              DateFormat('d MMM y').format(
                DateTime.parse(Get.parameters['created_at'].toString()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customerView(String title, String value) {
    return Container(
      color: RGB.light,
      padding: const EdgeInsets.symmetric(
        vertical: Dimensions.smSize,
        horizontal: Dimensions.defaultSize,
      ),
      margin: const EdgeInsets.only(
        bottom: Dimensions.smSize,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: Dimensions.defaultSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
