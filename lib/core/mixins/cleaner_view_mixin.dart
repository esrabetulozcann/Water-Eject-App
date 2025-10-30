import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:water_eject/app/features/presentation/cleaner/cubit/cleaner_cubit.dart';
import 'package:water_eject/app/features/presentation/cleaner/cubit/cleaner_state.dart';
import 'package:water_eject/app/common/constant/localization_keys.dart';

//Cleaner sayfasında tekrar eden işleri düzenli hale getirmek için bir mixin
mixin CleanerViewMixin<T extends StatefulWidget> on State<T> {
  /// Sayfa açılışında yapılacak işler
  Future<void> initCleaner() async {
    // Cubit init
    await context.read<CleanerCubit>().init();
  }

  /// Hata SnackBar’ını göster
  void showErrorSnack(String? error) {
    if (error == null) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(LocaleKeys.errorAudio.tr())));
  }

  /// Arka plan baloncukları
  Widget buildBubbles(bool show) {
    if (!show) return const SizedBox.shrink();
    return IgnorePointer(
      key: const ValueKey('bubbles-on'),
      child: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: 0.4,
                child: Lottie.asset(
                  'assets/animation/Bubbles.json',
                  fit: BoxFit.fitHeight,
                  repeat: true,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: FractionallySizedBox(
                widthFactor: 0.4,
                child: Lottie.asset(
                  'assets/animation/Bubbles.json',
                  fit: BoxFit.fitHeight,
                  repeat: true,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.centerRight,
              child: FractionallySizedBox(
                widthFactor: 0.4,
                child: Lottie.asset(
                  'assets/animation/Bubbles.json',
                  fit: BoxFit.fitHeight,
                  repeat: true,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Hata Listener
  Widget errorListener({required Widget child}) {
    return BlocListener<CleanerCubit, CleanerState>(
      listenWhen: (prev, curr) => prev.error != curr.error,
      listener: (_, state) => showErrorSnack(state.error),
      child: child,
    );
  }
}
