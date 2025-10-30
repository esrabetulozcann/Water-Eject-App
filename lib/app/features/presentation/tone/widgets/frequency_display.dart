import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_eject/core/localization/locale_keys.g.dart';
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
        final cubit = context.read<ToneCubit>();

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //  (+)
            GestureDetector(
              onTap: () async {
                HapticFeedback.selectionClick();
                await cubit.setFreq(state.freq + 1);
              },
              child: Container(
                padding: const EdgeInsets.all(4),
                child: Text(
                  LocaleKeys.plus.tr(),
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            // kutu içinde frekans
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onVerticalDragStart: (_) => HapticFeedback.selectionClick(),
              onVerticalDragUpdate: (details) =>
                  cubit.onVerticalDrag(details.delta.dy),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Theme.of(
                      context,
                    ).colorScheme.outline.withOpacity(0.2),
                    width: 1.2,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: state.prevFreq, end: state.freq),
                  duration: const Duration(milliseconds: 150),
                  curve: Curves.easeOutCubic,
                  builder: (_, value, __) {
                    return Text(
                      '${value.toStringAsFixed(0)} Hz',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        height: 1.1,
                        fontFeatures: const [FontFeature.tabularFigures()],
                      ),
                    );
                  },
                ),
              ),
            ),

            // (−)
            GestureDetector(
              onTap: () async {
                HapticFeedback.selectionClick();
                await cubit.setFreq(state.freq - 1);
              },
              child: Container(
                padding: const EdgeInsets.all(4),
                child: Text(
                  LocaleKeys.minus.tr(),
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
