import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_eject/app/common/constant/localization_keys.dart';
import '../cubit/dbmeter_cubit.dart';
import '../cubit/dbmeter_state.dart';
import 'meter_app_bar.dart';
import 'meter_body.dart';

class MeterView extends StatelessWidget {
  const MeterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MeterAppBar(),
      body: SafeArea(
        child: BlocListener<DbMeterCubit, DbMeterState>(
          listenWhen: (prev, curr) => prev.effect != curr.effect,
          listener: (context, state) async {
            final effect = state.effect;
            if (effect is ShowPermissionDialog) {
              final permanentlyDenied = effect.permanentlyDenied;
              final result = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text(LocaleKeys.mic_permission_required.tr()),
                  content: Text(
                    permanentlyDenied
                        ? LocaleKeys.permission_permanently_denied_message.tr()
                        : LocaleKeys.permission_request_message.tr(),
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
                            ? LocaleKeys.open_settings.tr()
                            : LocaleKeys.grant_permission.tr(),
                      ),
                    ),
                  ],
                ),
              );

              if (result == true) {
                await context.read<DbMeterCubit>().requestPermissionAndStart(
                  permanentlyDenied: permanentlyDenied,
                );
              } else {
                context.read<DbMeterCubit>().clearEffect();
              }
            }
          },
          child: const MeterBody(),
        ),
      ),
    );
  }
}
