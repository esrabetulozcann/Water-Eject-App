import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_eject/core/extensions/padding_extensions.dart';
import '../cubit/dbmeter_cubit.dart';
import '../cubit/dbmeter_state.dart';
import 'package:water_eject/app/features/presentation/db_meter/widgets/start_stop_button.dart';

class MeterControls extends StatelessWidget {
  const MeterControls({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DbMeterCubit>();

    return BlocSelector<DbMeterCubit, DbMeterState, bool>(
      selector: (s) => s.isMeasuring,
      builder: (context, isMeasuring) {
        return StartStopButton(
          isMeasuring: isMeasuring,
          onPressed: () => cubit.handleStartStopPressed(),
        );
      },
    ).onlyPadding(left: 16, right: 16, top: 8, bottom: 24);
  }
}
