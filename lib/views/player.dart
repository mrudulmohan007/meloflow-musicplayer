import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/constants/text_style.dart';
import 'package:music_player/controllers/player_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayerScreen extends StatelessWidget {
  final List<SongModel> data;
  const PlayerScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<PlayerController>();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Obx(
              () => Expanded(
                child: Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: QueryArtworkWidget(
                    id: data[controller.playIndex.value].id,
                    type: ArtworkType.AUDIO,
                    artworkHeight: double.infinity,
                    artworkWidth: double.infinity,
                    nullArtworkWidget: const Icon(
                      Icons.music_note,
                      size: 40,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                child: Obx(
                  () => Column(
                    children: [
                      Text(
                        data[controller.playIndex.value].displayNameWOExt,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: ourStyle(
                          color: Colors.black87,
                          family: 'bold',
                          size: 26,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        data[controller.playIndex.value].artist.toString(),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: ourStyle(
                          color: Color.fromARGB(255, 96, 104, 96),
                          size: 18,
                          family: 'bold',
                        ),
                      ),
                      const SizedBox(height: 12),
                      Obx(
                        () => Row(
                          children: [
                            Text(
                              controller.position.value,
                              style: ourStyle(
                                color: Colors.black,
                                family: 'bold',
                              ),
                            ),
                            Expanded(
                              child: Slider(
                                thumbColor: Colors.black,
                                activeColor: Colors.blue,
                                inactiveColor: Colors.grey,
                                min: Duration(seconds: 0).inSeconds.toDouble(),
                                max: controller.max.value,
                                value: controller.currentPosition.value,
                                onChanged: (newValue) {
                                  controller
                                      .changeDurationInSlider(newValue.toInt());
                                  newValue = newValue;
                                },
                              ),
                            ),
                            Text(
                              controller.duration.value,
                              style: ourStyle(
                                color: Colors.black,
                                family: 'bold',
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            onPressed: () {
                              final previousIndex =
                                  controller.playIndex.value - 1;
                              if (previousIndex >= 0) {
                                controller.playSong(
                                    data[previousIndex].uri, previousIndex);
                              } else {
                                // Handle when you are at the first song and the previous button is pressed.

                                controller.playSong(data[0].uri, 0);
                              }
                            },
                            icon: Icon(
                              Icons.skip_previous,
                              size: 40,
                            ),
                          ),
                          Obx(
                            () => CircleAvatar(
                              radius: 35,
                              backgroundColor: Colors.black,
                              child: Transform.scale(
                                scale: 2.5,
                                child: IconButton(
                                  onPressed: () {
                                    if (controller.isPlaying.value) {
                                      controller.audioPlayer.pause();
                                      controller.isPlaying(false);
                                    } else {
                                      controller.audioPlayer.play();
                                      controller.isPlaying(true);
                                    }
                                  },
                                  icon: controller.isPlaying.value
                                      ? Icon(
                                          Icons.pause,
                                        )
                                      : const Icon(
                                          Icons.play_arrow_rounded,
                                        ),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              final nextIndex = controller.playIndex.value + 1;
                              if (nextIndex < data.length) {
                                controller.playSong(
                                    data[nextIndex].uri, nextIndex);
                              } else {
                                // Handle when the last song is playing and the next button is pressed.
                                // we can choose to loop back to the first song or take any other action here.
                                // For example, we can implement a loop feature:
                                controller.playSong(data[0].uri, 0);
                              }
                            },
                            icon: Icon(
                              Icons.skip_next_rounded,
                              size: 40,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
