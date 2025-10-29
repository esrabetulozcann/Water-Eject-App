import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:water_eject/app/common/constant/localization_keys.dart';
import 'package:water_eject/app/features/presentation/cleaner/cubit/cleaner_state.dart';
import 'package:water_eject/app/common/enum/intensity_enum.dart';
import '../cubit/cleaner_cubit.dart';

class IntensitySelector extends StatelessWidget {
  const IntensitySelector({super.key});

  // Aynı değerleri hem slider hem etiketlerde kullanıyoruz
  static const double _kSliderPad = 24.0; // Material Slider iç boşluğu
  static const double _kSidePad = 12.0; // Senin dış kenar boşluğun

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CleanerCubit, CleanerState>(
      buildWhen: (p, c) => p.intensity != c.intensity || p.running != c.running,
      builder: (context, state) {
        final cubit = context.read<CleanerCubit>();
        final currentValue = state.intensity.index.toDouble(); // 0..2

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            _buildIntensitySlider(context, state, cubit, currentValue),
            const SizedBox(height: 8),
            _buildIntensityLabels(context, state.intensity),
          ],
        );
      },
    );
  }

  Widget _buildIntensitySlider(
    BuildContext context,
    CleanerState state,
    CleanerCubit cubit,
    double currentValue,
  ) {
    final double progress = (currentValue / 2.0).clamp(0.0, 1.0).toDouble();

    return SizedBox(
      height: 48,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double trackWidth =
              constraints.maxWidth - 2 * (_kSidePad + _kSliderPad);
          final double trackLeft = _kSidePad + _kSliderPad;
          final double barWidth = (trackWidth * progress)
              .clamp(0.0, trackWidth)
              .toDouble();

          return Stack(
            children: [
              // BEYAZ TRACK
              Positioned(
                left: trackLeft,
                right: trackLeft,
                top: 20,
                child: Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),

              // RENKLİ KISIM
              Positioned(
                left: trackLeft,
                width: barWidth,
                top: 20,
                child: Container(
                  height: 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(4),
                      bottomLeft: const Radius.circular(4),
                      topRight: progress > 0
                          ? Radius.zero
                          : const Radius.circular(4),
                      bottomRight: progress > 0
                          ? Radius.zero
                          : const Radius.circular(4),
                    ),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF87CEEB),
                        Color(0xFF4682B4),
                        Color(0xFF00008B),
                      ],
                    ),
                  ),
                ),
              ),

              // SLIDER (kendi track’ini gizliyoruz)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: _kSidePad),
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 0,
                    inactiveTrackColor: Colors.transparent,
                    activeTrackColor: Colors.transparent,
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 14,
                    ),
                    overlayShape: const RoundSliderOverlayShape(
                      overlayRadius: 20,
                    ),
                    thumbColor: _getThumbColorForValue(currentValue),
                    overlayColor: _getThumbColorForValue(
                      currentValue,
                    ).withOpacity(0.2),
                  ),
                  child: Slider(
                    value: currentValue,
                    min: 0,
                    max: 2,
                    divisions: 20,
                    label: _getIntensityLabel(
                      Intensity.values[currentValue.round()],
                    ),
                    onChanged: state.running
                        ? null
                        : (value) {
                            final intensity = Intensity.values[value.round()];
                            cubit.setIntensity(intensity);
                          },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildIntensityLabels(
    BuildContext context,
    Intensity currentIntensity,
  ) {
    // Etiketleri track ile aynı yatay başlangıç/bitişe hizalıyoruz
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: _kSidePad + _kSliderPad),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildLabel(context, Intensity.soft, currentIntensity),
          _buildLabel(context, Intensity.medium, currentIntensity),
          _buildLabel(context, Intensity.strong, currentIntensity),
        ],
      ),
    );
  }

  Widget _buildLabel(
    BuildContext context,
    Intensity intensity,
    Intensity currentIntensity,
  ) {
    final isSelected = intensity == currentIntensity;
    return Column(
      children: [
        Text(
          _getIntensityText(intensity),
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: isSelected
                ? _getThumbColorForValue(intensity.index.toDouble())
                : Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: isSelected
                ? _getThumbColorForValue(intensity.index.toDouble())
                : Colors.transparent,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }

  // ---- helpers ----

  Color _getThumbColorForValue(double value) {
    final double normalizedValue = (value / 2.0).clamp(0.0, 1.0).toDouble();

    if (normalizedValue < 0.5) {
      final ratio = (normalizedValue * 2).toDouble(); // 0..1
      return Color.lerp(
        const Color(0xFF87CEEB),
        const Color(0xFF4682B4),
        ratio,
      )!;
    } else {
      final ratio = ((normalizedValue - 0.5) * 2).toDouble(); // 0..1
      return Color.lerp(
        const Color(0xFF4682B4),
        const Color(0xFF00008B),
        ratio,
      )!;
    }
  }

  String _getIntensityLabel(Intensity intensity) {
    switch (intensity) {
      case Intensity.soft:
        return LocaleKeys.intensitySoft.tr();
      case Intensity.medium:
        return LocaleKeys.intensityMedium.tr();
      case Intensity.strong:
        return LocaleKeys.intensityStrong.tr();
    }
  }

  String _getIntensityText(Intensity intensity) {
    switch (intensity) {
      case Intensity.soft:
        return LocaleKeys.intensitySoft.tr();
      case Intensity.medium:
        return LocaleKeys.intensityMedium.tr();
      case Intensity.strong:
        return LocaleKeys.intensityStrong.tr();
    }
  }
}
