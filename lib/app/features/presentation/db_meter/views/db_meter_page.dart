import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_eject/app/features/data/cleaner/audio/noise_meter_repository_impl.dart';
import 'package:water_eject/app/features/presentation/db_meter/cubit/dbmeter_cubit.dart';
import 'package:water_eject/app/features/presentation/db_meter/widgets/meter_view.dart';

class DbMeterPage extends StatelessWidget {
  const DbMeterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DbMeterCubit>(
      create: (_) =>
          DbMeterCubit(NoiseMeterRepositoryImpl())..checkPermission(),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: const MeterView(),
      ), // Tüm UI + Listener burada
    );
  }
}
