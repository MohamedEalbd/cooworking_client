import 'package:get/get.dart';
import 'package:khidmh/feature/review/controller/submit_review_controller.dart';
import 'package:khidmh/feature/review/repo/submit_review_repo.dart';

class SubmitReviewBinding extends Bindings{
  @override
  void dependencies() async {
    Get.lazyPut(() => SubmitReviewController(submitReviewRepo: SubmitReviewRepo(apiClient: Get.find(), sharedPreferences: Get.find())));
  }

}