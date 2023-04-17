import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:mcapp/config/session.dart';
import 'package:mcapp/config/url.dart';
import 'package:mcapp/utils/dimensions_utils.dart';
import 'package:mcapp/utils/rgb_utils.dart';
import 'package:mcapp/utils/snackbar__utils.dart';
import 'package:unicons/unicons.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  bool isFound = false;
  bool isLoaded = false;
  List dataList = [];

  @override
  void initState() {
    super.initState();
    apiCall();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: RGB.light,
      padding: const EdgeInsets.all(
        Dimensions.defaultSize,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () async {
                  var result = await Get.toNamed('/add_customer');
                  if (result != null) {
                    if (result['id'] == 1) {
                      dataList = result['data'];
                      setState(() {});
                    }
                  }
                },
                child: const Text('Add Customer'),
              ),
            ],
          ),
          const SizedBox(
            height: Dimensions.smSize,
          ),
          Container(
            width: Get.width,
            padding: const EdgeInsets.symmetric(
              vertical: Dimensions.smSize,
              horizontal: Dimensions.defaultSize,
            ),
            margin: const EdgeInsets.only(
              bottom: Dimensions.smSize,
            ),
            decoration: BoxDecoration(
              color: RGB.white,
              borderRadius: BorderRadius.circular(
                Dimensions.radiusSize,
              ),
            ),
            child: const Text('List of Customers'),
          ),
          isLoaded
              ? isFound
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: dataList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Get.toNamed('/customer_details', parameters: {
                                'id': dataList[index]['id'].toString(),
                                'name': dataList[index]['name'].toString(),
                                'address':
                                    dataList[index]['address'].toString(),
                                'contact':
                                    dataList[index]['contact'].toString(),
                                'contact_person': dataList[index]
                                        ['contact_person']
                                    .toString(),
                                'ic_picture': URL.imageURL +
                                    dataList[index]['ic_picture'].toString(),
                                'ssm': dataList[index]['ssm'].toString(),
                                'created_at':
                                    dataList[index]['created_at'].toString(),
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: Dimensions.smSize,
                                horizontal: Dimensions.defaultSize,
                              ),
                              margin: const EdgeInsets.only(
                                bottom: Dimensions.smSize,
                              ),
                              decoration: BoxDecoration(
                                color: RGB.white,
                                borderRadius: BorderRadius.circular(
                                  Dimensions.radiusSize,
                                ),
                              ),
                              child: ListTile(
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                                leading: Container(
                                  padding: const EdgeInsets.all(
                                    Dimensions.smSize / 2,
                                  ),
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: RGB.muted,
                                    borderRadius: BorderRadius.circular(
                                      Dimensions.circleSize,
                                    ),
                                  ),
                                  child: const Icon(UniconsLine.user),
                                ),
                                title: Text(dataList[index]['name']),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(dataList[index]['address']),
                                  ],
                                ),
                                trailing: ElevatedButton(
                                  onPressed: () async {
                                    await Get.toNamed(
                                      '/add_order',
                                      parameters: {
                                        'id': dataList[index]['id'].toString(),
                                        'name':
                                            dataList[index]['name'].toString(),
                                      },
                                    );
                                    apiCall();
                                  },
                                  child: const Text('Add Order'),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : const Center(
                      child: Text('Customer record not found!'),
                    )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ],
      ),
    );
  }

  // api call
  void apiCall() async {
    Map sessionUser = await Session().user();
    // call api part
    try {
      Response response = await Dio().post(
        URL.customerURL,
        data: FormData.fromMap({
          'agent_id': sessionUser['id'].toString(),
        }),
      );
      Map data = response.data;
      if (data['error']) {
        isLoaded = true;
        isFound = false;
        SnackBarUtils.show(title: data['messages'], isError: true);
      } else {
        isLoaded = true;
        isFound = true;
        dataList = data['data'];
      }
    } catch (e) {
      SnackBarUtils.show(title: e.toString(), isError: true);
    }
    if (mounted) {
      setState(() {});
    }
  }
}
