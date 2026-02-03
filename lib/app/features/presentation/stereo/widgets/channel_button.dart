import 'dart:math';

import 'package:flutter/material.dart';
import 'package:water_eject/app/common/constant/app_icons.dart';
import 'package:water_eject/app/common/constant/colors.dart';
import 'package:water_eject/app/common/enum/stereo_channel_enum.dart';
import 'package:water_eject/core/extensions/padding_extensions.dart';

class ChannelButton extends StatelessWidget {
  final String label;
  final StereoChannel side;
  final bool isActive; // şu an çalıyor mu
  final bool isSelected; // kullanıcı seçimi
  final VoidCallback onTap;

  const ChannelButton({
    super.key,
    required this.label,
    required this.side,
    required this.isActive,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final baseBg = theme.colorScheme.surface.withValues(alpha: 0.08);
    final selBg = theme.colorScheme.primary.withValues(alpha: 0.10);
    final activeBg = theme.colorScheme.primary.withValues(alpha: 0.15);

    final bg = isActive
        ? activeBg
        : isSelected
        ? selBg
        : baseBg;

    final ringColor = isActive
        ? theme.colorScheme.primary.withValues(alpha: 0.95)
        : isSelected
        ? theme.colorScheme.primary.withValues(alpha: 0.55)
        : theme.dividerColor.withValues(alpha: 0.25);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(999),
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: bg,
              gradient: isActive
                  ? RadialGradient(
                      colors: [
                        theme.colorScheme.primary.withValues(alpha: 0.20),
                        activeBg,
                      ],
                    )
                  : null,
              border: Border.all(
                color: ringColor,
                width: isActive ? 2.2 : (isSelected ? 1.6 : 1.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: 0.06),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
                if (isActive)
                  BoxShadow(
                    color: theme.colorScheme.primary.withValues(alpha: 0.22),
                    blurRadius: 22,
                    spreadRadius: 1,
                    offset: const Offset(0, 8),
                  ),
              ],
            ),
            child: side == StereoChannel.left
                ? Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(pi),
                    child: Icon(AppIcons.volumeUp.iconData, size: 40),
                  )
                : Icon(AppIcons.volumeUp.iconData, size: 40),
          ),
        ),
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.85),
          ),
        ).onlyPadding(top: 10),
      ],
    );
  }
}
