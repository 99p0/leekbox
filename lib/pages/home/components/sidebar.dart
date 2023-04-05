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
              activeIcon: PhosphorIcons.circleDashed,
              icon: PhosphorIcons.circleDashed,
              label: "Dashboard",
            ),
            SelectionButtonData(
              activeIcon: PhosphorIcons.archive,
              icon: PhosphorIcons.archive,
              label: "Reports",
            ),
            SelectionButtonData(
              activeIcon: PhosphorIcons.calendar,
              icon: PhosphorIcons.calendar,
              label: "Calendar",
            ),
            SelectionButtonData(
              activeIcon: PhosphorIcons.magicWand,
              icon: PhosphorIcons.magicWand,
              label: "Email",
              totalNotif: 20,
            ),
            SelectionButtonData(
              activeIcon: PhosphorIcons.person,
              icon: PhosphorIcons.person,
              label: "Profil",
            ),
            SelectionButtonData(
              activeIcon: PhosphorIcons.scales,
              icon: PhosphorIcons.scalesFill,
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
