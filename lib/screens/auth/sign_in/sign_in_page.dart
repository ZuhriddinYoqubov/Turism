import 'package:flutter/material.dart';
import 'package:mobileapp/core/components/exporting_packages.dart';
import 'package:mobileapp/cubit/auth/sign_in_cubit/sign_in_cubit.dart';
import 'package:mobileapp/screens/auth/sing_up/sign_up_page.dart';
import 'package:mobileapp/screens/auth/widgets/text_widget.dart';
import 'package:mobileapp/widgets/elevated_button_widget.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);
  bool check = false;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (_) => SignInCubit(),
      child: BlocBuilder<SignInCubit, SignInState>(builder: (context, state) {
        SignInCubit cubit = context.watch();
        return Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: cubit.formKey,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: getHeight(84),
                      left: getWidth(30),
                      right: getWidth(94),
                    ),
                    child: AuthTextWidget(),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: getHeight(81),
                      left: getWidth(30),
                      right: getHeight(30),
                    ),
                    child: TextFormFieldWidget(
                      controller: cubit.loginController,
                      hint: 'Login',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: getHeight(25),
                      left: getWidth(30),
                      right: getHeight(30),
                    ),
                    child: TextFormFieldWidget(
                      controller: cubit.passwordController,
                      hint: 'Password',
                    ),
                  ),
                  Container(
                    // color: Colors.yellow,
                    margin: EdgeInsets.only(
                      top: getHeight(10),
                      left: getWidth(7),
                    ),
                    child: CheckboxListTile(
                      title: const Text("Remember me"),
                      controlAffinity: ListTileControlAffinity.leading,
                      value: cubit.isTrue,
                      onChanged: cubit.onChanged,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: getHeight(104),
                          left: getWidth(20),
                        ),
                        child: TextButton(
                          child: const Text(
                            "Забыл пароль? ",
                            style: TextStyle(color: AppColors.blue),
                          ),
                          onPressed: () {},
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: getHeight(104),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.blue,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: TextButton(
                          child: const Text(
                            "Регистрация",
                            style: TextStyle(color: AppColors.blue),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: getHeight(60)),
                  InkWell(
                    onTap: cubit.onPressed,
                    child: ElevatedButtonWidget(
                      text: 'Войти',
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
