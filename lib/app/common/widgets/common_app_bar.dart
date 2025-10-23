import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.centerTitle = false,
    this.showSettings = true,
    this.onSettingsPressed,
    this.actions,
    this.backgroundColor,
    this.elevation,
  });

  /// Üst başlık
  final String title;

  /// Alt başlık
  final String? subtitle;

  /// Geri butonu veya özel ikon.
  final Widget? leading;

  /// Başlık ortalansın mı?
  final bool centerTitle;

  /// Sağda ayarlar ikonu gözüksün mü?
  final bool showSettings;

  /// Ayarlar ikonuna basılınca ne olsun?
  /// Vermezsen varsayılan olarak showAboutDialog açar.
  final VoidCallback? onSettingsPressed;

  /// Ek aksiyonlar (peak reset, paylaş, vs.)
  final List<Widget>? actions;

  /// Stil ayarları
  final Color? backgroundColor;
  final double? elevation;

  double get _height => subtitle == null ? kToolbarHeight : 64;

  @override
  Size get preferredSize => Size.fromHeight(_height);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      backgroundColor: backgroundColor,
      elevation: elevation,
      centerTitle: centerTitle,
      leading: leading,
      toolbarHeight: _height,
      titleSpacing: 0,
      title: Column(
        crossAxisAlignment: centerTitle
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          if (subtitle != null)
            Text(
              subtitle!,
              style: theme.textTheme.bodySmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
        ],
      ),
      actions: [
        if (actions != null) ...actions!,
        if (showSettings)
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed:
                onSettingsPressed ??
                () {
                  showAboutDialog(context: context, applicationName: title);
                },
            tooltip: 'settings'.tr(),
          ),
      ],
    );
  }
}
