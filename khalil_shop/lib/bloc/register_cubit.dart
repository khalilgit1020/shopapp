import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khalil_shop/bloc/shop_states.dart';
import 'package:khalil_shop/helper/dio_helper.dart';
import 'package:khalil_shop/models/shop_login_model.dart';

import '../constatnts.dart';

class ShopRegisterCubit extends Cubit<ShopStates> {
  ShopRegisterCubit() : super(ShopInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? shopLoginModel;

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {

    emit(ShopRegisterLoadingState());

    DioHelper.postDate(
      url: REGISTER,
      data: {
        'name':name,
        'email': email,
        'password': password,
        'phone':phone,
      },
    ).then((value) {

      print(value.data);

      shopLoginModel =  ShopLoginModel.fromJson(value.data);

      emit(ShopRegisterSuccessState(shopLoginModel!));
    }).catchError((onError){
      print(onError.toString());
      emit(ShopRegisterErrorState());
    });
  }


  IconData suffixIcon = Icons.visibility_outlined;
  bool isPasswordShown = true;

  void changePasswordVisibility(){
    isPasswordShown = !isPasswordShown;

    suffixIcon = isPasswordShown ? Icons.visibility_outlined : Icons.visibility_off_outlined ;
    emit(ShopRegisterChangePasswordVisibilityState());
  }


}
