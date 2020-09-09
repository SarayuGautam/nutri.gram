import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:nutrigram_app/app/locator.dart';
import 'package:nutrigram_app/common/ui/components/appbar_head.dart';
import 'package:nutrigram_app/common/ui/components/custom_home_card.dart';
import 'package:nutrigram_app/common/ui/components/health_tips_card.dart';
import 'package:nutrigram_app/common/ui/ui_helpers.dart';
import 'package:nutrigram_app/constants/constants.dart';
import 'package:nutrigram_app/ui/views/home/home_viewmodel.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  final Function goToScanPage;
  const HomeView({Key key, this.goToScanPage}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      fireOnModelReadyOnce: true,
      builder: (BuildContext context, HomeViewModel model, Widget child) =>
          Scaffold(
        body: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            key: const PageStorageKey("HOME-PAGE-STORAGE-KEY"),
            children: [
              llHeightSpan,
              Padding(
                padding: lXPadding,
                child: Column(
                  children: [
                    const CustomNavBar(
                      navBarItemTitle: "Welcome",
                      blackString: "Be conscious about ",
                      blueString: "what you eat!",
                    ),
                    mHeightSpan,
                    CustomHomeCard(),
                  ],
                ),
              ),
              sHeightSpan,
              Container(
                width: double.infinity,
                color: kGapColor,
                height: 10,
              ),
              sHeightSpan,
              const Padding(
                padding: lXPadding,
                child: CustomNavBar(
                  navBarItemTitle: "Health Tips",
                  blackString: "We care about your ",
                  blueString: "intake and health",
                  isSecondary: true,
                ),
              ),
              sHeightSpan,
              Container(
                height: 270,
                padding: model.isBusy ? lXPadding : EdgeInsets.zero,
                child: model.isBusy
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Shimmer(
                          enabled: model.isBusy,
                          color: kGapColor,
                          duration: const Duration(seconds: 2),
                          child: Container(
                            color: kGapColor,
                          ),
                        ),
                      )
                    : Swiper(
                        key: const PageStorageKey("HOME-PAGE-TIPS-STORAGE-KEY"),
                        itemCount: model.healthTipList.length,
                        viewportFraction: 0.85,
                        scale: 0.95,
                        fade: 0.5,
                        itemBuilder: (BuildContext context, int index) =>
                            HealthTipsCard(
                          healthTip: model.healthTipList[index],
                          onBottomSheetClosed: model.resumeSlider,
                          onPressed: model.pauseSlider,
                        ),
                        autoplay: model.tipsSliderAutoplay,
                        autoplayDelay: 4000,
                      ),
              ),
              mHeightSpan,
              // Spacer()
            ],
          ),
        ),
      ),
      viewModelBuilder: () => locator<HomeViewModel>(),
      onModelReady: (model) {
        model.onScanPressed = goToScanPage;
        model.init();
      },
      disposeViewModel: false,
    );
  }
}
