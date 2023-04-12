import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lms/app/core/values/colors.dart';
import 'package:lms/app/modules/discusions/views/discusions_view.dart';
import 'package:lms/app/modules/home/views/home_view.dart';
import 'package:lms/app/modules/profile/views/profile_view.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      int selectedIndex = controller.selectedIndex.value;
      return Scaffold(
        backgroundColor: AppColors.background,
        body: IndexedStack(
          index: selectedIndex,
          children: [
            HomeView(),
            DiscusionsView(),
            ProfileView(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            controller.selectedIndex.value = index;
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.account_balance_outlined,
                ),
                label: 'Diskusi Soal'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                label: 'Profile')
          ],
        ),
      );
    });
  }
}
