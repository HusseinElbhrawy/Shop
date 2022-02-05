import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:new_shop_appl/shared/config/components.dart';
import 'package:new_shop_appl/shared/config/const.dart';
import 'package:new_shop_appl/shared/cubit/bloc/login_bloc.dart';
import 'package:new_shop_appl/shared/cubit/bloc/product_screen_bloc.dart';
import 'package:new_shop_appl/shared/cubit/states.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  static final TextEditingController nameController = TextEditingController();
  static final TextEditingController emailController = TextEditingController();
  static final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var productCubit = ProductScreenBloc.object(context);
    var loginCubit = LoginBloc.object(context);
    nameController.text = productCubit.userInformation['name'] ?? 'Loading..';
    emailController.text = productCubit.userInformation['email'] ?? 'Loading..';
    phoneController.text = productCubit.userInformation['phone'] ?? 'Loading..';
    // passwordController.text =
    //     productCubit.userInformation['password'] ?? 'Loading..';
    return BlocConsumer<ProductScreenBloc, ShopStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        return state is GetUserProfileDataLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(kDefaultPadding),
                      child: Row(
                        children: [
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              productCubit.changeEnable();
                            },
                            icon: const Icon(Icons.edit),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? height / 25
                          : height / 15,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextFormFiled(
                        enable: productCubit.enable,
                        nameController: nameController,
                        icon: Icons.person,
                        hint: 'Name',
                        keyboardType: TextInputType.name,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextFormFiled(
                        keyboardType: TextInputType.emailAddress,
                        enable: productCubit.enable,
                        nameController: emailController,
                        icon: Icons.email,
                        hint: 'Email Address',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextFormFiled(
                        keyboardType: TextInputType.phone,
                        enable: productCubit.enable,
                        nameController: phoneController,
                        icon: Icons.call,
                        hint: 'Phone',
                      ),
                    ),
                    /*Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextFormFiled(
                        keyboardType: TextInputType.visiblePassword,
                        isPassword: !productCubit.enable,
                        enable: productCubit.enable,
                        nameController: passwordController,
                        icon: Icons.lock_outlined,
                        hint: 'Password',
                      ),
                    ),*/
                    BlocConsumer<ProductScreenBloc, ShopStates>(
                      listener: (BuildContext context, state) {
                        if (state is UpdateUserInformationSuccess) {
                          if (state.updateUserInformationModel.status as bool) {
                            MotionToast.success(
                              description: Text(
                                state.updateUserInformationModel.message
                                    .toString(),
                              ),
                            ).show(context);
                            productCubit.changeEnable();
                          } else {
                            errorToast(
                              state.updateUserInformationModel.message
                                  .toString(),
                            );
                          }
                        }
                      },
                      builder: (BuildContext context, Object? state) {
                        return state is UpdateUserInformationLoading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : Container(
                                padding: const EdgeInsetsDirectional.all(15),
                                child: TextButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      Colors.blue,
                                    ),
                                    foregroundColor: MaterialStateProperty.all(
                                      Colors.white,
                                    ),
                                    minimumSize: MaterialStateProperty.all(
                                      Size(double.infinity, height / 15),
                                    ),
                                  ),
                                  onPressed: () {
                                    productCubit.updateUserInformation(
                                      phone: phoneController.text,
                                      email: emailController.text,
                                      name: nameController.text,
                                    );
                                  },
                                  child: Text(
                                    'Update'.toUpperCase(),
                                  ),
                                ),
                              );
                      },
                    ),
                    BlocConsumer<LoginBloc, ShopStates>(
                      listener: (BuildContext context, state) {},
                      builder: (BuildContext context, Object? state) {
                        return state is SignOutLoading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : Container(
                                padding: const EdgeInsetsDirectional.all(15),
                                child: TextButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      Colors.red,
                                    ),
                                    foregroundColor: MaterialStateProperty.all(
                                      Colors.white,
                                    ),
                                    minimumSize: MaterialStateProperty.all(
                                      Size(double.infinity, height / 15),
                                    ),
                                  ),
                                  onPressed: () {
                                    loginCubit.signOutMethod(context: context);
                                  },
                                  child: const Text(
                                    'LOGOUT',
                                  ),
                                ),
                              );
                      },
                    ),
                  ],
                ),
              );
      },
    );
  }
}

class CustomTextFormFiled extends StatelessWidget {
  const CustomTextFormFiled({
    Key? key,
    required this.nameController,
    required this.hint,
    required this.icon,
    required this.enable,
    required this.keyboardType,
    this.isPassword = false,
  }) : super(key: key);

  final TextEditingController nameController;
  final String hint;
  final IconData icon;
  final bool enable;
  final bool isPassword;
  final TextInputType keyboardType;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      obscureText: isPassword,
      enabled: enable,
      controller: nameController,
      decoration: InputDecoration(
        label: Text(hint),
        prefixIcon: Icon(icon),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}
