import 'package:flutter/material.dart';
import 'package:khalil_shop/helper/cache_helper.dart';
import 'package:khalil_shop/screens/login_screen.dart';


void SignOut(context){
  CacheHelper.removeData(key: 'token').then((value) {
    if(value)Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>LoginScreen()));
  });
}