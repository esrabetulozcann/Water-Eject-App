import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_eject/app/common/router/app_router.dart';
import '../cubit/onboarding_cubit.dart';
import '../widgets/onboarding_header_widget.dart';
import '../widgets/onboarding_content_widget.dart';
import 'package:water_eject/app/domain/models/onboarding_models.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = OnboardingData.pages;
    return BlocProvider(
      create: (_) => OnboardingCubit(totalPages: pages.length),
      child: _OnboardingContent(pages: pages),
    );
  }
}

class _OnboardingContent extends StatelessWidget {
  const _OnboardingContent({required this.pages});
  final List<OnboardingPageModel> pages;

  @override
  Widget build(BuildContext context) {
    Future<void> complete() async {
      // ✅ await ÖNCESİ: navigasyon aksiyonunu hazırla
      final nav = Navigator.of(context);
      final routeAction = nav.canPop()
          ? () => nav.pop(true)
          : () => nav.pushNamedAndRemoveUntil(AppRouter.cleaner, (r) => false);

      // ✅ flag’i yaz
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('onboarding_done', true);

      // ✅ await SONRASI: context’e dokunmadan aksiyonu çalıştır
      routeAction();
    }

    return BlocBuilder<OnboardingCubit, int>(
      builder: (context, currentPage) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                OnboardingHeaderWidget(
                  currentPage: currentPage,
                  onSkip: complete, // ✅ Skip artık buradan
                ),
                OnboardingContentWidget(
                  pages: pages,
                  onComplete: complete, // ✅ Son sayfa Next de buradan
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
