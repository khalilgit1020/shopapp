import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khalil_shop/bloc/login_cubit.dart';
import 'package:khalil_shop/bloc/shop_states.dart';
import 'package:khalil_shop/widgets/sign_out.dart';
import 'package:khalil_shop/widgets/toast.dart';

class SettingsScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopLoginCubit,ShopStates>(
      listener: (context,state){
        if(state is ShopSuccessUserDataState){
          nameController.text = state.model!.data!.name;
          emailController.text = state.model!.data!.email;
          phoneController.text = state.model!.data!.phone;

        }

        if(state is ShopSuccessUpdateDataState){
          if(state.model!.status!){
            showToast(
              state: ToastState.SUCCESS,
              msg: state.model!.message!,
            );
          }else{
            showToast(
              state: ToastState.ERROR,
              msg: state.model!.message!,
            );
          }
        }


      },
      builder: (context,state){
        return ShopLoginCubit.get(context).userModel == null ? Center(child: CircularProgressIndicator(),) :
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                if(state is ShopLoadingUpdateDataState)
                   LinearProgressIndicator(),
                const SizedBox(height: 20,),
                TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  validator: (value){
                    if(value!.isEmpty){
                      return 'name must not be empty';
                    }
                  },
                  decoration:const InputDecoration(
                    label: Text('name'),
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value){
                    if(value!.isEmpty){
                      return 'email must not be empty';
                    }
                  },
                  decoration:const InputDecoration(
                    label: Text('Email'),
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  validator: (value){
                    if(value!.isEmpty){
                      return 'name must not be empty';
                    }
                  },
                  decoration:const InputDecoration(
                    label: Text('Phone'),
                    prefixIcon: Icon(Icons.phone),
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  color: Colors.blue,
                  width: double.infinity,
                  child: TextButton(
                    onPressed: (){
                      if(formKey.currentState!.validate()){
                        ShopLoginCubit.get(context).updateUserData(

                          name: nameController.text,
                          email: emailController.text,
                          phone: phoneController.text,
                        );
                      }
                    },
                    child:const Text(
                      'UPDATE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  color: Colors.blue,
                  width: double.infinity,
                  child: TextButton(
                    onPressed: (){
                      SignOut(context);
                    },
                    child:const Text(
                      'LOGOUT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
