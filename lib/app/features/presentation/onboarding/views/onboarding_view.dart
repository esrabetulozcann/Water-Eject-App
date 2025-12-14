import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_eject/app/common/constant/localization_keys.dart';
import 'package:water_eject/app/domain/models/onboarding_model.dart';
import 'package:water_eject/app/features/presentation/onboarding/cubit/onboarding_cubit.dart';
import 'package:water_eject/app/features/presentation/onboarding/cubit/onboarding_state.dart';
import 'package:water_eject/app/features/presentation/onboarding/widgets/onboarding_item.dart';
import 'package:water_eject/core/assets/images.dart';
import 'package:water_eject/core/extensions/padding_extensions.dart';

class OnboardingView extends StatelessWidget {
  OnboardingView({super.key});

  final PageController pageController = PageController();

  final List<OnboardingModel> pages = [
    OnboardingModel(
      title: LocaleKeys.onboardingTitleOne.tr(),
      description: LocaleKeys.onboardingDescriptionOne.tr(),
      imagePath: Images.instance.imgOnboardingOne,
    ),
    OnboardingModel(
      title: LocaleKeys.onboardingTitleTwo.tr(),
      description: LocaleKeys.onboardingDescriptionTwo.tr(),
      imagePath: Images.instance.imgOnboardingTwo,
    ),
    OnboardingModel(
      title: LocaleKeys.onboardingTitleThree.tr(),
      description: LocaleKeys.onboardingDescriptionThree.tr(),
      imagePath: Images.instance.imgOnboardingThree,
    ),
  ];

  Future<void> _completeOnboarding(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_completed', true);

    if (!context.mounted) return;

    Navigator.pushReplacementNamed(context, "/cleaner");
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingCubit(),
      child: BlocBuilder<OnboardingCubit, OnboardingState>(
        builder: (context, state) {
          final cubit = context.read<OnboardingCubit>();

          return Scaffold(
            body: Stack(
              children: [
                PageView.builder(
                  controller: pageController,
                  itemCount: pages.length,
                  onPageChanged: (index) {
                    cubit.updatePage(index);
                  },
                  itemBuilder: (context, index) {
                    return OnboardingItem(model: pages[index]);
                  },
                ),

                //  Skip
                Positioned(
                  right: 20,
                  top: 50,
                  child: GestureDetector(
                    onTap: () {
                      _completeOnboarding(context); // skip
                    },

                    child: Text(
                      LocaleKeys.skip.tr(),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ),
                ),

                //  Footer Button
                Positioned(
                  bottom: 40,
                  left: 20,
                  right: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      if (state is OnboardingInitial &&
                          state.pageIndex < pages.length - 1) {
                        pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        _completeOnboarding(context);
                      }
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      state is OnboardingInitial && state.pageIndex == 2
                          ? LocaleKeys.start.tr()
                          : LocaleKeys.nextTwo.tr(),
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ).onlyPadding(bottom: 40, left: 20, right: 20),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
