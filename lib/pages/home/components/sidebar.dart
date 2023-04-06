import 'package:flutter/material.dart';
import 'package:leekbox/common/utils/utils.dart';
import 'package:leekbox/common/widgets/gaps.dart';
import 'package:leekbox/pages/home/components/user_profile.dart';
import 'package:leekbox_infra/log/log.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'selection_button.dart';

final dataProfil = UserProfileData(
  image: ImageUtils.getAssetImage('common/def_avatar'),
  name: "XNXQ",
  jobDesk: "110110",
);

class Sidebar extends StatelessWidget {
  const Sidebar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gaps.vGap32,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: UserProfile(
            data: dataProfil,
            onPressed: () {},
          ),
        ),
        Gaps.line,
        Gaps.vGap32,
        SelectionButton(
          data: [
            SelectionButtonData(
              activeIcon: PhosphorIcons.regular.circleDashed,
              icon: PhosphorIcons.regular.circleDashed,
              label: "Dashboard",
            ),
            SelectionButtonData(
              activeIcon: PhosphorIcons.regular.archive,
              icon: PhosphorIcons.regular.archive,
              label: "Reports",
            ),
            SelectionButtonData(
              activeIcon: PhosphorIcons.regular.calendar,
              icon: PhosphorIcons.regular.calendar,
              label: "Calendar",
            ),
            SelectionButtonData(
              activeIcon: PhosphorIcons.regular.magicWand,
              icon: PhosphorIcons.regular.magicWand,
              label: "Email",
              totalNotif: 20,
            ),
            SelectionButtonData(
              activeIcon: PhosphorIcons.regular.person,
              icon: PhosphorIcons.regular.person,
              label: "Profil",
            ),
            SelectionButtonData(
              activeIcon: PhosphorIcons.regular.scales,
              icon: PhosphorIcons.regular.scales,
              label: "Setting",
            ),
          ],
          onSelected: (index, value) {
            Log.debug("index : $index | label : ${value.label}");
          },
        ),
        Gaps.vGap50,
        Gaps.line,
        Gaps.vGap50,
        Center(
          child: Column(
            children: [
              Image.asset(
                ImageUtils.getImgPath('common/ic_logo'),
                width: 80,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "2023 @99p0team LICENSE",
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
