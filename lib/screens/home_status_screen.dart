import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:travel/config/session.dart';
import 'package:travel/config/url.dart';
import 'package:travel/utils/dimensions_utils.dart';
import 'package:travel/utils/rgb_utils.dart';

class HomeStatusScreen extends StatefulWidget {
  const HomeStatusScreen({super.key});

  @override
  State<HomeStatusScreen> createState() => _HomeStatusScreenState();
}

class _HomeStatusScreenState extends State<HomeStatusScreen> {
  bool isLoaded = false;
  String totalCustomer = '';
  String totalOrder = '';
  String totalOutstanding = '0';
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
      child: isLoaded
          ? ListView(
              children: [
                Container(
                  padding: const EdgeInsets.all(
                    Dimensions.defaultSize,
                  ),
                  margin: const EdgeInsets.only(
                    bottom: Dimensions.defaultSize,
                  ),
                  decoration: BoxDecoration(
                    color: RGB.white,
                    border: Border.all(
                      width: 1,
                      color: RGB.border,
                    ),
                    borderRadius: BorderRadius.circular(
                      Dimensions.radiusSize,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(
                          Dimensions.defaultSize,
                        ),
                        decoration: BoxDecoration(
                          color: RGB.succeeLight,
                          borderRadius: BorderRadius.circular(
                            Dimensions.circleSize,
                          ),
                        ),
                        child: const Icon(
                          Icons.groups_2_outlined,
                          color: RGB.white,
                        ),
                      ),
                      const SizedBox(
                        width: Dimensions.smSize,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Total Customers',
                            style: TextStyle(
                              fontSize: Dimensions.defaultSize,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            totalCustomer,
                            style: const TextStyle(
                              fontSize: Dimensions.defaultSize,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: Dimensions.defaultSize / 2,
                ),
                Container(
                  padding: const EdgeInsets.all(
                    Dimensions.defaultSize,
                  ),
                  margin: const EdgeInsets.only(
                    bottom: Dimensions.defaultSize,
                  ),
                  decoration: BoxDecoration(
                    color: RGB.white,
                    border: Border.all(
                      width: 1,
                      color: RGB.border,
                    ),
                    borderRadius: BorderRadius.circular(
                      Dimensions.radiusSize,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(
                          Dimensions.defaultSize,
                        ),
                        decoration: BoxDecoration(
                          color: RGB.blue,
                          borderRadius: BorderRadius.circular(
                            Dimensions.circleSize,
                          ),
                        ),
                        child: const Icon(
                          Icons.shopping_bag_outlined,
                          color: RGB.white,
                        ),
                      ),
                      const SizedBox(
                        width: Dimensions.smSize,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Total Orders',
                            style: TextStyle(
                              fontSize: Dimensions.defaultSize,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            totalOrder,
                            style: const TextStyle(
                              fontSize: Dimensions.defaultSize,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: Dimensions.defaultSize / 2,
                ),
                Container(
                  padding: const EdgeInsets.all(
                    Dimensions.defaultSize,
                  ),
                  margin: const EdgeInsets.only(
                    bottom: Dimensions.defaultSize,
                  ),
                  decoration: BoxDecoration(
                    color: RGB.white,
                    border: Border.all(
                      width: 1,
                      color: RGB.border,
                    ),
                    borderRadius: BorderRadius.circular(
                      Dimensions.radiusSize,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(
                          Dimensions.defaultSize,
                        ),
                        decoration: BoxDecoration(
                          color: RGB.darkYellow,
                          borderRadius: BorderRadius.circular(
                            Dimensions.circleSize,
                          ),
                        ),
                        child: const Icon(
                          Icons.receipt_outlined,
                          color: RGB.white,
                        ),
                      ),
                      const SizedBox(
                        width: Dimensions.smSize,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Total Outstanding',
                            style: TextStyle(
                              fontSize: Dimensions.defaultSize,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'RM$totalOutstanding',
                            style: const TextStyle(
                              fontSize: Dimensions.defaultSize,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: Dimensions.defaultSize / 2,
                ),
                const Text('Overdue Payment'),
                // due payment
                if (dataList.isNotEmpty) ...[
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: dataList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(
                          Dimensions.defaultSize,
                        ),
                        margin: const EdgeInsets.only(
                          bottom: Dimensions.defaultSize / 2,
                        ),
                        decoration: BoxDecoration(
                          color: RGB.white,
                          border: Border.all(
                            width: 1,
                            color: RGB.border,
                          ),
                          borderRadius: BorderRadius.circular(
                            Dimensions.radiusSize,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(dataList[index]['name']),
                            Text(dataList[index]['payment_date']),
                            Text('RM${dataList[index]['paid_amount']}'),
                          ],
                        ),
                      );
                    },
                  ),
                ] else ...[
                  Container(
                    padding: const EdgeInsets.all(
                      Dimensions.defaultSize,
                    ),
                    margin: const EdgeInsets.only(
                      bottom: Dimensions.defaultSize,
                    ),
                    decoration: BoxDecoration(
                      color: RGB.white,
                      border: Border.all(
                        width: 1,
                        color: RGB.border,
                      ),
                      borderRadius: BorderRadius.circular(
                        Dimensions.radiusSize,
                      ),
                    ),
                    child: const Text('There is no any overdue!'),
                  ),
                ],
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
    Response cResponse = await Dio().post(
      URL.customerURL,
      data: FormData.fromMap({
        'agent_id': sessionUser['id'].toString(),
      }),
    );
    Response oResponse = await Dio().post(
      URL.orderURL,
      data: FormData.fromMap({
        'agent_id': sessionUser['id'].toString(),
      }),
    );
    Response dueResponse = await Dio().post(
      URL.outstandingURL,
      data: FormData.fromMap({
        'agent_id': sessionUser['id'].toString(),
      }),
    );
    try {
      totalCustomer = cResponse.data['data'].length.toString();
    } catch (e) {
      totalCustomer = '0';
    }
    try {
      totalOrder = oResponse.data['data'].length.toString();
    } catch (e) {
      totalOrder = '0';
    }
    try {
      totalOutstanding =
          dueResponse.data['outstanding'][0]['outstanding'].toString();
      dataList = dueResponse.data['data'];
    } catch (e) {
      totalOutstanding = '0';
    }
    isLoaded = true;

    if (mounted) {
      setState(() {});
    }
  }
}
