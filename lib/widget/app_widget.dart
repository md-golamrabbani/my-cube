import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:travel/utils/dimensions_utils.dart';
import 'package:travel/utils/rgb_utils.dart';
import 'package:unicons/unicons.dart';

class AppWidget {
  static Widget myAppBar() {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.only(
        top: Dimensions.smSize / 2,
        bottom: Dimensions.smSize,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(
              100,
            ),
            child: Image.asset(
              'assets/images/user.jpg',
              width: 38,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            width: 30,
            height: 30,
            child: PopupMenuButton(
              padding: const EdgeInsets.all(0),
              offset: const Offset(0, 40),
              icon: SvgPicture.asset(
                'assets/icons/menu.svg',
                width: 40,
              ),
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    child: Row(
                      children: const [
                        Icon(
                          UniconsLine.user,
                          size: Dimensions.defaultSize * 1.25,
                        ),
                        SizedBox(width: Dimensions.defaultSize / 2),
                        Text('Profile'),
                      ],
                    ),
                    onTap: () {
                      Future(() => Get.toNamed('/profile'));
                    },
                  ),
                  PopupMenuItem(
                    enabled: true,
                    padding: const EdgeInsets.all(0),
                    child: Container(
                      padding: const EdgeInsets.all(Dimensions.defaultSize),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: RGB.border),
                      ),
                      child: Row(
                        children: const [
                          Icon(
                            UniconsLine.setting,
                            size: Dimensions.defaultSize * 1.25,
                          ),
                          SizedBox(width: Dimensions.defaultSize / 2),
                          Text('Settings'),
                        ],
                      ),
                    ),
                    onTap: () {
                      Future(() => Get.toNamed('/settings'));
                    },
                  ),
                  PopupMenuItem(
                    padding: const EdgeInsets.all(0),
                    child: Container(
                      padding: const EdgeInsets.all(Dimensions.defaultSize),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 1, color: RGB.border),
                        ),
                      ),
                      child: Row(
                        children: const [
                          Icon(
                            UniconsLine.question_circle,
                            size: Dimensions.defaultSize * 1.25,
                          ),
                          SizedBox(width: Dimensions.defaultSize / 2),
                          Text('Help Center'),
                        ],
                      ),
                    ),
                    onTap: () {},
                  ),
                  PopupMenuItem(
                    child: Row(
                      children: const [
                        Icon(
                          UniconsLine.sign_out_alt,
                          size: Dimensions.defaultSize * 1.25,
                        ),
                        SizedBox(width: Dimensions.defaultSize / 2),
                        Text('Sign Out'),
                      ],
                    ),
                    onTap: () {
                      Future(() {});
                    },
                  ),
                ];
              },
            ),
          )
        ],
      ),
    );
  }

  static Widget homeTitle() {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: Dimensions.smSize / 2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Let\'s enjoy',
            style: TextStyle(
              fontSize: Dimensions.lgSize * 1.25,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            'your Vacation !!',
            style: TextStyle(
              fontSize: Dimensions.lgSize * 1.25,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  static Widget hotelListView({
    required String picture,
    required String name,
    required String location,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: () {
        onPressed.call();
      },
      child: Container(
        margin: const EdgeInsets.only(
          bottom: Dimensions.lgSize,
        ),
        decoration: BoxDecoration(
          color: RGB.white,
          border: Border.all(
            width: 1,
            color: RGB.lightPrimary,
          ),
          borderRadius: BorderRadius.circular(
            Dimensions.defaultSize,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(
                  Dimensions.defaultSize,
                ),
                topRight: Radius.circular(
                  Dimensions.defaultSize,
                ),
              ),
              child: Image.asset(
                picture,
                width: Get.width,
              ),
            ),
            const SizedBox(
              height: Dimensions.defaultSize,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.defaultSize,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: Dimensions.lgSize,
                            color: RGB.lightDarker,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              UniconsLine.location_point,
                              color: RGB.lightDarker,
                              size: Dimensions.defaultSize,
                            ),
                            Expanded(
                              child: Text(
                                location,
                                maxLines: 1,
                                style: const TextStyle(
                                  fontSize: Dimensions.smSize,
                                  color: RGB.lightDarker,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.only(
                      right: Dimensions.defaultSize,
                    ),
                    child: const Icon(
                      UniconsLine.heart,
                      color: RGB.lightDarker,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: Dimensions.defaultSize,
            ),
          ],
        ),
      ),
    );
  }

  static Widget carListView({
    required String picture,
    required String name,
    required String location,
    required String seats,
    required String price,
    required String model,
    required String color,
    required int available,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: () {
        onPressed.call();
      },
      child: Container(
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.only(
          bottom: Dimensions.lgSize,
        ),
        decoration: BoxDecoration(
          color: RGB.white,
          border: Border.all(
            width: 1,
            color: RGB.lightPrimary,
          ),
          borderRadius: BorderRadius.circular(
            Dimensions.defaultSize,
          ),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    picture,
                    width: 100,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.defaultSize,
                      vertical: Dimensions.smSize / 2,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                right: Dimensions.smSize / 2,
                              ),
                              padding: const EdgeInsets.all(
                                Dimensions.smSize / 2,
                              ),
                              decoration: BoxDecoration(
                                color: available.toString() == '1'
                                    ? RGB.succeeLight
                                    : RGB.primary,
                                borderRadius: BorderRadius.circular(
                                  Dimensions.circleSize,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                name,
                                maxLines: 2,
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: Dimensions.defaultSize,
                                  color: RGB.lightDarker,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              UniconsLine.location_point,
                              color: RGB.lightDarker,
                              size: Dimensions.defaultSize,
                            ),
                            Text(
                              location,
                              style: const TextStyle(
                                fontSize: Dimensions.smSize,
                                color: RGB.lightDarker,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Model: $model',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: RGB.lightDarker,
                            fontSize: Dimensions.smSize,
                          ),
                        ),
                        Text(
                          'Color: $color',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: RGB.lightDarker,
                            fontSize: Dimensions.smSize,
                          ),
                        ),
                        Text(
                          'Seats: $seats',
                          style: const TextStyle(
                            fontSize: Dimensions.smSize,
                            color: RGB.lightDarker,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              price,
                              style: const TextStyle(
                                fontSize: Dimensions.lgSize + 4,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.lgSize,
                                ),
                                child: Text('Book Now'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: Dimensions.smSize,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Widget packageListView({
    required String picture,
    required String name,
    required String location,
    required String offer,
    required String price,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: () {
        onPressed.call();
      },
      child: Container(
        margin: const EdgeInsets.only(
          bottom: Dimensions.lgSize,
        ),
        decoration: BoxDecoration(
          color: RGB.white,
          border: Border.all(
            width: 1,
            color: RGB.lightPrimary,
          ),
          borderRadius: BorderRadius.circular(
            Dimensions.defaultSize,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(
                      Dimensions.defaultSize,
                    ),
                    topRight: Radius.circular(
                      Dimensions.defaultSize,
                    ),
                  ),
                  child: Image.asset(
                    picture,
                    width: Get.width,
                  ),
                ),
                Positioned(
                  top: Dimensions.smSize,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.defaultSize,
                      vertical: Dimensions.smSize,
                    ),
                    decoration: const BoxDecoration(
                      color: RGB.darkYellow2,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          Dimensions.smSize,
                        ),
                        bottomLeft: Radius.circular(
                          Dimensions.smSize,
                        ),
                      ),
                    ),
                    child: Text(
                      offer.toUpperCase(),
                      style: const TextStyle(
                        color: RGB.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: Dimensions.defaultSize,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.defaultSize,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: Dimensions.lgSize,
                            color: RGB.lightDarker,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              UniconsLine.location_point,
                              color: RGB.lightDarker,
                              size: Dimensions.defaultSize,
                            ),
                            Expanded(
                              child: Text(
                                location,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: Dimensions.smSize,
                                  color: RGB.lightDarker,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.only(
                      right: Dimensions.defaultSize,
                    ),
                    child: const Icon(
                      UniconsLine.heart,
                      color: RGB.lightDarker,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: Dimensions.defaultSize,
                right: Dimensions.defaultSize,
                bottom: Dimensions.defaultSize,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: Dimensions.lgSize + 4,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.lgSize,
                      ),
                      child: Text('Book Now'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget addButton() {
    return Container(
      width: Dimensions.defaultSize * 3,
      margin: const EdgeInsets.all(
        Dimensions.smSize / 2,
      ),
      decoration: BoxDecoration(
        color: RGB.white,
        borderRadius: BorderRadius.circular(
          Dimensions.smSize,
        ),
      ),
      child: const Icon(
        Icons.add_outlined,
        color: RGB.primary,
      ),
    );
  }

  static Widget closeButton() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(Dimensions.defaultSize),
      decoration: BoxDecoration(
        color: RGB.dark,
        borderRadius: BorderRadius.circular(Dimensions.smSize),
      ),
      child: Text(
        'CANCEL'.toUpperCase(),
        style: const TextStyle(
          color: RGB.white,
        ),
      ),
    );
  }

  static Widget submitButton() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(Dimensions.defaultSize),
      decoration: BoxDecoration(
        color: RGB.primary,
        borderRadius: BorderRadius.circular(Dimensions.smSize),
      ),
      child: Text(
        'Submit'.toUpperCase(),
        style: const TextStyle(
          color: RGB.white,
        ),
      ),
    );
  }
}
