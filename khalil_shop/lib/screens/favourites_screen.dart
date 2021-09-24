import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khalil_shop/bloc/shop_states.dart';
import 'package:khalil_shop/bloc/shop_cubit.dart';
import 'package:khalil_shop/widgets/build_list_product.dart';
import 'package:khalil_shop/widgets/toast.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){
        if(state is ShopSuccessChangeFavoritesState){
          showToast(
            state: ToastState.SUCCESS,
            msg: state.model.message!,
          );
        }
      },
      builder: (context,state){

        var cubit = ShopCubit.get(context);

        return cubit.favoritesModel!.data!.data.length == 0 ? Center(child: Text('no favorites yet'),) :state is ShopLoadingGetFavoritesState?const Center(child: CircularProgressIndicator(),): ListView.separated(
          physics:const BouncingScrollPhysics(),
          itemBuilder: (context,index)=>buildListProduct(cubit.favoritesModel!.data!.data[index].product,context),
          separatorBuilder: (context,index)=>const Divider(),
          itemCount: cubit.favoritesModel!.data!.data.length,
        );
      },
    );
  }


}
