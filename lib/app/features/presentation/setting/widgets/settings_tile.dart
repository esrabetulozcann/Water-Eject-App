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
    return ListTile(
      leading: Icon(
        icon,
        color: Theme.of(context).colorScheme.onSurface,
      ), //  Theme.of(context).colorScheme.outline.withOpacity(0.2)
      title: Text(title, style: Theme.of(context).textTheme.titleMedium),
      trailing: Icon(AppIcons.chevronRight.iconData),
      onTap: onTap,
    );
  }
}
