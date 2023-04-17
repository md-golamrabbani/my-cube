import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:intl/intl.dart';
import 'package:mcapp/config/session.dart';
import 'package:mcapp/config/url.dart';
import 'package:mcapp/utils/dimensions_utils.dart';
import 'package:mcapp/utils/rgb_utils.dart';
import 'package:mcapp/utils/snackbar__utils.dart';
import 'package:unicons/unicons.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  bool isFound = false;
  bool isLoaded = false;
  List dataList = [];
  List searchList = [];

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
      child: isLoaded
          ? Column(
              children: [
                Container(
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('List of Services'),
                      const SizedBox(
                        height: Dimensions.smSize / 2,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          searchList = dataList
                              .where(
                                (e) =>
                                    e['cname']
                                        .replaceAll(' ', '')
                                        .replaceAll('-', '')
                                        .replaceAll('0', '')
                                        .toLowerCase()
                                        .contains(
                                          value
                                              .replaceAll(' ', '')
                                              .replaceAll('-', '')
                                              .replaceAll('0', '')
                                              .toLowerCase(),
                                        ) ||
                                    e['pname']
                                        .replaceAll(' ', '')
                                        .replaceAll('-', '')
                                        .replaceAll('0', '')
                                        .toLowerCase()
                                        .contains(
                                          value
                                              .replaceAll(' ', '')
                                              .replaceAll('-', '')
                                              .replaceAll('0', '')
                                              .toLowerCase(),
                                        ),
                              )
                              .toList();
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: RGB.lightDarker,
                            ),
                          ),
                          hintText: 'Search',
                          fillColor: RGB.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radiusSize),
                            borderSide: const BorderSide(
                              color: RGB.muted,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radiusSize),
                            borderSide: const BorderSide(
                              color: RGB.muted,
                              width: 1,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.smSize,
                          ),
                        ),
                        cursorColor: RGB.dark,
                      ),
                    ],
                  ),
                ),
                isFound
                    ? Expanded(
                        child: searchList.isEmpty
                            ? ListView.builder(
                                itemCount: dataList.length,
                                itemBuilder: (context, index) {
                                  return Container(
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
                                      onTap: () {
                                        Get.toNamed('/order_details',
                                            parameters: {
                                              'id': dataList[index]['id']
                                                  .toString(),
                                              'invoice_id': dataList[index]
                                                      ['invoice_id']
                                                  .toString(),
                                              'monthly_rate': dataList[index]
                                                      ['monthly_rate']
                                                  .toString(),
                                              'paid': dataList[index]['paid']
                                                  .toString(),
                                              'totalInstalments':
                                                  dataList[index]
                                                          ['totalInstalments']
                                                      .toString(),
                                            });
                                      },
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
                                        child: const Icon(UniconsLine.bag),
                                      ),
                                      title: Text(dataList[index]['cname']),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                dataList[index]['pname'],
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                              // ignore: prefer_interpolation_to_compose_strings
                                              Text('RM' +
                                                  dataList[index]
                                                      ['monthly_rate']),
                                            ],
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      vertical:
                                                          Dimensions.smSize / 4,
                                                      horizontal:
                                                          Dimensions.smSize / 2,
                                                    ),
                                                    decoration: BoxDecoration(
                                                        color: RGB.muted
                                                            .withOpacity(0.25),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          Dimensions.radiusSize,
                                                        )),
                                                    child: Text(
                                                      DateFormat('d MMM')
                                                          .format(
                                                        DateTime.parse(
                                                            dataList[index]
                                                                ['start_date']),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width:
                                                        Dimensions.smSize / 2,
                                                  ),
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      vertical:
                                                          Dimensions.smSize / 4,
                                                      horizontal:
                                                          Dimensions.smSize / 2,
                                                    ),
                                                    decoration: BoxDecoration(
                                                        color: RGB.muted
                                                            .withOpacity(0.25),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          Dimensions.radiusSize,
                                                        )),
                                                    child: Text(
                                                      '${dataList[index]['completedInstalments']}/${dataList[index]['totalInstalments']}',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                // ignore: prefer_interpolation_to_compose_strings
                                                'Total RM' +
                                                    dataList[index]['paid'],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )
                            : ListView.builder(
                                itemCount: searchList.length,
                                itemBuilder: (context, index) {
                                  return Container(
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
                                      onTap: () {
                                        Get.toNamed('/order_details',
                                            parameters: {
                                              'id': searchList[index]['id']
                                                  .toString(),
                                              'invoice_id': searchList[index]
                                                      ['invoice_id']
                                                  .toString(),
                                              'monthly_rate': searchList[index]
                                                      ['monthly_rate']
                                                  .toString(),
                                              'paid': searchList[index]['paid']
                                                  .toString(),
                                              'totalInstalments':
                                                  searchList[index]
                                                          ['totalInstalments']
                                                      .toString(),
                                            });
                                      },
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
                                        child: const Icon(UniconsLine.bag),
                                      ),
                                      title: Text(searchList[index]['cname']),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                searchList[index]['pname'],
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                              // ignore: prefer_interpolation_to_compose_strings
                                              Text('RM' +
                                                  searchList[index]
                                                      ['monthly_rate']),
                                            ],
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      vertical:
                                                          Dimensions.smSize / 4,
                                                      horizontal:
                                                          Dimensions.smSize / 2,
                                                    ),
                                                    decoration: BoxDecoration(
                                                        color: RGB.muted
                                                            .withOpacity(0.25),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          Dimensions.radiusSize,
                                                        )),
                                                    child: Text(
                                                      DateFormat('d MMM')
                                                          .format(
                                                        DateTime.parse(
                                                            searchList[index]
                                                                ['start_date']),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width:
                                                        Dimensions.smSize / 2,
                                                  ),
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      vertical:
                                                          Dimensions.smSize / 4,
                                                      horizontal:
                                                          Dimensions.smSize / 2,
                                                    ),
                                                    decoration: BoxDecoration(
                                                        color: RGB.muted
                                                            .withOpacity(0.25),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          Dimensions.radiusSize,
                                                        )),
                                                    child: Text(
                                                      '${searchList[index]['completedInstalments']}/${searchList[index]['totalInstalments']}',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                // ignore: prefer_interpolation_to_compose_strings
                                                'Total RM' +
                                                    searchList[index]['paid'],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                      )
                    : const Center(
                        child: Text('Order record not found!'),
                      )
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  // api call
  void apiCall() async {
    Map sessionUser = await Session().user();
    // call api part
    try {
      Response response = await Dio().post(
        URL.orderURL,
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
