import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_eject/core/extensions/padding_extensions.dart';
import '../cubit/dbmeter_cubit.dart';
import '../cubit/dbmeter_state.dart';
import 'package:water_eject/app/features/presentation/db_meter/widgets/gauge_section.dart';
import 'package:water_eject/app/features/presentation/db_meter/widgets/info_row.dart';
import 'meter_controls.dart';

class MeterBody extends StatelessWidget {
  const MeterBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DbMeterCubit>();

    return Column(
      //spacing: 12,
      children: [
        // Gauge — kendi içinde BlocSelector kullanıyor
        const Expanded(child: GaugeSection()),

        // Anlık / Peak kartları
        BlocBuilder<DbMeterCubit, DbMeterState>(
          buildWhen: (p, c) =>
              p.currentDb != c.currentDb || p.peakDb != c.peakDb,
          builder: (context, state) {
            return InfoRow(
              currentText: "${state.currentDb.toStringAsFixed(1)} dB",
              peakText: "${state.peakDb.toStringAsFixed(1)} dB",
              onResetPeak: cubit.resetPeak,
            );
          },
        ),

        const MeterControls().onlyPadding(bottom: 8),
      ],
    ).onlyPadding(top: 12);
  }
}
