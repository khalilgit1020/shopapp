
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khalil_shop/bloc/shop_states.dart';
import 'package:khalil_shop/helper/cache_helper.dart';



class ThemeModeCubit extends Cubit<ShopStates>{

  ThemeModeCubit():super(ShopInitialState());

  static ThemeModeCubit get(context) => BlocProvider.of(context);


  bool isDark = false ;

  void changeMode({ bool? fromShared}){

    if(fromShared != null){
      isDark = fromShared;
      emit(ShopThemeModeState());
    }else {
      isDark = !isDark;

      CacheHelper.putBool(key: 'isDark', value: isDark).then((value){
        emit(ShopThemeModeState());
      });
    }


  }





}