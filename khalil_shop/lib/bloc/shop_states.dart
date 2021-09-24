import 'package:khalil_shop/models/change_favorites_model.dart';
import 'package:khalil_shop/models/shop_login_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates{}




class ShopThemeModeState extends ShopStates{}




class ShopLoginLoadingState extends ShopStates{}

class ShopLoginSuccessState extends ShopStates{
  final ShopLoginModel shopLoginModel;

  ShopLoginSuccessState(this.shopLoginModel);
}

class ShopLoginErrorState extends ShopStates{
  final String error;
  ShopLoginErrorState(this.error);
}




class ShopRegisterLoadingState extends ShopStates{}

class ShopRegisterSuccessState extends ShopStates{
  final ShopLoginModel shopLoginModel;

  ShopRegisterSuccessState(this.shopLoginModel);
}

class ShopRegisterErrorState extends ShopStates{}




class ShopLoginChangePasswordVisibilityState extends ShopStates{}

class ShopRegisterChangePasswordVisibilityState extends ShopStates{}




class ShopChangeBottomNavState extends ShopStates{}




class ShopLoadingHomeDataState extends ShopStates{}

class ShopSuccessHomeDataState extends ShopStates{}

class ShopErrorHomeDataState extends ShopStates{}




class ShopSuccessCategoriesState extends ShopStates{}

class ShopErrorCategoriesState extends ShopStates{}




class ShopChangeFavoritesState extends ShopStates{}

class ShopSuccessChangeFavoritesState extends ShopStates{
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesState(this.model);
}

class ShopErrorChangeFavoritesState extends ShopStates{}




class ShopLoadingGetFavoritesState extends ShopStates{}

class ShopSuccessGetFavoritesState extends ShopStates{}

class ShopErrorGetFavoritesState extends ShopStates{}




class ShopLoadingUserDataState extends ShopStates{}

class ShopSuccessUserDataState extends ShopStates{
  final ShopLoginModel? model;

  ShopSuccessUserDataState(this.model);
}

class ShopErrorUserDataState extends ShopStates{}




class ShopLoadingUpdateDataState extends ShopStates{}

class ShopSuccessUpdateDataState extends ShopStates{
  final ShopLoginModel? model;

  ShopSuccessUpdateDataState(this.model);
}

class ShopErrorUpdateDataState extends ShopStates{}




class ShopLoadingSearchDataState extends ShopStates{}

class ShopSuccessSearchDataState extends ShopStates{}

class ShopErrorSearchDataState extends ShopStates{
  final error;

  ShopErrorSearchDataState(this.error);
}
