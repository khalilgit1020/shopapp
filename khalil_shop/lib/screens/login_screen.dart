import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khalil_shop/bloc/login_cubit.dart';
import 'package:khalil_shop/bloc/shop_states.dart';
import 'package:khalil_shop/constatnts.dart';
import 'package:khalil_shop/helper/cache_helper.dart';
import 'package:khalil_shop/screens/register_screen.dart';
import 'package:khalil_shop/screens/shop_home_screen.dart';
import 'package:khalil_shop/widgets/toast.dart';


class LoginScreen extends StatelessWidget {


  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLoginCubit,ShopStates>(
      listener: (context,state){
        if(state is ShopLoginSuccessState){
          if(state.shopLoginModel.status!){
            print(state.shopLoginModel.message);
            print(state.shopLoginModel.data!.token);

            CacheHelper.saveData(
              key: 'token',
              value: state.shopLoginModel.data!.token,
            ).then((value) {

              token = state.shopLoginModel.data!.token;

              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (_)=> const ShopHomeScreen(),
                  )
              );
            });

            showToast(
              state: ToastState.SUCCESS,
              msg: state.shopLoginModel.message!,
            );
          }else{
            showToast(
              state: ToastState.ERROR,
              msg: state.shopLoginModel.message!,
            );
          }
        }
      },
      builder: (context,state){

        var cubit = ShopLoginCubit.get(context);

        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LOGIN',
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'login now to browse our hot offers',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 30,),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: ( value){
                          if(value!.isEmpty){
                            return 'please inter your email address';
                          }
                        },
                        decoration:const InputDecoration(
                          label: Text('Email Adsress'),
                          prefixIcon: Icon(Icons.email_outlined),
                        ) ,
                      ),
                      const SizedBox(height: 15,),
                      TextFormField(
                        onFieldSubmitted: (value){

                          if(formKey.currentState!.validate()){
                            cubit.userLogin(email: emailController.text, password: passwordController.text);
                          }
                        },
                        obscureText: cubit.isPasswordShown,

                        controller: passwordController,
                        keyboardType: TextInputType.number,
                        validator: ( value){
                          if(value!.isEmpty){
                            return 'password is too short';
                          }
                        },
                        decoration:InputDecoration(
                          label:const Text('Password'),
                          prefixIcon:const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            onPressed: (){
                              cubit.changePasswordVisibility();
                            },
                            icon: Icon(cubit.suffixIcon),
                          ),
                        ) ,
                      ),
                      const SizedBox(height: 15,),
                      Container(
                        width: double.infinity,
                        height: 60,
                        color: Colors.blue,
                        child:state is ShopLoginLoadingState?const Center(child: CircularProgressIndicator(color: Colors.white,)):
                        TextButton(
                          onPressed: (){
                            if(formKey.currentState!.validate()){
                              cubit.userLogin(email: emailController.text, password: passwordController.text);
                            }
                          },
                          child:const Text('LOGIN',style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),),
                        ),
                      ),
                      const SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\‘t have an account ? ',
                          ),
                          TextButton(
                            onPressed: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (_)=> RegisterScreen()));
                            },
                            child:const Text('Register'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
