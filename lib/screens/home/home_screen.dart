import 'package:flutter/material.dart';
import 'package:mobileapp/core/components/exporting_packages.dart';
import 'package:mobileapp/cubit/home_cubit/home_cubit.dart';
import 'package:mobileapp/screens/profile/auth_profile_page.dart';
import 'package:mobileapp/widgets/top_bar/appbar_origin.dart';
import 'package:mobileapp/widgets/navigators/drawer_widget.dart';
import 'package:mobileapp/widgets/top_bar/home_app_bar.dart';
import 'package:mobileapp/widgets/top_bar/searchtapbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomNavigator().init(context);
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          HomeCubit cubit = context.watch();
          return Scaffold(
            key: cubit.scaffoldKey,
            drawer: const DrawerWidget(),
            body: _pages(cubit)[cubit.currentIndex],
            bottomNavigationBar: BottomNavBarWidget(
              onTap: cubit.onPageChanged,
              currentIndex: cubit.currentIndex,
            ),
          );
        },
      ),
    );
  }

  List<Widget> _pages(HomeCubit cubit) {
    String token = GetStorage().read('token') ?? '';
    return [
      const GitPage(),
      SearchPage(),
      HomeBody(cubit: cubit),
      const CarPage(),
      token.isNotEmpty ? const ProfileAuthPage() : const SignInPage(),
    ];
  }

}
