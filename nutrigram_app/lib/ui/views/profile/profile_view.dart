import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nutrigram_app/app/locator.dart';
import 'package:nutrigram_app/common/ui/components/custom_nav_bar.dart';
import 'package:nutrigram_app/common/ui/components/icon_button.dart';
import 'package:nutrigram_app/common/ui/components/list_button.dart';
import 'package:nutrigram_app/common/ui/functions/show_custom_bottomsheet.dart';
import 'package:nutrigram_app/common/ui/ui_helpers.dart';
import 'package:nutrigram_app/constants/constants.dart';
import 'package:nutrigram_app/constants/strings.dart';
import 'package:nutrigram_app/ui/views/profile/profile_viewmodel.dart';
import 'package:nutrigram_app/ui/views/profile/update_profile_form/update_profile_form_view.dart';
import 'package:stacked/stacked.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => locator<ProfileViewModel>(),
      disposeViewModel: false,
      fireOnModelReadyOnce: true,
      onModelReady: (model) => model.getMyProfile(),
      builder: (BuildContext ctx, ProfileViewModel model, Widget child) =>
          MediaQuery.removePadding(
        removeTop: true,
        context: ctx,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          key: const PageStorageKey("PROFILE-PAGE-STORAGE-KEY"),
          children: [
            llHeightSpan,
            Padding(
              padding: lXPadding,
              child: Column(
                children: <Widget>[
                  CustomNavBar(
                    navBarItemTitle: "Profile",
                    blackString: "Update your ",
                    blueString: "profile",
                    isProfilePage: true,
                    onActionPressed: model.logout,
                  ),
                  llHeightSpan,
                  _ProfileTop(),
                  lHeightSpan,
                  ListButton(
                    icon: Icons.edit,
                    label: "Edit Profile",
                    onPressed: () => showCustomBottomSheet(
                      ctx,
                      child: UpdateProfileFormView(),
                      onDismiss: model.notifyListeners,
                    ),
                  ),
                  mHeightSpan,
                  ListButton(
                    icon: Icons.history,
                    label: "See scan history",
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            lHeightSpan,
            Container(
              width: double.infinity,
              color: kGapColor,
              height: 10,
            ),
            sHeightSpan,
            Padding(
              padding: lXPadding,
              child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const CustomNavBar(
                    navBarItemTitle: "Your intake till now",
                    blackString: "Visualize ",
                    blueString: "your intake",
                    isSecondary: true,
                  ),
                  lHeightSpan,
                  const Center(child: Text("Graph Here")),
                ],
              ),
            ),
            lHeightSpan,
          ],
        ),
      ),
    );
  }
}

class _ProfileTop extends ViewModelWidget<ProfileViewModel> {
  @override
  Widget build(BuildContext context, ProfileViewModel model) {
    return Padding(
      padding: sXPadding,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: getBoxShadow(context, kPrimaryColor)),
                    child: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                        model.imageUrl,
                      ),
                      backgroundColor: kPrimaryColor,
                      maxRadius: 42.0,
                    ),
                  ),
                  lWidthSpan,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        model.namme,
                        style: Theme.of(context).textTheme.button,
                      ),
                      xsHeightSpan,
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: phoneNum,
                              style: Theme.of(context).textTheme.caption,
                            ),
                            TextSpan(
                              text: model.phone,
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(color: kPrimaryColor),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
              CustomIconButton(
                color: kPrimaryColor,
                gradientColor: Colors.blue,
                icon: Icons.add_photo_alternate,
                iconSize: 25,
                radius: 27,
                onPressed: model.goToImagePicker,
              )
            ],
          ),
          llHeightSpan,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    model.totalScans,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  sHeightSpan,
                  Text(
                    "Total Scans",
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          color: kPrimaryLightTextColor,
                        ),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    model.totalSaved,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  sHeightSpan,
                  Text(
                    "Saved",
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          color: kPrimaryLightTextColor,
                        ),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    model.totalCalories,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  sHeightSpan,
                  Text(
                    "Total Calories",
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          color: kPrimaryLightTextColor,
                        ),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
