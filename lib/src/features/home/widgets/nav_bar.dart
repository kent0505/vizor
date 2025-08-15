import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants.dart';
import '../../../core/widgets/button.dart';
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
                  asset: Assets.home,
                  active: state is HomeInitial,
                ),
                _NavBarButton(
                  index: 2,
                  title: 'Settings',
                  asset: Assets.settings,
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
    required this.title,
    required this.active,
  });

  final String title;
  final String asset;
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
              const SizedBox(height: 4),
              // SvgWidget(
              //   asset,
              //   height: 24,
              //   color:
              //       active ? const Color(0xff095EF1) : const Color(0xff999999),
              // ),

              const SizedBox(height: 4),
              Text(
                title,
                style: TextStyle(
                  color: active ? Colors.greenAccent : Colors.redAccent,
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
