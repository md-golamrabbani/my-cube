import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:travel/config/session.dart';
import 'package:travel/config/url.dart';
import 'package:travel/utils/dimensions_utils.dart';
import 'package:travel/utils/forms_utils.dart';
import 'package:travel/utils/rgb_utils.dart';
import 'package:travel/utils/snackbar__utils.dart';
import 'package:unicons/unicons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // form
  final _formKeyLogin = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // password visibility
  bool passwordVisibility = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RGB.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: Dimensions.lgSize * 2,
            horizontal: Dimensions.defaultSize,
          ),
          child: ListView(
            children: [
              const SizedBox(
                height: Dimensions.lgSize,
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(
                  bottom: Dimensions.lgSize,
                ),
                child: Image.asset(
                  'assets/images/logo.jpg',
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: Dimensions.lgSize * 2,
              ),
              const Text(
                'Welcome back',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: Dimensions.defaultSize * 1.5,
                  fontWeight: FontWeight.w700,
                  color: RGB.dark,
                ),
              ),
              const SizedBox(
                height: Dimensions.lgSize,
              ),
              Form(
                key: _formKeyLogin,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.text,
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Email is required'),
                        EmailValidator(errorText: 'Enter valid email!'),
                      ]),
                      decoration: FormsUtils.inputStyle(
                        hintText: 'Email',
                      ),
                      cursorColor: RGB.dark,
                    ),
                    const SizedBox(height: Dimensions.lgSize),
                    TextFormField(
                      controller: passwordController,
                      obscureText: passwordVisibility,
                      keyboardType: TextInputType.text,
                      validator:
                          RequiredValidator(errorText: 'Password is required!'),
                      decoration: FormsUtils.inputStyle(
                        hintText: 'Password',
                        suffixIcon: UniconsLine.eye,
                        passwordVisibility: passwordVisibility,
                        suffixOnPressed: () {
                          setState(() {
                            passwordVisibility = !passwordVisibility;
                          });
                        },
                      ),
                      cursorColor: RGB.dark,
                    ),
                    const SizedBox(height: Dimensions.lgSize),
                    ElevatedButton(
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        final form = _formKeyLogin.currentState;
                        if (form!.validate()) {
                          EasyLoading.show(status: 'loading...');
                          form.save();
                          // call api part
                          FormData formData = FormData.fromMap({
                            'email': emailController.text,
                            'password': passwordController.text,
                          });
                          try {
                            Response response = await Dio().post(
                              URL.loginURL,
                              data: formData,
                            );
                            Map userData = response.data;
                            print(userData);
                            if (userData['error']) {
                              SnackBarUtils.show(
                                  title: userData['messages'], isError: true);
                            } else {
                              await Session().userSave(
                                userData['data']['id'],
                                userData['data']['name'],
                              );
                              SnackBarUtils.show(
                                  title: 'Login success', isError: false);
                              Get.offAllNamed('/home');
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
                          'Log In',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: Dimensions.smSize,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
