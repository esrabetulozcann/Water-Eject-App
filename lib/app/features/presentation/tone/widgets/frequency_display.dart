import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/tone_cubit.dart';
import '../cubit/tone_state.dart';

class FrequencyDisplay extends StatelessWidget {
  const FrequencyDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<ToneCubit, ToneState>(
      buildWhen: (p, c) => p.freq != c.freq || p.prevFreq != c.prevFreq,
      builder: (context, state) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onVerticalDragStart: (_) => HapticFeedback.selectionClick(),
          onVerticalDragUpdate: (details) =>
              context.read<ToneCubit>().onVerticalDrag(details.delta.dy),
          child: SizedBox(
            height: 120, // sabit yükseklik: layout zıplamaz
            child: Center(
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: state.prevFreq, end: state.freq),
                duration: const Duration(milliseconds: 150),
                curve: Curves.easeOutCubic,
                builder: (_, value, __) {
                  return Text(
                    '${value.toStringAsFixed(0)} Hz',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.displayLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      height: 1.1,
                      // Rakamların hizası sabit → kayma yok
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
