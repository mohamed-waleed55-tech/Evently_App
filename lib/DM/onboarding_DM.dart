import 'package:evently/core/resources/images/images_manager.dart';

class OnboardingDm {
  String imgPath;
  String title;
  String desc;

  OnboardingDm({
    required this.title,
    required this.desc,
    required this.imgPath,
  });
}

List<OnboardingDm> introScreens = [
  OnboardingDm(
    title: "Personalize Your Experience",
    desc:
        "Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.",
    imgPath: ImagesManager.onboarding1,
  ),
  OnboardingDm(
    title: "Find Events That Inspire You",
    desc:
        "Dive into a world of events crafted to fit your unique interests. Whether you're into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.",
    imgPath: ImagesManager.onboarding2,
  ),
  OnboardingDm(
    title: "Effortless Event Planning",
    desc:
        "Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.",
    imgPath: ImagesManager.onboarding3,
  ),
  OnboardingDm(
    title: "Connect with Friends & Share Moments",
    desc:
        "Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.",
    imgPath: ImagesManager.onboarding4,
  ),
];
