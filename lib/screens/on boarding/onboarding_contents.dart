import 'package:coursecraft_app/core/app_image.dart';

class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents({
    required this.title,
    required this.image,
    required this.desc,
  });
}

List<OnboardingContents> contents = [
  OnboardingContents(
    image: '${AppImages.onboardingImages}onboard.png',
    title: 'Learn Anytime, Anywhere',
    desc:
        'Let\'s start new courses,\nwith our expert and build your best\nskill with us.',
  ),
  OnboardingContents(
    image: '${AppImages.onboardingImages}onboard.png',
    title: 'Learn Anytime, Anywhere',
    desc:
        'Let\'s start new courses,\nwith our expert and build your best\nskill with us.',
  ),
];
