import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_eject/app/common/enum/paywall_plan_type_enum.dart';
import '../cubit/paywall_selection_cubit.dart';

class PackageCard extends StatelessWidget {
  const PackageCard({
    super.key,
    required this.type,
    required this.title,
    required this.period,
    required this.currency,
    required this.major,
    required this.minor,
    this.badgeText,
    this.monthlyNote,
  });

  final PlanType type;
  final String title;
  final String period; // "/month" veya "/year"
  final String currency; // "₺"
  final int major; // 19
  final int minor; // 99
  final String? badgeText; // "%58 Savings"
  final String? monthlyNote; // "with yearly ... ₺8.33"

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return BlocBuilder<PaywallSelectionCubit, PlanType>(
      builder: (context, selected) {
        final isSelected = selected == type;

        // Kartlar kaymasın diye sabit yükseklik
        const double kCardHeight = 160;

        return InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () => context.read<PaywallSelectionCubit>().select(type),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeOut,
            height: kCardHeight,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isSelected
                  ? colors.primary.withOpacity(0.06)
                  : colors.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isSelected ? colors.primary : colors.outlineVariant,
                width: isSelected ? 2 : 1,
              ),
              boxShadow: [
                if (isSelected)
                  BoxShadow(
                    color: colors.primary.withOpacity(0.12),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // her iki kartta da yer ayır: Opacity
                SizedBox(
                  height: 20,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: badgeText == null
                        ? const Opacity(opacity: 0.0, child: _Badge(text: 'x'))
                        : _Badge(text: badgeText!),
                  ),
                ),
                const SizedBox(height: 6),

                // Başlık
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: isSelected ? colors.primary : colors.onSurface,
                  ),
                ),
                const SizedBox(height: 4),

                // Fiyat
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      currency,
                      style: TextStyle(
                        fontSize: 16,
                        color: isSelected ? colors.primary : colors.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 2),
                    Text(
                      '$major',
                      style: TextStyle(
                        fontSize: 28,
                        height: 1.0,
                        fontWeight: FontWeight.w800,
                        color: isSelected ? colors.primary : colors.onSurface,
                      ),
                    ),
                    Text(
                      ',${minor.toString().padLeft(2, '0')}',
                      style: TextStyle(
                        fontSize: 18,
                        height: 1.2,
                        fontWeight: FontWeight.w700,
                        color: isSelected ? colors.primary : colors.onSurface,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      period,
                      style: TextStyle(
                        fontSize: 12,
                        color: colors.onSurface.withOpacity(0.65),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                // Alt not (yıllık için aylık karşılığı)
                SizedBox(
                  height: 18,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: monthlyNote == null
                        ? const Opacity(opacity: 0.0, child: Text('—'))
                        : Text(
                            monthlyNote!,
                            style: TextStyle(
                              fontSize: 12,
                              color: colors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: colors.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: colors.onPrimary,
          fontSize: 10,
          fontWeight: FontWeight.w800,
          letterSpacing: .2,
        ),
      ),
    );
  }
}
