import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_eject/app/features/data/stereo/stereo_player_impl.dart';
import 'package:water_eject/app/features/presentation/stereo/cubit/stereo_cubit.dart';
import 'package:water_eject/app/features/presentation/stereo/views/stereo_view.dart';

class StereoPage extends StatelessWidget {
  const StereoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StereoCubit(StereoPlayerImpl()),
      child: const StereoView(),
    );
  }
}
