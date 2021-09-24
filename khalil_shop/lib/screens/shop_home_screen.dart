import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khalil_shop/bloc/shop_cubit.dart';
import 'package:khalil_shop/bloc/shop_states.dart';
import 'package:khalil_shop/screens/search_screen.dart';
// import 'package:khalil_shop/screens/search_screen.dart';

class ShopHomeScreen extends StatelessWidget {
  const ShopHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,index){

        var cubit = ShopCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text('Salla'),
            actions: [
              IconButton(
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>SearchScreen()));
                },
                icon: Icon(Icons.search),
              ),
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
              cubit.changeBottom(index);
            },
            currentIndex: cubit.currentIndex,
             items:const [
               BottomNavigationBarItem(
                 icon: Icon(Icons.home),
                 label: 'Home',
               ),
               BottomNavigationBarItem(
                 icon: Icon(Icons.apps),
                 label: 'Categories',
               ),
               BottomNavigationBarItem(
                 icon: Icon(Icons.favorite),
                 label: 'Favorite',
               ),
               BottomNavigationBarItem(
                 icon: Icon(Icons.settings),
                 label: 'Settings',
               ),
             ],
          ),
        );
      },
    );
  }
}
