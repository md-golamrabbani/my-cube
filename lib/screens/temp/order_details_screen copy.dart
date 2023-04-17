// ignore_for_file: file_names
// import 'package:dio/dio.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart' hide Response, FormData, MultipartFile;
// import 'package:mcapp/config/session.dart';
// import 'package:mcapp/config/url.dart';
// import 'package:mcapp/utils/dimensions_utils.dart';
// import 'package:mcapp/utils/rgb_utils.dart';
// import 'package:mcapp/utils/snackbar__utils.dart';

// class OrderDetailsScreen extends StatefulWidget {
//   const OrderDetailsScreen({super.key});

//   @override
//   State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
// }

// class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
//   bool isLoaded = false;
//   List dataList = [];

//   String fileLabel = 'Upload Attachment';
//   String? pickfile;

//   @override
//   void initState() {
//     super.initState();
//     apiCall();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: RGB.light,
//         appBar: AppBar(
//           elevation: 1,
//           title: const Text('Order View'),
//         ),
//         body: Column(
//           children: [
//             Expanded(
//               child: ListView(
//                 children: [
//                   Container(
//                     margin: const EdgeInsets.only(
//                       bottom: Dimensions.defaultSize,
//                     ),
//                     color: RGB.white,
//                     child: Column(
//                       children: [
//                         orderInfo(
//                           title: 'Order ID',
//                           info: Get.parameters['invoice_id'].toString(),
//                         ),
//                         orderInfo(
//                           title: 'Order Amount',
//                           info: Get.parameters['monthly_rate'].toString(),
//                         ),
//                         orderInfo(
//                           title: 'Total Payable',
//                           info: Get.parameters['paid'].toString(),
//                         ),
//                       ],
//                     ),
//                   ),
//                   isLoaded
//                       ? Container(
//                           margin: const EdgeInsets.only(
//                             top: Dimensions.smSize,
//                             bottom: Dimensions.defaultSize,
//                           ),
//                           color: RGB.white,
//                           child: Container(
//                             padding: const EdgeInsets.all(
//                               Dimensions.defaultSize,
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Pay in ${Get.parameters['totalInstalments']}',
//                                   style: const TextStyle(
//                                     fontSize: Dimensions.defaultSize + 2,
//                                     fontWeight: FontWeight.w800,
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   height: Dimensions.smSize,
//                                 ),
//                                 ListView.builder(
//                                   itemCount: dataList.length,
//                                   itemBuilder: (context, index) {
//                                     return Row(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Stack(
//                                               clipBehavior: Clip.none,
//                                               children: [
//                                                 Row(
//                                                   children: [
//                                                     const Icon(
//                                                       Icons.check_circle,
//                                                       color: RGB.succeeLight,
//                                                       size: 28,
//                                                     ),
//                                                     const SizedBox(
//                                                       width:
//                                                           Dimensions.smSize / 3,
//                                                     ),
//                                                     Container(
//                                                       padding: const EdgeInsets
//                                                           .symmetric(
//                                                         vertical:
//                                                             Dimensions.smSize /
//                                                                 4,
//                                                         horizontal:
//                                                             Dimensions.smSize /
//                                                                 2,
//                                                       ),
//                                                       decoration: BoxDecoration(
//                                                         color: RGB.succeeLight,
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(
//                                                           Dimensions.smSize / 4,
//                                                         ),
//                                                       ),
//                                                       child: const Text(
//                                                         '1/3 Paid',
//                                                         style: TextStyle(
//                                                           color: RGB.white,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                                 Positioned(
//                                                   left: Dimensions.defaultSize -
//                                                       2,
//                                                   bottom:
//                                                       -Dimensions.defaultSize,
//                                                   child: Container(
//                                                     height: Dimensions.smSize,
//                                                     decoration:
//                                                         const BoxDecoration(
//                                                       border: Border(
//                                                         left: BorderSide(
//                                                           width: 2,
//                                                           color: RGB.border,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             const SizedBox(
//                                               height: Dimensions.defaultSize,
//                                             ),
//                                             Stack(
//                                               clipBehavior: Clip.none,
//                                               children: [
//                                                 Row(
//                                                   children: [
//                                                     const Icon(
//                                                       Icons.check_circle,
//                                                       color: RGB.succeeLight,
//                                                       size: 28,
//                                                     ),
//                                                     const SizedBox(
//                                                       width:
//                                                           Dimensions.smSize / 3,
//                                                     ),
//                                                     Container(
//                                                       padding: const EdgeInsets
//                                                           .symmetric(
//                                                         vertical:
//                                                             Dimensions.smSize /
//                                                                 4,
//                                                         horizontal:
//                                                             Dimensions.smSize /
//                                                                 2,
//                                                       ),
//                                                       decoration: BoxDecoration(
//                                                         color: RGB.succeeLight,
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(
//                                                           Dimensions.smSize / 4,
//                                                         ),
//                                                       ),
//                                                       child: const Text(
//                                                         '2/3 Paid',
//                                                         style: TextStyle(
//                                                           color: RGB.white,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                                 Positioned(
//                                                   left: Dimensions.defaultSize -
//                                                       2,
//                                                   bottom:
//                                                       -Dimensions.defaultSize,
//                                                   child: Container(
//                                                     height: Dimensions.smSize,
//                                                     decoration:
//                                                         const BoxDecoration(
//                                                       border: Border(
//                                                         left: BorderSide(
//                                                           width: 2,
//                                                           color: RGB.border,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             const SizedBox(
//                                               height: Dimensions.defaultSize,
//                                             ),
//                                             Container(
//                                               margin: const EdgeInsets.only(
//                                                 left: 4,
//                                               ),
//                                               child: Row(
//                                                 children: [
//                                                   const Icon(
//                                                     Icons.circle_outlined,
//                                                     color: RGB.border,
//                                                     size: 22,
//                                                   ),
//                                                   const SizedBox(
//                                                     width:
//                                                         Dimensions.smSize / 3,
//                                                   ),
//                                                   Container(
//                                                     padding: const EdgeInsets
//                                                         .symmetric(
//                                                       vertical:
//                                                           Dimensions.smSize / 4,
//                                                       horizontal:
//                                                           Dimensions.smSize / 2,
//                                                     ),
//                                                     decoration: BoxDecoration(
//                                                       color: RGB.muted
//                                                           .withOpacity(0.2),
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                         Dimensions.smSize / 4,
//                                                       ),
//                                                     ),
//                                                     child: const Text(
//                                                       '3/3 Auto-deduct',
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         Column(
//                                           children: const [
//                                             Text('30 Jan 2023'),
//                                             SizedBox(
//                                               height: Dimensions.lgSize,
//                                             ),
//                                             Text('30 Jan 2023'),
//                                             SizedBox(
//                                               height: Dimensions.lgSize,
//                                             ),
//                                             Text('30 Jan 2023'),
//                                           ],
//                                         ),
//                                         Column(
//                                           children: const [
//                                             Text('RM27.27'),
//                                             SizedBox(
//                                               height: Dimensions.lgSize,
//                                             ),
//                                             Text('RM27.27'),
//                                             SizedBox(
//                                               height: Dimensions.lgSize,
//                                             ),
//                                             Text('RM27.27'),
//                                           ],
//                                         ),
//                                       ],
//                                     );
//                                   },
//                                 ),
//                                 const SizedBox(
//                                   height: Dimensions.defaultSize,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         )
//                       : const Center(
//                           child: CircularProgressIndicator(),
//                         ),
//                 ],
//               ),
//             ),
//             isLoaded
//                 ? Container(
//                     width: Get.width,
//                     padding: const EdgeInsets.symmetric(
//                       vertical: Dimensions.lgSize,
//                       horizontal: Dimensions.defaultSize,
//                     ),
//                     margin: const EdgeInsets.only(
//                       top: Dimensions.defaultSize,
//                     ),
//                     decoration: const BoxDecoration(
//                       color: RGB.white,
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(
//                           Dimensions.defaultSize,
//                         ),
//                         topRight: Radius.circular(
//                           Dimensions.defaultSize,
//                         ),
//                       ),
//                     ),
//                     child: Column(
//                       children: [
//                         GestureDetector(
//                           onTap: () async {
//                             FilePickerResult? result =
//                                 await FilePicker.platform.pickFiles(
//                               type: FileType.custom,
//                               allowedExtensions: ['jpg', 'pdf'],
//                             );
//                             if (result != null) {
//                               PlatformFile file = result.files.first;
//                               pickfile = file.path.toString();
//                               fileLabel = result.files.single.name.toString();
//                               setState(() {});
//                             }
//                           },
//                           child: Container(
//                             width: Get.width,
//                             padding: const EdgeInsets.symmetric(
//                               vertical: Dimensions.defaultSize,
//                               horizontal: Dimensions.defaultSize,
//                             ),
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                 width: 0.5,
//                                 color: RGB.border,
//                               ),
//                               borderRadius: BorderRadius.circular(
//                                 Dimensions.radiusSize,
//                               ),
//                             ),
//                             child: Text(
//                               fileLabel,
//                               textAlign: TextAlign.center,
//                               overflow: TextOverflow.ellipsis,
//                               maxLines: 1,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: Dimensions.lgSize),
//                         ElevatedButton(
//                           onPressed: () {},
//                           child: SizedBox(
//                             width: Get.width,
//                             child: const Text(
//                               'Pay Now',
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                 : const SizedBox.square(),
//           ],
//         ));
//   }

//   // widgets
//   Widget orderInfo({
//     required String title,
//     required String info,
//   }) {
//     return Container(
//       padding: const EdgeInsets.symmetric(
//         vertical: Dimensions.smSize,
//         horizontal: Dimensions.defaultSize,
//       ),
//       decoration: const BoxDecoration(
//         border: Border(
//           bottom: BorderSide(
//             width: 1,
//             color: RGB.border,
//           ),
//         ),
//       ),
//       child: ListTile(
//         dense: true,
//         contentPadding: EdgeInsets.zero,
//         title: Text(
//           title,
//           style: const TextStyle(
//             fontSize: Dimensions.defaultSize,
//             fontWeight: FontWeight.w800,
//           ),
//         ),
//         trailing: Text(info),
//       ),
//     );
//   }

//   // api call
//   void apiCall() async {
//     // call api part
//     try {
//       Response response = await Dio().post(
//         URL.instalmentURL,
//         data: FormData.fromMap({
//           'id': Get.parameters['id'].toString(),
//         }),
//       );
//       Map data = response.data;
//       if (data['error']) {
//         isLoaded = true;
//         SnackBarUtils.show(title: data['messages'], isError: true);
//       } else {
//         isLoaded = true;
//         dataList = data['data'];
//       }
//     } catch (e) {
//       SnackBarUtils.show(title: e.toString(), isError: true);
//     }
//     if (mounted) {
//       setState(() {});
//     }
//   }
// }
