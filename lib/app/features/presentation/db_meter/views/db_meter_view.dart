import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:water_eject/app/features/presentation/db_meter/cubit/dbmeter_cubit.dart';
import 'package:water_eject/app/features/presentation/db_meter/cubit/dbmeter_state.dart';
import 'package:water_eject/app/features/presentation/db_meter/widgets/meter_app_bar.dart';
import 'package:water_eject/app/features/presentation/db_meter/widgets/meter_body.dart';
import 'package:water_eject/core/di/locator.dart';
import 'package:water_eject/app/common/constant/localization_keys.dart';
import 'package:water_eject/core/extensions/padding_extensions.dart';

class DbMeterView extends StatelessWidget {
  const DbMeterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<DbMeterCubit>()..init(),
      child: Scaffold(
        appBar: const MeterAppBar(),
        body: SafeArea(
          child: BlocListener<DbMeterCubit, DbMeterState>(
            listenWhen: (prev, curr) => prev.effect != curr.effect,
            listener: (context, state) async {
              final effect = state.effect;

              if (effect is ShowPermissionDialog) {
                final permanentlyDenied = effect.permanentlyDenied;
                final cubit = context.read<DbMeterCubit>();

                final result = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text(LocaleKeys.micPermissionRequired.tr()),
                    content: Text(
                      permanentlyDenied
                          ? LocaleKeys.permissionPermanentlyDeniedMessage.tr()
                          : LocaleKeys.permissionRequestMessage.tr(),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(false),
                        child: Text(LocaleKeys.cancel.tr()),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(true),
                        child: Text(
                          permanentlyDenied
                              ? LocaleKeys.openSettings.tr()
                              : LocaleKeys.grantPermission.tr(),
                        ),
                      ),
                    ],
                  ),
                );

                if (result == true) {
                  await cubit.requestPermissionAndStart(
                    permanentlyDenied: permanentlyDenied,
                  );
                } else {
                  cubit.clearEffect();
                }
              }
            },
            child: MeterBody().allPadding(16),
          ),
        ),
      ),
    );
  }
}
