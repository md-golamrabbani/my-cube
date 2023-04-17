import 'dart:math';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:travel/config/url.dart';
import 'package:travel/utils/dimensions_utils.dart';
import 'package:travel/utils/rgb_utils.dart';
import 'package:travel/utils/snackbar__utils.dart';
import 'package:share_plus/share_plus.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  bool isLoaded = false;
  List dataList = [];
  List dataListPaid = [];
  int? paymentId;
  List<MultipartFile>? servicefiles;
  String serviceFileLabel = 'Upload Service Photo';
  String fileLabel = 'Upload Attachment';
  String? pickfile;
  bool isFilePicked = false;
  String? servicePickfile;
  bool isServiceFilePicked = false;
  List<String> paymentType = <String>['Bank', 'Cash', 'eWallet', 'Other'];
  String? dropdownValue;

  String getRandom(int length) {
    const ch = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
    Random r = Random();
    return String.fromCharCodes(
        Iterable.generate(length, (_) => ch.codeUnitAt(r.nextInt(ch.length))));
  }

  @override
  void initState() {
    super.initState();
    dropdownValue = paymentType.first;
    apiCall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RGB.light,
      appBar: AppBar(
        elevation: 1,
        title: const Text('Order View'),
      ),
      body: SafeArea(
        child: isLoaded
            ? Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            bottom: Dimensions.defaultSize,
                          ),
                          color: RGB.white,
                          child: Column(
                            children: [
                              orderInfo(
                                title: 'Order ID',
                                info: Get.parameters['invoice_id'].toString(),
                              ),
                              orderInfo(
                                title: 'Order Amount',
                                info:
                                    'RM${Get.parameters['monthly_rate'].toString()}',
                              ),
                              orderInfo(
                                title: 'Total Payable',
                                info: 'RM${Get.parameters['paid'].toString()}',
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            left: Dimensions.defaultSize,
                            right: Dimensions.defaultSize,
                            bottom: Dimensions.defaultSize / 2,
                          ),
                          child: ElevatedButton(
                            onPressed: () async {
                              statementView(
                                context,
                                Get.parameters['id'].toString(),
                              );
                            },
                            child: const Text('Download Statement'),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(
                            Dimensions.defaultSize,
                          ),
                          margin: const EdgeInsets.only(
                            top: Dimensions.smSize,
                            bottom: Dimensions.defaultSize,
                          ),
                          color: RGB.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Pay in ${Get.parameters['totalInstalments']}',
                                style: const TextStyle(
                                  fontSize: Dimensions.defaultSize + 2,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(
                                height: Dimensions.smSize,
                              ),
                              // paid list
                              if (dataListPaid.isNotEmpty) ...[
                                ListView.builder(
                                  physics: const ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: dataListPaid.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: const EdgeInsets.only(
                                        bottom: Dimensions.defaultSize,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Stack(
                                              clipBehavior: Clip.none,
                                              children: [
                                                if (dataListPaid[index]
                                                        ['is_completed'] ==
                                                    1) ...[
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.check_circle,
                                                        color: RGB.succeeLight,
                                                        size: 28,
                                                      ),
                                                      const SizedBox(
                                                        width:
                                                            Dimensions.smSize /
                                                                3,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () async {
                                                          receiptView(
                                                              context,
                                                              Get.parameters[
                                                                      'id']
                                                                  .toString(),
                                                              dataListPaid[
                                                                  index]['id']);
                                                        },
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            vertical: Dimensions
                                                                    .smSize /
                                                                4,
                                                            horizontal:
                                                                Dimensions
                                                                        .smSize /
                                                                    2,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                RGB.succeeLight,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              Dimensions
                                                                      .smSize /
                                                                  4,
                                                            ),
                                                          ),
                                                          child: Text(
                                                            '${index + 1}/${Get.parameters['totalInstalments']} Paid',
                                                            style:
                                                                const TextStyle(
                                                              color: RGB.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ] else ...[
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                      left: 4,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.circle_outlined,
                                                          color: RGB.border,
                                                          size: 22,
                                                        ),
                                                        const SizedBox(
                                                          width: Dimensions
                                                                  .smSize /
                                                              3,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () async {
                                                            invoiceView(
                                                                context,
                                                                Get.parameters[
                                                                        'id']
                                                                    .toString(),
                                                                dataListPaid[
                                                                        index]
                                                                    ['id']);
                                                          },
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                              vertical: Dimensions
                                                                      .smSize /
                                                                  4,
                                                              horizontal:
                                                                  Dimensions
                                                                          .smSize /
                                                                      2,
                                                            ),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: RGB.muted
                                                                  .withOpacity(
                                                                      0.2),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                Dimensions
                                                                        .smSize /
                                                                    4,
                                                              ),
                                                            ),
                                                            child: Text(
                                                              '${index + 1}/${Get.parameters['totalInstalments']} Pending',
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                                if (index !=
                                                    dataListPaid.length -
                                                        1) ...[
                                                  Positioned(
                                                    left:
                                                        Dimensions.defaultSize -
                                                            2,
                                                    bottom:
                                                        -Dimensions.defaultSize,
                                                    child: Container(
                                                      height: Dimensions.smSize,
                                                      decoration:
                                                          const BoxDecoration(
                                                        border: Border(
                                                          left: BorderSide(
                                                            width: 2,
                                                            color: RGB.border,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ]
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  DateFormat('d MMM y').format(
                                                    DateTime.parse(
                                                        dataListPaid[index]
                                                            ['payment_date']),
                                                  ),
                                                ),
                                                Text(
                                                    'RM${dataListPaid[index]['paid_amount']}'),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                              // due list
                              if (dataList.isNotEmpty) ...[
                                ListView.builder(
                                  physics: const ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  // itemCount: dataList.length,
                                  itemCount: 1,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: const EdgeInsets.only(
                                        bottom: Dimensions.defaultSize,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Stack(
                                              clipBehavior: Clip.none,
                                              children: [
                                                if (dataList[index]
                                                        ['is_completed'] ==
                                                    1) ...[
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.check_circle,
                                                        color: RGB.succeeLight,
                                                        size: 28,
                                                      ),
                                                      const SizedBox(
                                                        width:
                                                            Dimensions.smSize /
                                                                3,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () async {
                                                          receiptView(
                                                              context,
                                                              Get.parameters[
                                                                      'id']
                                                                  .toString(),
                                                              dataList[index]
                                                                  ['id']);
                                                        },
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            vertical: Dimensions
                                                                    .smSize /
                                                                4,
                                                            horizontal:
                                                                Dimensions
                                                                        .smSize /
                                                                    2,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                RGB.succeeLight,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              Dimensions
                                                                      .smSize /
                                                                  4,
                                                            ),
                                                          ),
                                                          child: Text(
                                                            '${index + 1}/${Get.parameters['totalInstalments']} Paid',
                                                            style:
                                                                const TextStyle(
                                                              color: RGB.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ] else ...[
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                      left: 4,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.circle_outlined,
                                                          color: RGB.border,
                                                          size: 22,
                                                        ),
                                                        const SizedBox(
                                                          width: Dimensions
                                                                  .smSize /
                                                              3,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () async {
                                                            invoiceView(
                                                                context,
                                                                Get.parameters[
                                                                        'id']
                                                                    .toString(),
                                                                dataList[index]
                                                                    ['id']);
                                                          },
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                              vertical: Dimensions
                                                                      .smSize /
                                                                  4,
                                                              horizontal:
                                                                  Dimensions
                                                                          .smSize /
                                                                      2,
                                                            ),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: RGB.muted
                                                                  .withOpacity(
                                                                      0.2),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                Dimensions
                                                                        .smSize /
                                                                    4,
                                                              ),
                                                            ),
                                                            child: Text(
                                                              '${index + 1}/${Get.parameters['totalInstalments']} Pending',
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                                if (index !=
                                                    dataList.length - 1) ...[
                                                  Positioned(
                                                    left:
                                                        Dimensions.defaultSize -
                                                            2,
                                                    bottom:
                                                        -Dimensions.defaultSize,
                                                    child: Container(
                                                      height: Dimensions.smSize,
                                                      decoration:
                                                          const BoxDecoration(
                                                        border: Border(
                                                          left: BorderSide(
                                                            width: 2,
                                                            color: RGB.border,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ]
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  DateFormat('d MMM y').format(
                                                    DateTime.parse(
                                                        dataList[index]
                                                            ['payment_date']),
                                                  ),
                                                ),
                                                Text(
                                                    'RM${dataList[index]['paid_amount']}'),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (paymentId != 0) ...[
                    Container(
                      width: Get.width,
                      padding: const EdgeInsets.symmetric(
                        vertical: Dimensions.lgSize,
                        horizontal: Dimensions.defaultSize,
                      ),
                      margin: const EdgeInsets.only(
                        top: Dimensions.defaultSize,
                      ),
                      decoration: const BoxDecoration(
                        color: RGB.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            Dimensions.defaultSize,
                          ),
                          topRight: Radius.circular(
                            Dimensions.defaultSize,
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                allowMultiple: true,
                                type: FileType.custom,
                                allowedExtensions: ['jpg'],
                              );
                              if (result != null) {
                                servicefiles = result.paths
                                    .map((path) =>
                                        MultipartFile.fromFileSync(path!))
                                    .toList();
                                PlatformFile file = result.files.first;
                                servicePickfile = file.path.toString();
                                serviceFileLabel =
                                    result.files.first.name.toString();
                                isServiceFilePicked = true;
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
                              child: Text(
                                serviceFileLabel,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ),
                          const SizedBox(height: Dimensions.lgSize),
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () async {
                                    FilePickerResult? result =
                                        await FilePicker.platform.pickFiles(
                                      type: FileType.custom,
                                      allowedExtensions: ['jpg', 'pdf'],
                                    );
                                    if (result != null) {
                                      PlatformFile file = result.files.first;
                                      pickfile = file.path.toString();
                                      fileLabel =
                                          result.files.single.name.toString();
                                      isFilePicked = true;
                                      setState(() {});
                                    }
                                  },
                                  child: Container(
                                    width: Get.width,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: Dimensions.defaultSize,
                                      horizontal: Dimensions.defaultSize / 4,
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
                                    child: Text(
                                      fileLabel,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: Dimensions.smSize),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 2,
                                    horizontal: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: RGB.border,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      Dimensions.radiusSize,
                                    ),
                                  ),
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    value: dropdownValue,
                                    underline: const SizedBox(),
                                    onChanged: (String? value) {
                                      setState(() {
                                        dropdownValue = value!;
                                      });
                                    },
                                    items: paymentType
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: Dimensions.lgSize),
                          ElevatedButton(
                            onPressed: () async {
                              if (isFilePicked && isServiceFilePicked) {
                                EasyLoading.show(status: 'loading...');
                                // call api part
                                var documentFile = await MultipartFile.fromFile(
                                  pickfile!,
                                );
                                FormData formData = FormData.fromMap({
                                  'id': paymentId,
                                  'payment_type': dropdownValue,
                                  'service_document[]': servicefiles,
                                  'document': documentFile,
                                });
                                Response response = await Dio().post(
                                  URL.instalmentAddURL,
                                  data: formData,
                                  options: Options(
                                    contentType: 'multipart/form-data',
                                  ),
                                );
                                Map data = response.data;
                                EasyLoading.dismiss();
                                if (data['error']) {
                                  SnackBarUtils.show(
                                      title: data['messages'], isError: true);
                                } else {
                                  SnackBarUtils.show(
                                    title: 'Installments request completed!',
                                    isError: false,
                                  );
                                  EasyLoading.dismiss();
                                  Get.back();
                                }
                              } else {
                                SnackBarUtils.show(
                                  title: 'All Document Upload Required!',
                                  isError: true,
                                );
                              }
                            },
                            child: SizedBox(
                              width: Get.width,
                              child: const Text(
                                'Submit',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  // widgets
  Widget orderInfo({
    required String title,
    required String info,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: Dimensions.smSize,
        horizontal: Dimensions.defaultSize,
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: RGB.border,
          ),
        ),
      ),
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.zero,
        title: Text(
          title,
          style: const TextStyle(
            fontSize: Dimensions.defaultSize,
            fontWeight: FontWeight.w800,
          ),
        ),
        trailing: Text(info),
      ),
    );
  }

  // api call
  void apiCall() async {
    // call api part
    try {
      Response response = await Dio().post(
        URL.instalmentURL,
        data: FormData.fromMap({
          'id': Get.parameters['id'].toString(),
        }),
      );
      Map data = response.data;
      if (data['error']) {
        isLoaded = true;
        SnackBarUtils.show(title: data['messages'], isError: true);
      } else {
        dataList = data['dataDue'];
        dataListPaid = data['dataPaid'];
        paymentId = data['payment_id'];
        isLoaded = true;
      }
    } catch (e) {
      SnackBarUtils.show(title: e.toString(), isError: true);
    }
    if (mounted) {
      setState(() {});
    }
  }

  // invoice pdf view
  static void invoiceView(
      BuildContext context, String id, dynamic instalment) async {
    showModalBottomSheet(
        context: context,
        backgroundColor: RGB.white,
        enableDrag: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              Dimensions.defaultSize,
            ),
            topRight: Radius.circular(
              Dimensions.defaultSize,
            ),
          ),
        ),
        builder: (context) {
          return Container(
            width: double.infinity,
            height: Get.height / 1.25,
            padding: const EdgeInsets.all(Dimensions.defaultSize),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Invoice View',
                      style: TextStyle(
                        fontSize: Dimensions.defaultSize,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await Share.share(
                            'Get your invoice ${URL.baseURL}invoice?id=$id&instalment=$instalment');
                      },
                      child: const Icon(Icons.share),
                    ),
                  ],
                ),
                const SizedBox(
                  height: Dimensions.smSize,
                ),
                Expanded(
                  child: SfPdfViewer.network(
                      '${URL.baseURL}invoice?id=$id&instalment=$instalment'),
                ),
              ],
            ),
          );
        });
  }

  // receiptView pdf view
  static void receiptView(
      BuildContext context, String id, dynamic instalment) async {
    showModalBottomSheet(
        context: context,
        backgroundColor: RGB.white,
        enableDrag: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              Dimensions.defaultSize,
            ),
            topRight: Radius.circular(
              Dimensions.defaultSize,
            ),
          ),
        ),
        builder: (context) {
          return Container(
            width: double.infinity,
            height: Get.height / 1.25,
            padding: const EdgeInsets.all(Dimensions.defaultSize),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Receipt View',
                      style: TextStyle(
                        fontSize: Dimensions.defaultSize,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await Share.share(
                            'Get your receipt ${URL.baseURL}receipt?id=$id&instalment=$instalment');
                      },
                      child: const Icon(Icons.share),
                    ),
                  ],
                ),
                const SizedBox(
                  height: Dimensions.smSize,
                ),
                Expanded(
                  child: SfPdfViewer.network(
                      '${URL.baseURL}receipt?id=$id&instalment=$instalment'),
                ),
              ],
            ),
          );
        });
  }

  // statement pdf view
  static void statementView(BuildContext context, String id) async {
    showModalBottomSheet(
        context: context,
        backgroundColor: RGB.white,
        enableDrag: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              Dimensions.defaultSize,
            ),
            topRight: Radius.circular(
              Dimensions.defaultSize,
            ),
          ),
        ),
        builder: (context) {
          return Container(
            width: double.infinity,
            height: Get.height / 1.25,
            padding: const EdgeInsets.all(Dimensions.defaultSize),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Statement View',
                      style: TextStyle(
                        fontSize: Dimensions.defaultSize,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await Share.share(
                            'Get your statement ${URL.baseURL}statement?id=$id');
                      },
                      child: const Icon(Icons.share),
                    ),
                  ],
                ),
                const SizedBox(
                  height: Dimensions.smSize,
                ),
                Expanded(
                  child: SfPdfViewer.network('${URL.baseURL}statement?id=$id'),
                ),
              ],
            ),
          );
        });
  }
}
