import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/dbmeter_cubit.dart';
import '../cubit/dbmeter_state.dart';
import 'package:water_eject/app/features/presentation/db_meter/widgets/start_stop_button.dart';

class MeterControls extends StatelessWidget {
  const MeterControls({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DbMeterCubit>();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      child: BlocSelector<DbMeterCubit, DbMeterState, bool>(
        selector: (s) => s.isMeasuring,
        builder: (context, isMeasuring) {
          return StartStopButton(
            isMeasuring: isMeasuring,
            onPressed: () => cubit.handleStartStopPressed(),
          );
        },
      ),
    );
  }
}
