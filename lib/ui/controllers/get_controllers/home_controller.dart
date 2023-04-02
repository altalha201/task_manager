import 'package:get/get.dart';

class HomeController extends GetxController {
  int currentIndex = 0;

  void changeIndex(int newIndex) {
    currentIndex = newIndex;
    update();
  }
}