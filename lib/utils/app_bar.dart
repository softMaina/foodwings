import 'package:FoodWings/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

PreferredSize buildAppBar(Widget leading, Size size, String title) {
  final GetStorage store = GetStorage();
  return PreferredSize(
    preferredSize: const Size.fromHeight(40.0), //appbar size
    child: AppBar(
      elevation: 1,
      shadowColor: Colors.transparent,
      backgroundColor: Colors.white, //appbar bg color
      leading: Padding(
        padding: EdgeInsets.only(
          left: size.width * 0.05,
        ),
        child: leading,
      ),

      automaticallyImplyLeading: false,
      titleSpacing: 0,
      leadingWidth: size.width * 0.15,
      title: Text(
        title.toUpperCase(),
        style: const TextStyle(color: Colors.green, fontSize: 25),
      ),
      centerTitle: true,
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            right: size.width * 0.05,
          ),
          child: TextButton(
            onPressed: () =>
                {store.remove("auth"), Get.offAll(const LoginPage())},
            child: Icon(
              Icons.logout_outlined,
              color: Colors.green,
              size: size.height * 0.03,
            ),
          ),
        ),
      ],
    ),
  );
}
