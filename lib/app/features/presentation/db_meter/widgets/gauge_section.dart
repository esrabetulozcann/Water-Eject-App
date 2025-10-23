import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/dbmeter_cubit.dart';
import '../cubit/dbmeter_state.dart';
import 'decibel_gauge.dart';

class GaugeSection extends StatelessWidget {
  const GaugeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocSelector<DbMeterCubit, DbMeterState, (double, double)>(
        selector: (s) => (s.currentDb, s.peakDb),
        builder: (context, tuple) {
          final value = tuple.$1;
          final peak = tuple.$2;
          return DecibelGauge(
            value: value,
            peak: peak,
            min: 0,
            max: 120,
            label: "dB",
          );
        },
      ),
    );
  }
}
