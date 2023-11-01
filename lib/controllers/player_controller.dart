import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class PlayerController extends GetxController {
  final audioQuery = OnAudioQuery();
  final audioPlayer = AudioPlayer();

  var playIndex = 0.obs;
  var isPlaying = false.obs;
  @override
  void onInit() {
    super.onInit();
    checkPermission();
  }

  playSong(String? uri, index) {
    playIndex.value = index;
    try {
      audioPlayer.setAudioSource(
        AudioSource.uri(
          Uri.parse(uri!),
        ),
      );
      audioPlayer.play();
      isPlaying(true);
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  checkPermission() async {
    var permStatus = await Permission.storage.status;

    if (permStatus.isDenied || permStatus.isPermanentlyDenied) {
      // Permission is denied or permanently denied, request it.
      var requestedStatus = await Permission.storage.request();

      if (requestedStatus.isGranted) {
        // Permission is granted, proceed with your logic.
      } else {
        // Permission is still not granted, handle it accordingly.
        // You can display an error message or take appropriate actions.
        // Get.snackbar("Permission Denied", "Please grant storage permission");
      }
    } else if (permStatus.isGranted) {
      // Permission is already granted, proceed with your logic.
    }
  }
}
