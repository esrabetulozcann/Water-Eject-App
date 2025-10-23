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
        final bool dirUp = state.freq > state.prevFreq;

        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onVerticalDragStart: (_) {
            HapticFeedback.selectionClick(); // opsiyonel
          },
          onVerticalDragUpdate: (details) {
            context.read<ToneCubit>().onVerticalDrag(details.delta.dy);
          },
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 180),
            transitionBuilder: (child, anim) {
              final offset = Tween<Offset>(
                begin: Offset(0, dirUp ? 0.5 : -0.5),
                end: Offset.zero,
              ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOut));
              return ClipRect(
                child: SlideTransition(position: offset, child: child),
              );
            },
            child: Text(
              "${state.freq.round()} Hz",
              key: ValueKey<int>(state.freq.round()),
              style: theme.textTheme.displayLarge,
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}
