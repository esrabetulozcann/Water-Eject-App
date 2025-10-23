import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final int currentPage;
  final int pageCount;
  final ValueChanged<int>? onPageSelected;

  const PageIndicator({
    super.key,
    required this.currentPage,
    required this.pageCount,
    this.onPageSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      children: [
        // Progress bar container
        Container(
          height: 6,
          decoration: BoxDecoration(
            color: colors.onSurface.withOpacity(0.2),
            borderRadius: BorderRadius.circular(3),
          ),
          child: Stack(
            children: [
              // Doluluk - SOL'dan SAĞ'a doğru ilerleyen
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width:
                    (MediaQuery.of(context).size.width - 48) *
                    ((currentPage + 1) / pageCount),
                decoration: BoxDecoration(
                  color: colors.primary,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),

        // Sayfa numaraları
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${currentPage + 1}/$pageCount',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: colors.onSurface.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
