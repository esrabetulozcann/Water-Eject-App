import 'package:flutter/material.dart';
import 'package:water_eject/app/common/constant/app_icons.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Icon(
        icon,
        color: theme.colorScheme.onSurface,
      ), //  Theme.of(context).colorScheme.outline.withOpacity(0.2)
      title: Text(title, style: theme.textTheme.bodyMedium),
      trailing: Icon(AppIcons.chevronRight.iconData),
      onTap: onTap,
    );
  }
}
