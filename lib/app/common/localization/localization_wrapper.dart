import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_eject/core/cubit/localization_cubit.dart';

//LocalizationWrapper, uygulama dilini tek kaynaktan yönetebilmemi sağlıyor.
//LocaleCubit değişince UI otomatik olarak güncelleniyor.
class LocalizationWrapper extends StatelessWidget {
  final Widget child;

  const LocalizationWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LocaleCubit, LocaleState>(
      listenWhen: (previous, current) => previous.locale != current.locale,
      listener: (context, state) => context.setLocale(state.locale),
      child: child,
    );
  }
}
