import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:mcapp/config/session.dart';
import 'package:mcapp/config/url.dart';
import 'package:mcapp/screens/customer_screen.dart';
import 'package:mcapp/screens/order_screen.dart';
import 'package:mcapp/utils/dimensions_utils.dart';
import 'package:mcapp/utils/rgb_utils.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:unicons/unicons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // define field instance
  GlobalKey<ConvexAppBarState> navigationKey = GlobalKey<ConvexAppBarState>();
  Map sessionUser = {};
  int activeIndex = 0;
  // home status
  bool isLoaded = false;
  String totalCustomer = '';
  String totalOrder = '';
  String totalOutstanding = '0';
  List dataList = [];

  List<Widget> widgetOptions = [
    const OrderScreen(),
    const CustomerScreen(),
  ];

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
        automaticallyImplyLeading: false,
        elevation: 1,
        title: Row(
          children: [
            const Icon(Icons.person),
            const SizedBox(
              width: Dimensions.smSize,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sessionUser['name'].toString(),
                  style: const TextStyle(
                    fontSize: Dimensions.defaultSize,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              await Session().userFlash();
              Get.offAllNamed('/login');
            },
            child: Padding(
              padding: const EdgeInsets.only(
                right: Dimensions.defaultSize,
              ),
              child: Row(
                children: const [
                  Icon(Icons.logout_outlined),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: ConvexAppBar(
        key: navigationKey,
        style: TabStyle.react,
        backgroundColor: RGB.white,
        color: RGB.darkLight,
        activeColor: RGB.primary,
        height: 60,
        items: const [
          TabItem(
            icon: UniconsLine.estate,
            title: 'Home',
          ),
          TabItem(
            icon: UniconsLine.shopping_bag,
            title: 'Services',
          ),
          TabItem(
            icon: UniconsLine.user,
            title: 'Customer',
          ),
        ],
        initialActiveIndex: 0,
        onTap: (int i) {
          activeIndex = i;
          if (mounted) {
            if (i == 0) {
              initApp();
            }
            setState(() {});
          }
        },
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (activeIndex == 0) {
              return homeStatus();
            } else if (activeIndex == 1) {
              return const OrderScreen();
            } else {
              return const CustomerScreen();
            }
          },
        ),
      ),
    );
  }

  // functional task
  void initApp() async {
    sessionUser = await Session().user();
    setState(() {});
    // call api part
    Response agentCheckRes = await Dio().post(
      URL.agentCheckURL,
      data: FormData.fromMap({
        'agent_id': sessionUser['id'].toString(),
      }),
    );
    if (agentCheckRes.data['error'] == true) {
      await Session().userFlash();
      Get.offAllNamed('/login');
    }
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

  // home_status_screen
  Widget homeStatus() {
    return Container(
      color: RGB.light,
      padding: const EdgeInsets.all(
        Dimensions.defaultSize,
      ),
      child: isLoaded
          ? ListView(
              children: [
                GestureDetector(
                  onTap: () {
                    activeIndex = 2;
                    navigationKey.currentState?.animateTo(2);
                    setState(() {});
                  },
                  child: Container(
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
                            totalOutstanding == 'null'
                                ? '0'
                                : 'RM$totalOutstanding',
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
                  //  var dayDiff = DateTime.now().difference(DateTime.parse(dataList[index]['payment_date'])).inDays;
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dataList[index]['name'],
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(dataList[index]['payment_date']),
                                Text(
                                    '${DateTime.now().difference(DateTime.parse(dataList[index]['payment_date'])).inDays} days'),
                              ],
                            ),
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
}
