import 'package:dcard/page/login/login_page.dart';
import 'package:dcard/page/signup_page/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../utils/components/login_signup.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'dart:io' show Platform;

_onGoogleSubmit() async {
  // 这个地方如果是安卓的则初始化不需要传递clientid  是个很大的坑啊啊啊啊啊啊啊啊啊啊！！！！同志们一定要注意，如果安卓初始化传递了clientid 会出现奇奇怪怪的错误
  final GoogleSignInAccount? googleUser = Platform.isAndroid
      ? await GoogleSignIn().signIn()
      : await GoogleSignIn(
          clientId: '992684001496 ', //这里是示例字串，填写的就是google开发者平台申请的应用的clientid
        ).signIn();
  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;
  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );
  print(credential.accessToken);
  // 这里是获取用户真实信息的地方，因为我用的是服务端验证逻辑，所以需要把上面的数据提交服务端进行验证操作
  // UserCredential user = await FirebaseAuth.instance.signInWithCredential(credential);
  // AdditionalUserInfo? userInfo = user.additionalUserInfo;
}

_onAppleSubmit() async {
  print('start');
  try {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    print(credential);
    if (credential != null) {
      debugPrint(
          "facebook userInfo : userId=${credential.userIdentifier}   email=${credential.email}  giveName=${credential.givenName}   familyName=${credential.familyName}");
    }
  } catch (e) {
    print(e);
  }
}

class AllLoginPage extends StatelessWidget {
  const AllLoginPage({super.key});

  static String id = 'home_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25).w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const TopScreenImage(screenImageName: 'home.jpg'),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.only(right: 15, left: 15, bottom: 0).w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const ScreenTitle(title: 'Hello'),
                      Text(
                        'Welcome to Tasky, where you manage your daily tasks',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15.sp,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Hero(
                        tag: 'login_btn',
                        child: CustomButton(
                          buttonText: 'Login',
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute<void>(
                                builder: (BuildContext context) {
                              return const LoginPage();
                            }));
                          },
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Hero(
                        tag: 'signup_btn',
                        child: CustomButton(
                          buttonText: 'Sign Up',
                          isOutlined: true,
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute<void>(
                                builder: (BuildContext context) {
                              return const SignUpPage();
                            }));
                          },
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text(
                        'Sign up using',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.sp,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              _onGoogleSubmit();
                            },
                            icon: CircleAvatar(
                              radius: 25.r,
                              backgroundColor: Colors.transparent,
                              child:
                                  Image.asset('assets/images/icons/google.png'),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              _onAppleSubmit();
                            },
                            icon: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 25.r,
                              child:
                                  Image.asset('assets/images/icons/apple.png'),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
