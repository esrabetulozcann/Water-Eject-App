import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_eject/app/common/widgets/navigation_cubit.dart';
import 'package:water_eject/app/domain/services/premium_service.dart';
import 'package:water_eject/app/features/presentation/paywall/cubit/paywall_selection_cubit.dart';
import 'package:water_eject/app/features/presentation/paywall/cubit/premium_cubit.dart';
import 'package:water_eject/core/cubit/localization_cubit.dart';
import 'package:water_eject/core/theme/cubit/theme_cubit.dart';

//Tüm Bloc sağlayıcılarını buradan yönettim
class AppBlocProvider extends StatelessWidget {
  final Widget child;

  const AppBlocProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()..load()),
        BlocProvider(create: (_) => LocaleCubit()..load()),
        BlocProvider(create: (_) => NavigationCubit()),
        BlocProvider(
          create: (_) => PremiumCubit(PremiumService())..checkPremiumStatus(),
        ),
        BlocProvider(create: (_) => PaywallSelectionCubit()),
      ],
      child: child,
    );
  }
}
