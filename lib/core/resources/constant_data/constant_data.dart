import 'package:evently/core/resources/icons/icons_manager.dart';
import 'package:evently/core/resources/images/images_manager.dart';
import 'package:flutter/material.dart';

import '../../../DM/CategoryDM.dart';
import '../../../DM/eventDM.dart';
import '../../../l10n/app_localizations.dart';

class ConstantManager {
  static List<CategoryDM> getCategoriesWithAll(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return [
      CategoryDM(
        id: "0",
        name: loc.all,
        icon: Icons.apps,
        darkImgPath: ImagesManager.holiday,
        lightImgPath: ImagesManager.lHoliday,
      ),

      CategoryDM(
        id: "1",
        name: loc.book_club,
        icon: Icons.menu_book,
        darkImgPath: ImagesManager.bookClub,
        lightImgPath: ImagesManager.lBook,
      ),

      CategoryDM(
        id: "2",
        name: loc.birthday,
        icon: Icons.cake,
        darkImgPath: ImagesManager.birthday,
        lightImgPath: ImagesManager.lBirthday,
      ),

      CategoryDM(
        id: "3",
        name: loc.meeting,
        icon: Icons.groups,
        darkImgPath: ImagesManager.meeting,
        lightImgPath: ImagesManager.lMeeting,
      ),

      CategoryDM(
        id: "4",
        name: loc.gaming,
        icon: Icons.sports_esports,
        darkImgPath: ImagesManager.gaming,
        lightImgPath: ImagesManager.lGaming,
      ),

      CategoryDM(
        id: "5",
        name: loc.eating,
        icon: Icons.restaurant,
        darkImgPath: ImagesManager.eating,
        lightImgPath: ImagesManager.lEating,
      ),

      CategoryDM(
        id: "6",
        name: loc.holiday,
        icon: Icons.beach_access,
        darkImgPath: ImagesManager.holiday,
        lightImgPath: ImagesManager.lHoliday,
      ),

      CategoryDM(
        id: "7",
        name: loc.exhibition,
        icon: Icons.event,
        darkImgPath: ImagesManager.exhibition,
        lightImgPath: ImagesManager.lExhibition,
      ),

      CategoryDM(
        id: "8",
        name: loc.workshop,
        icon: Icons.build,
        darkImgPath: ImagesManager.workshop,
        lightImgPath: ImagesManager.lWork,
      ),
    ];
  }


  static List<CategoryDM> getCategories(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return [

      CategoryDM(
        id: "1",
        name: loc.book_club,
        icon: Icons.menu_book,
        darkImgPath: ImagesManager.bookClub,
        lightImgPath: ImagesManager.lBook,
      ),

      CategoryDM(
        id: "2",
        name: loc.birthday,
        icon: Icons.cake,
        darkImgPath: ImagesManager.birthday,
        lightImgPath: ImagesManager.lBirthday,
      ),

      CategoryDM(
        id: "3",
        name: loc.meeting,
        icon: Icons.groups,
        darkImgPath: ImagesManager.meeting,
        lightImgPath: ImagesManager.lMeeting,
      ),

      CategoryDM(
        id: "4",
        name: loc.gaming,
        icon: Icons.sports_esports,
        darkImgPath: ImagesManager.gaming,
        lightImgPath: ImagesManager.lGaming,
      ),

      CategoryDM(
        id: "5",
        name: loc.eating,
        icon: Icons.restaurant,
        darkImgPath: ImagesManager.eating,
        lightImgPath: ImagesManager.lEating,
      ),

      CategoryDM(
        id: "6",
        name: loc.holiday,
        icon: Icons.beach_access,
        darkImgPath: ImagesManager.holiday,
        lightImgPath: ImagesManager.lHoliday,
      ),

      CategoryDM(
        id: "7",
        name: loc.exhibition,
        icon: Icons.event,
        darkImgPath: ImagesManager.exhibition,
        lightImgPath: ImagesManager.lExhibition,
      ),

      CategoryDM(
        id: "8",
        name: loc.workshop,
        icon: Icons.build,
        darkImgPath: ImagesManager.workshop,
        lightImgPath: ImagesManager.lWork,
      ),
    ];
  }
}



