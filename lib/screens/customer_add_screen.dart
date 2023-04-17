import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:travel/config/session.dart';
import 'package:travel/config/url.dart';
import 'package:travel/utils/dimensions_utils.dart';
import 'package:travel/utils/forms_utils.dart';
import 'package:travel/utils/rgb_utils.dart';
import 'package:travel/utils/snackbar__utils.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;

class CustomerAddScreen extends StatefulWidget {
  const CustomerAddScreen({super.key});

  @override
  State<CustomerAddScreen> createState() => _CustomerAddScreenState();
}

class _CustomerAddScreenState extends State<CustomerAddScreen> {
  Map sessionUser = {};
  // form
  final _formKeyCustomerAdd = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController contactPersonController = TextEditingController();
  TextEditingController ssmController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  String? pickfile;

  String pictureLabel = 'Select IC Picture';

  List<MultipartFile>? icMultiFiles;
  List<PlatformFile> icMultiFilesView = [];

  @override
  void initState() {
    super.initState();
    initApp();
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    contactController.dispose();
    contactPersonController.dispose();
    ssmController.dispose();
    remarkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RGB.white,
      appBar: AppBar(
        elevation: 1,
        title: const Text('Add Customer'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 160,
            padding: const EdgeInsets.all(
              Dimensions.defaultSize,
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
              child: pickfile == null
                  ? Image.asset(
                      'assets/images/add-user.png',
                      width: 50,
                    )
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: icMultiFilesView.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            right: Dimensions.smSize,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              Dimensions.radiusSize * 2,
                            ),
                            child: Image.file(
                              // File(pickfile!),
                              File(icMultiFilesView[index].path.toString()),
                              fit: BoxFit.cover,
                              height: 150,
                              width: 150,
                            ),
                          ),
                        );
                      },
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
                child: Form(
                  key: _formKeyCustomerAdd,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.text,
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: 'This field is required'),
                        ]),
                        decoration: FormsUtils.inputStyle(
                          hintText: 'Name',
                        ),
                        cursorColor: RGB.dark,
                      ),
                      const SizedBox(height: Dimensions.lgSize),
                      TextFormField(
                        controller: addressController,
                        keyboardType: TextInputType.text,
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: 'This field is required'),
                        ]),
                        decoration: FormsUtils.inputStyle(
                          hintText: 'Address',
                        ),
                        cursorColor: RGB.dark,
                      ),
                      const SizedBox(height: Dimensions.lgSize),
                      TextFormField(
                        controller: contactController,
                        keyboardType: TextInputType.text,
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: 'This field is required'),
                        ]),
                        decoration: FormsUtils.inputStyle(
                          hintText: 'Contact',
                        ),
                        cursorColor: RGB.dark,
                      ),
                      const SizedBox(height: Dimensions.lgSize),
                      TextFormField(
                        controller: contactPersonController,
                        keyboardType: TextInputType.text,
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: 'This field is required'),
                        ]),
                        decoration: FormsUtils.inputStyle(
                          hintText: 'Contact Person',
                        ),
                        cursorColor: RGB.dark,
                      ),
                      const SizedBox(height: Dimensions.lgSize),
                      TextFormField(
                        controller: ssmController,
                        keyboardType: TextInputType.text,
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: 'This field is required'),
                        ]),
                        decoration: FormsUtils.inputStyle(
                          hintText: 'SSM',
                        ),
                        cursorColor: RGB.dark,
                      ),
                      const SizedBox(height: Dimensions.lgSize),
                      GestureDetector(
                        onTap: () async {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowMultiple: true,
                            allowedExtensions: ['jpg'],
                          );
                          if (result != null) {
                            icMultiFiles = result.paths
                                .map(
                                    (path) => MultipartFile.fromFileSync(path!))
                                .toList();
                            icMultiFilesView = result.files;
                            PlatformFile file = result.files.first;
                            pickfile = file.path.toString();
                            pictureLabel = result.files.first.name.toString();
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
                            pictureLabel,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ),
                      const SizedBox(height: Dimensions.lgSize),
                      TextFormField(
                        controller: remarkController,
                        keyboardType: TextInputType.text,
                        decoration: FormsUtils.inputStyle(
                          hintText: 'Remark',
                        ),
                        cursorColor: RGB.dark,
                      ),
                      const SizedBox(height: Dimensions.lgSize),
                      ElevatedButton(
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          final form = _formKeyCustomerAdd.currentState;
                          if (form!.validate()) {
                            EasyLoading.show(status: 'loading...');
                            form.save();
                            // call api part
                            // var multipartFile = await MultipartFile.fromFile(
                            //   pickfile!,
                            // );
                            FormData formData = FormData.fromMap({
                              'agent_id': sessionUser['id'].toString(),
                              'name': nameController.text,
                              'address': addressController.text,
                              'contact': contactController.text,
                              'contact_person': contactPersonController.text,
                              'ssm': ssmController.text,
                              'ic_picture[]': icMultiFiles,
                              'remark': remarkController.text,
                            });
                            try {
                              Response response = await Dio().post(
                                URL.customerAddURL,
                                data: formData,
                                options: Options(
                                  contentType: 'multipart/form-data',
                                ),
                              );
                              Map userData = response.data;
                              if (userData['error']) {
                                SnackBarUtils.show(
                                    title: userData['messages'], isError: true);
                              } else {
                                SnackBarUtils.show(
                                    title: userData['messages'],
                                    isError: false);
                                if (mounted) {
                                  Navigator.pop(context, {
                                    'id': 1,
                                    'data': userData['data'],
                                  });
                                }
                              }
                            } catch (e) {
                              SnackBarUtils.show(
                                  title: e.toString(), isError: true);
                            }
                            EasyLoading.dismiss();
                          }
                          return;
                        },
                        child: SizedBox(
                          width: Get.width,
                          child: const Text(
                            'Submit',
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
}
