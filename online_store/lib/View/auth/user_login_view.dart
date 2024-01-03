import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:online_store/Services/auth_service.dart';
import 'package:online_store/Utils/app_color.dart';
import 'package:online_store/Utils/app_size.dart';
import 'package:online_store/Utils/local_storage.dart';

import 'package:online_store/Utils/text_editing_controller.dart';

class LoginPageView extends StatefulWidget {
  const LoginPageView({Key? key}) : super(key: key);

  @override
  State<LoginPageView> createState() => _LoginPageViewState();
}

class _LoginPageViewState extends State<LoginPageView> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  RxBool isHidden = true.obs;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.shade200,
          actions: [
            TextButton(
              onPressed: () async {
                await LocalStorage.getUserToken();
                Get.offAllNamed('/home');
              },
              child: const Text('skip'),
            )
          ],
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: key,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const Text('user name : kevinryan'),
                    const Text("password : kev02937@"),
                    //*username field
                    const CircleAvatar(
                      backgroundColor: AppColor.backgroundColor,
                      radius: 60,
                      child: Text(
                        'OnlineStore',
                        style: TextStyle(
                          color: AppColor.primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: AppSize.sHeight,
                    ),
                    TextFormField(
                      controller: AppTextEditingController.userName,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        isDense: true,
                        label: Text('User Name'),
                        prefixIcon: Icon(Icons.person_outlined),
                        prefixStyle: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(9.0),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColor.primaryColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(9.0),
                          ),
                        ),
                      ),
                      validator: (value) => value == null || value.isEmpty ? 'Please enter your username' : null,
                    ),

                    const SizedBox(
                      height: AppSize.sHeight,
                    ),

                    //*password field
                    Obx(
                      () => TextFormField(
                        obscureText: isHidden.value,
                        controller: AppTextEditingController.passWord,
                        keyboardType: TextInputType.name,
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          isDense: true,
                          label: const Text('Password'),
                          prefixIcon: const Icon(Icons.lock_outlined),
                          suffixIcon: IconButton(
                            onPressed: () {
                              isHidden.value = !isHidden.value;
                            },
                            icon: isHidden.value == true
                                ? const Icon(
                                    Icons.visibility_off_outlined,
                                  )
                                : const Icon(
                                    Icons.visibility_outlined,
                                  ),
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(9.0),
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColor.primaryColor,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(9.0),
                            ),
                          ),
                        ),
                        validator: (value) => value == null || value.isEmpty ? 'please enter your password' : null,
                      ),
                    ),
                    //checkbox field
                    const SizedBox(
                      height: AppSize.sHeight,
                    ),
                    //*login button
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9.0),
                              color: AppColor.primaryColor,
                            ),
                            child: MaterialButton(
                              height: 55,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(9.0),
                              ),
                              onPressed: () async {
                                if (key.currentState!.validate()) {
                                  Loader.show(context);
                                  Map data = {
                                    'username': AppTextEditingController.userName.text,
                                    'password': AppTextEditingController.passWord.text,
                                  };
                                  await RemoteLoginService.logIn(data);
                                  Loader.hide();
                                }
                              },
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
