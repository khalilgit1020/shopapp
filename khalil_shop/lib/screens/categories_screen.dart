import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khalil_shop/bloc/shop_cubit.dart';
import 'package:khalil_shop/bloc/shop_states.dart';
import 'package:khalil_shop/models/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){

        var cubit = ShopCubit.get(context);

        return ListView.separated(
          itemBuilder: (context,index)=>buildCatItem(cubit.categoriesModel!.data.data![index]),
          separatorBuilder: (context,index)=>Divider(),
          itemCount: cubit.categoriesModel!.data.data!.length,
        );
      },
    );
  }

  Widget buildCatItem(DataModel model)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(
          height: 80,
          width: 80,
          fit: BoxFit.cover,
          image: NetworkImage('${model.image}'),
        ),
        SizedBox(width: 10,),
        Text(
          '${model.name}',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        IconButton(
          onPressed: (){},
          icon: Icon(Icons.arrow_forward_ios),
        ),
      ],
    ),
  );
}
