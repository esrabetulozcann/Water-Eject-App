import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_eject/app/features/presentation/stereo/cubit/stereo_cubit.dart';
import 'package:water_eject/app/features/presentation/stereo/views/stereo_view.dart';
import 'package:water_eject/core/di/locator.dart';

class StereoPage extends StatelessWidget {
  const StereoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<StereoCubit>(),
      child: const StereoView(),
    );
  }
}
