import 'package:flutter/material.dart';
import 'package:water_eject/app/common/constant/colors.dart';
import 'package:water_eject/app/domain/models/settings_option_model.dart';

class SettingsExpandableChoiceTile<T> extends StatelessWidget {
  const SettingsExpandableChoiceTile({
    super.key,
    required this.title,
    required this.selected,
    required this.options,
    required this.onChanged,
    this.leadingIcon,
  });

  final String title;
  final T selected;
  final List<SettingsOption<T>> options;
  final ValueChanged<T> onChanged;
  final IconData? leadingIcon;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      color: colors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: AppColors.transparent),
        child: ExpansionTile(
          leading: leadingIcon == null
              ? null
              : Icon(leadingIcon, color: colors.primary),
          title: Text(title, style: Theme.of(context).textTheme.titleMedium),
          children: options.map((o) {
            final isSelected = o.value == selected;
            return ListTile(
              leading: o.icon == null ? null : Icon(o.icon),
              title: Text(o.label),
              trailing: AnimatedOpacity(
                opacity: isSelected ? 1 : 0,
                duration: const Duration(milliseconds: 150),
                child: const Icon(Icons.check, size: 20),
              ),
              onTap: () => onChanged(o.value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
