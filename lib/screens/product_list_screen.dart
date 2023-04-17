import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:travel/config/url.dart';
import 'package:travel/utils/dimensions_utils.dart';
import 'package:travel/utils/rgb_utils.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final formKey = GlobalKey<FormState>();
  List searchList = [];
  bool isLoaded = false;
  List productList = [];

  void initApp() async {
    try {
      Response response = await Dio().get(
        URL.productURL,
      );
      Map data = response.data;
      productList = data['data'];
    } catch (e) {
      debugPrint(e.toString());
    }
    isLoaded = true;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RGB.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: SizedBox(
          height: 40,
          child: TextFormField(
            keyboardType: TextInputType.text,
            onChanged: (value) {
              searchList = productList
                  .where((e) => e['name'].contains(value.capitalizeFirst))
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
                borderRadius: BorderRadius.circular(Dimensions.radiusSize),
                borderSide: const BorderSide(
                  color: RGB.muted,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimensions.radiusSize),
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
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Padding(
              padding: EdgeInsets.only(
                right: Dimensions.defaultSize,
              ),
              child: Icon(
                Icons.close_outlined,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: isLoaded
            ? searchList.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: searchList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pop(context, {
                            'id': searchList[index]['id'].toString(),
                            'name': searchList[index]['name'].toString(),
                          });
                        },
                        child: Container(
                          width: Get.width,
                          padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.defaultSize,
                            vertical: Dimensions.defaultSize,
                          ),
                          margin: const EdgeInsets.only(
                            bottom: Dimensions.smSize,
                          ),
                          color: RGB.muted.withOpacity(0.5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                searchList[index]['name'],
                                style: const TextStyle(
                                  fontSize: Dimensions.defaultSize,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: productList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pop(context, {
                            'id': productList[index]['id'].toString(),
                            'name': productList[index]['name'].toString(),
                          });
                        },
                        child: Container(
                          width: Get.width,
                          padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.defaultSize,
                            vertical: Dimensions.defaultSize,
                          ),
                          margin: const EdgeInsets.only(
                            bottom: Dimensions.smSize,
                          ),
                          color: RGB.muted.withOpacity(0.5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                productList[index]['name'],
                                style: const TextStyle(
                                  fontSize: Dimensions.defaultSize,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
