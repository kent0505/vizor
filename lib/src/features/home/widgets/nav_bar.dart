import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/svg_widget.dart';
import '../bloc/home_bloc.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 62 + MediaQuery.of(context).viewPadding.bottom,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ).copyWith(top: 4),
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _NavBarButton(
                  index: 1,
                  title: 'Home',
                  asset: Assets.home1,
                  asset2: Assets.home2,
                  active: state is HomeInitial,
                ),
                _NavBarButton(
                  index: 2,
                  title: 'Favorites',
                  asset: Assets.favorite1,
                  asset2: Assets.favorite2,
                  active: state is HomeFavorite,
                ),
                _NavBarButton(
                  index: 3,
                  title: 'Settings',
                  asset: Assets.settings1,
                  asset2: Assets.settings2,
                  active: state is HomeSettings,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _NavBarButton extends StatelessWidget {
  const _NavBarButton({
    required this.index,
    required this.asset,
    required this.asset2,
    required this.title,
    required this.active,
  });

  final String title;
  final String asset;
  final String asset2;
  final int index;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 54,
        child: Button(
          onPressed: active
              ? null
              : () {
                  context.read<HomeBloc>().add(ChangePage(index: index));
                },
          child: Column(
            children: [
              const SizedBox(height: 6),
              SvgWidget(
                active ? asset2 : asset,
                height: 24,
              ),
              const SizedBox(height: 6),
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: AppFonts.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
