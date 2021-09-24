import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khalil_shop/bloc/shop_states.dart';
import 'package:khalil_shop/helper/dio_helper.dart';
import 'package:khalil_shop/models/shop_login_model.dart';

import '../constatnts.dart';

class ShopLoginCubit extends Cubit<ShopStates> {
  ShopLoginCubit() : super(ShopInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? shopLoginModel;

  void userLogin({
    required String email,
    required String password,
  }) {

    emit(ShopLoginLoadingState());

    DioHelper.postDate(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {

       print(value.data);
       shopLoginModel =  ShopLoginModel.fromJson(value.data);
       //print(shopLoginModel!.status);
      // print(shopLoginModel!.message);
     // print(shopLoginModel!.data.token);

      emit(ShopLoginSuccessState(shopLoginModel!));
    }).catchError((onError){
      print(onError.toString());
      emit(ShopLoginErrorState(onError.toString()));
    });
  }


  IconData suffixIcon = Icons.visibility_outlined;
  bool isPasswordShown = true;

  void changePasswordVisibility(){
    isPasswordShown = !isPasswordShown;

    suffixIcon = isPasswordShown ? Icons.visibility_outlined : Icons.visibility_off_outlined ;
    emit(ShopLoginChangePasswordVisibilityState());
  }


  ShopLoginModel? userModel;

  void getUserData()  {

    emit(ShopLoadingUserDataState());

    DioHelper.getDate(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      print('***************************');
        print(userModel!.data!.email);

      emit(ShopSuccessUserDataState(userModel));
    }).catchError((error) {

       print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }

  void updateUserData({
  required String name,
    required String email,
    required String phone,
})  {

    emit(ShopLoadingUpdateDataState());

    DioHelper.putDate(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name':name,
        'email':email,
        'phone':phone,
      }
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      print('***************************');
      print(userModel!.data!.name);

      emit(ShopSuccessUpdateDataState(userModel));
    }).catchError((error) {

      print(error.toString());
      emit(ShopErrorUpdateDataState());
    });
  }




}
