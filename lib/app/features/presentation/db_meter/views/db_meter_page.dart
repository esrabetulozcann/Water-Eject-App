import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_eject/app/features/presentation/db_meter/cubit/dbmeter_cubit.dart';
import 'package:water_eject/app/features/presentation/db_meter/widgets/meter_view.dart';
import 'package:water_eject/core/di/locator.dart';

class DbMeterPage extends StatelessWidget {
  const DbMeterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<DbMeterCubit>()..init(),
      child: const Padding(padding: EdgeInsets.all(16), child: MeterView()),
    );
  }
}
