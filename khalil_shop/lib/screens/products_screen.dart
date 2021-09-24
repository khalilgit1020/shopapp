import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khalil_shop/bloc/shop_cubit.dart';
import 'package:khalil_shop/bloc/shop_states.dart';
import 'package:khalil_shop/models/categories_model.dart';
import 'package:khalil_shop/models/home_model.dart';
import 'package:khalil_shop/models/themes.dart';
import 'package:khalil_shop/widgets/toast.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if(state is ShopSuccessChangeFavoritesState ){
          if(state.model.status! == false){
            showToast(state: ToastState.ERROR, msg: state.model.message!);
          }else{
            showToast(state: ToastState.SUCCESS, msg: state.model.message!);
          }
        }
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);

        return cubit.homeModel !=  null && cubit.categoriesModel !=  null ?
        productsBuilder(cubit.homeModel!,cubit.categoriesModel!,context):
        const Center(
          child: CircularProgressIndicator(),
        );

      },
    );
  }

  Widget productsBuilder(HomeModel model,CategoriesModel categoriesModel,context) {
    return SingleChildScrollView(
      physics:const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: model.data.banners!
                .map((e) =>  Image(
                      image: NetworkImage(e.image),
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ))
                .toList(),
            options: CarouselOptions(
              height: 250,
              initialPage: 0,
              enableInfiniteScroll: true,
              viewportFraction: 1,
              reverse: false,
              autoPlay: false,
              autoPlayInterval:const Duration(seconds: 3),
              autoPlayAnimationDuration:const Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                    'CATEGORIES',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                 Container(
                  height: 100,
                  child: ListView.separated(
                    physics:const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index)=>buildCategoryItem(categoriesModel.data.data![index]),
                    separatorBuilder: (context,index)=>const SizedBox(width: 10),
                    itemCount: categoriesModel.data.data!.length,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  'NEW PRODUCTS',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
                physics:const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: 1/1.6,
              children: List.generate(
                model.data.products!.length,
                    (index) => buildGridProduct(model.data.products![index],context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGridProduct(ProductsModel model,context){
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Column(
                children: [
                  Image(
                    image: NetworkImage(model.image),
                    width: double.infinity,
                    height: 200,
                  ),
                ],
              ),
              if(model.discount != 0)
              Container(
                padding:const EdgeInsets.symmetric(horizontal: 5),
                color: Colors.red,
                child:const Text(
                  'DISCOUNT',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style:const TextStyle(
                      fontSize: 14,
                      height: 1.3
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '${model.price.round()}',
                      style:const TextStyle(
                          fontSize: 12,
                          color: defaultColor
                      ),
                    ),
                    const SizedBox(width: 5,),
                    if(model.discount != 0)
                    Text(
                      '${model.oldPrice.round()}',
                      style:const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: (){
                          ShopCubit.get(context).changeFavorites(model.id);
                          print(model.id);
                        },
                        icon: CircleAvatar(
                          radius: 35,
                            backgroundColor: ShopCubit.get(context).favourites![model.id]! ? defaultColor : Colors.grey,
                            child:const Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                            ),
                        ),
                      iconSize: 10,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategoryItem(DataModel model){
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          height: 100,
          width: 100,
          fit: BoxFit.cover,
          image: NetworkImage('${model.image}'),
        ),
        Container(
          width: 100,
          color: Colors.black.withOpacity(0.7),
          child: Text(
            model.name.toString(),
            style:const TextStyle(
              color: Colors.white,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
