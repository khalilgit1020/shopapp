import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:khalil_shop/bloc/register_cubit.dart';
import 'package:khalil_shop/screens/login_screen.dart';
import 'package:khalil_shop/screens/on_boarding_screen.dart';
import 'package:khalil_shop/screens/shop_home_screen.dart';
import 'bloc/bloc_observer.dart';
import 'bloc/login_cubit.dart';
import 'bloc/shop_cubit.dart';
import 'bloc/shop_states.dart';
import 'bloc/theme_mode_cubit.dart';
import 'constatnts.dart';
import 'helper/cache_helper.dart';
import 'helper/dio_helper.dart';
import 'models/themes.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = SimpleBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  bool? isDark = CacheHelper.getData(key: 'isDark');

  bool? onBoarding = CacheHelper.getData(key: 'OnBoarding');
  token = CacheHelper.getData(key: 'token');

  if(onBoarding != null ){
    if(token != null) widget = ShopHomeScreen();
    else widget = LoginScreen();
  }else{
    widget = OnBoardingScreen();
  }

  print(onBoarding);

  runApp( MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

 class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget startWidget;
   MyApp({required this.isDark,required this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>ShopLoginCubit()..getUserData()),
        BlocProvider(create: (context)=>ThemeModeCubit()..changeMode(fromShared: isDark)),
        BlocProvider(create: (context)=>ShopCubit()..getHomeData()..getCategoriesModel()..getFavoritesModel()),
      ],
      child: BlocConsumer<ThemeModeCubit,ShopStates>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'News App',
            theme: lightTheme,
            darkTheme:  darkTheme,
            themeMode:! ThemeModeCubit.get(context).isDark? ThemeMode.dark:ThemeMode.light,
            home: Directionality(
              textDirection: TextDirection.ltr,
              child:startWidget,
            ),
          );
        },
      ),
    );
  }
}

