import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_eject/app/common/router/app_router.dart';
import 'package:water_eject/app/domain/models/onboarding_models.dart';
import 'package:water_eject/app/features/presentation/onboarding/views/onboarding_page.dart';
import '../cubit/onboarding_cubit.dart';

class OnboardingContentWidget extends StatelessWidget {
  const OnboardingContentWidget({super.key, required this.pages});
  final List<OnboardingPageModel> pages;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnboardingCubit>();

    return Expanded(
      child: PageView.builder(
        controller: cubit.pageController,
        physics: const BouncingScrollPhysics(),
        itemCount: pages.length,
        onPageChanged: cubit.goToPage,
        itemBuilder: (ctx, i) {
          final isLast = i == pages.length - 1;
          return OnboardingPageWidget(
            page: pages[i],
            isLastPage: isLast,
            onNext: () async {
              if (isLast) {
                // 1) await ÖNCESİ: context’ten ihtiyacın olanları al
                final nav = Navigator.of(context);
                final canPopNow = nav.canPop();

                // await sonrası çalıştırılacak eylemi önceden hazırla
                final void Function() routeAction = canPopNow
                    ? () => nav.pop(true)
                    : () => nav.pushNamedAndRemoveUntil(
                        AppRouter.cleaner,
                        (r) => false,
                      );

                // 2) async işler
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('onboarding_done', true);

                // 3) await SONRASI: context kullanmadan, önceden hazırladığın eylemi çağır
                routeAction();
              } else {
                await cubit.nextPage();
              }
            },

            onSkip: () => Navigator.of(context).maybePop(),
          );
        },
      ),
    );
  }
}
