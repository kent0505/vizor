import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/loading_widget.dart';
import '../../../core/widgets/main_button.dart';
import '../../city/bloc/city_bloc.dart';
import '../../city/screens/select_city_screen.dart';
import '../bloc/home_bloc.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppbar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(68);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeBloc>().state;

    return AppBar(
      centerTitle: false,
      shape: const Border(
        bottom: BorderSide(color: Colors.transparent),
      ),
      actionsPadding: const EdgeInsets.symmetric(
        horizontal: 16,
      ).copyWith(top: 8),
      title: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Text(
          switch (state) {
            HomeInitial() => 'Home',
            HomeSettings() => 'Settings',
          },
          style: const TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontFamily: AppFonts.w600,
          ),
        ),
      ),
      actions: [
        BlocBuilder<CityBloc, CityState>(
          builder: (context, state) {
            if (state is CityLoading) {
              return const LoadingWidget();
            }

            if (state is CityLoaded) {
              return Button(
                onPressed: () {
                  context.push(SelectCityScreen.routePath);
                },
                child: Text(
                  state.selectedCity.name,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              );
            }

            return MainButton(
              title: 'Choose city',
              onPressed: () {
                context.push(SelectCityScreen.routePath);
              },
            );
          },
        ),
      ],
    );
  }
}
