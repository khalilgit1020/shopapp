import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khalil_shop/bloc/shop_states.dart';
import 'package:khalil_shop/helper/dio_helper.dart';
import 'package:khalil_shop/models/search_model.dart';

import '../constatnts.dart';

class SearchCubit extends Cubit<ShopStates> {
  SearchCubit() : super(ShopInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;

  void search(String? text) {
    emit(ShopLoadingSearchDataState());

    DioHelper.postDate(
      url: SEARCH,
      token: token,
      data: {
        'text': text!,
      },
    ).then((value)
    {
      model = SearchModel.fromJson(value.data!);

      emit(ShopSuccessSearchDataState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorSearchDataState(error.toString()));
    });
  }
}
