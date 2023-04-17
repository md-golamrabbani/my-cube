import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:mcapp/config/session.dart';
import 'package:mcapp/config/url.dart';
import 'package:mcapp/utils/dimensions_utils.dart';
import 'package:mcapp/utils/rgb_utils.dart';
import 'package:mcapp/utils/snackbar__utils.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;

class OrderAddScreen extends StatefulWidget {
  const OrderAddScreen({super.key});

  @override
  State<OrderAddScreen> createState() => _OrderAddScreenState();
}

class _OrderAddScreenState extends State<OrderAddScreen> {
  DateTime selectedDate = DateTime.now();
  // other
  Map sessionUser = {};

  // val
  String customerId = Get.parameters['id'].toString();
  String productId = "";
  String customerName = Get.parameters['name'].toString();
  String productName = "Select Product";

  @override
  void initState() {
    super.initState();
    initApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RGB.white,
      appBar: AppBar(
        elevation: 1,
        title: const Text('Add Order'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: Dimensions.lgSize * 2,
              horizontal: Dimensions.defaultSize,
            ),
            decoration: BoxDecoration(
              color: RGB.muted.withOpacity(0.5),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(
                  Dimensions.defaultSize * 2,
                ),
                bottomRight: Radius.circular(
                  Dimensions.defaultSize * 2,
                ),
              ),
            ),
            child: Center(
              child: Image.asset(
                'assets/images/shopping-bag.png',
                width: 50,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(
                  Dimensions.defaultSize,
                ),
                margin: const EdgeInsets.only(
                  top: Dimensions.defaultSize,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Customer Name'),
                    GestureDetector(
                      onTap: () async {
                        var result = await Get.toNamed('customer_list');
                        if (result != null) {
                          customerId = result['id'];
                          customerName = result['name'];
                          setState(() {});
                        }
                      },
                      child: Container(
                        width: Get.width,
                        padding: const EdgeInsets.symmetric(
                          vertical: Dimensions.defaultSize,
                          horizontal: Dimensions.defaultSize,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 0.5,
                            color: RGB.border,
                          ),
                          borderRadius: BorderRadius.circular(
                            Dimensions.radiusSize,
                          ),
                        ),
                        child: Text(customerName),
                      ),
                    ),
                    const SizedBox(height: Dimensions.lgSize),
                    const Text('Product Name'),
                    GestureDetector(
                      onTap: () async {
                        var result = await Get.toNamed('product_list');
                        if (result != null) {
                          productId = result['id'];
                          productName = result['name'];
                          setState(() {});
                        }
                      },
                      child: Container(
                        width: Get.width,
                        padding: const EdgeInsets.symmetric(
                          vertical: Dimensions.defaultSize,
                          horizontal: Dimensions.defaultSize,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 0.5,
                            color: RGB.border,
                          ),
                          borderRadius: BorderRadius.circular(
                            Dimensions.radiusSize,
                          ),
                        ),
                        child: Text(productName),
                      ),
                    ),
                    const SizedBox(height: Dimensions.lgSize),
                    const Text('Installation Date'),
                    GestureDetector(
                      onTap: () {
                        selectDate(context);
                      },
                      child: Container(
                        width: Get.width,
                        padding: const EdgeInsets.symmetric(
                          vertical: Dimensions.defaultSize,
                          horizontal: Dimensions.defaultSize,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 0.5,
                            color: RGB.border,
                          ),
                          borderRadius: BorderRadius.circular(
                            Dimensions.defaultSize / 2,
                          ),
                        ),
                        child: Text(
                          DateFormat.yMMMMd("en_US")
                              .format(selectedDate)
                              .toString(),
                        ),
                      ),
                    ),
                    const SizedBox(height: Dimensions.lgSize),
                    ElevatedButton(
                      onPressed: () async {
                        if (customerId != '' && productId != '') {
                          EasyLoading.show(status: 'loading...');
                          // call api part
                          FormData formData = FormData.fromMap({
                            'agent_id': sessionUser['id'].toString(),
                            'customer_id': customerId,
                            'product_id': productId,
                            'start_date': selectedDate,
                          });
                          try {
                            Response response = await Dio().post(
                              URL.orderAddURL,
                              data: formData,
                            );
                            Map data = response.data;
                            if (data['error']) {
                              SnackBarUtils.show(
                                  title: data['messages'], isError: true);
                            } else {
                              SnackBarUtils.show(
                                  title: data['messages'], isError: false);
                              if (mounted) {
                                Navigator.pop(context, {
                                  'id': 1,
                                  'data': data['data'],
                                });
                              }
                            }
                          } catch (e) {
                            SnackBarUtils.show(
                                title: e.toString(), isError: true);
                          }
                          customerId = '';
                          productId = '';
                          customerName = "Select Customer";
                          productName = "Select Product";
                          setState(() {});
                          EasyLoading.dismiss();
                        } else {
                          SnackBarUtils.show(
                              title: 'Customer & Product Required!',
                              isError: true);
                        }
                      },
                      child: SizedBox(
                        width: Get.width,
                        child: const Text(
                          'Order Now',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(height: Dimensions.lgSize),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // functional task
  void initApp() async {
    sessionUser = await Session().user();
    if (mounted) {
      setState(() {});
    }
  }

  Future selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}
