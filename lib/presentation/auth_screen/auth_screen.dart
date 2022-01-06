import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nekidaem/presentation/auth_screen/auth_bloc/authentication_bloc.dart';
import 'package:nekidaem/presentation/kanban_screen/kanban_screen.dart';
import 'package:nekidaem/presentation/theme.dart';
import 'package:nekidaem/widgets/updatable_text_form_field.dart';
import 'package:easy_localization/easy_localization.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      if (state is AuthenticationSucces) {
        return const KanbanScreen();
      } else if (state is AuthenticationLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is AuthenticationError) {
        Fluttertoast.showToast(
          msg: state.error,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.grey,
          textColor: AppColors.white,
          fontSize: 12.0,
        );
        return const LoginBody();
      } else {
        return const LoginBody();
      }
    });
  }
}

class LoginBody extends StatefulWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlack,
      appBar: AppBar(
        title: const Text('Kanban'),
        backgroundColor: AppColors.lightBlack,
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: UpdatableTextFormField(
              field: Fields.username,
              hintText: 'enter_your_username'.tr(),
              focusNode: _usernameFocusNode,
              valueListenable: _usernameController,
              textEditingController: _usernameController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: UpdatableTextFormField(
              field: Fields.password,
              hintText: 'enter_your_password'.tr(),
              focusNode: _passwordFocusNode,
              valueListenable: _passwordController,
              textEditingController: _passwordController,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_usernameController.text.isNotEmpty &&
                  _usernameController.text.length >= 4 &&
                  _passwordController.text.isNotEmpty &&
                  _passwordController.text.length >= 8) {
                context.read<AuthenticationBloc>().add(AuthenticationStart(
                      _usernameController.text,
                      _passwordController.text,
                    ));
              } else {
                Fluttertoast.showToast(
                  msg: 'please_fill_textfields'.tr(),
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: AppColors.grey,
                  textColor: AppColors.white,
                  fontSize: 12.0,
                );
              }
            },
            child: const Text('login').tr(),
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(const Size(370, 50)),
              backgroundColor: MaterialStateProperty.all(AppColors.aquamarine),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
