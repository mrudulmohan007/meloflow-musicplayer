import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/constants/colors.dart';
import 'package:music_player/constants/text_style.dart';
import 'package:music_player/controllers/player_controller.dart';
import 'package:music_player/views/player.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PlayerController());
    // final controller = Get.find<PlayerController>();

    if (!controller.isPermissionGranted.value) {
      controller.checkPermission(); // Request permission if not granted
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 27, 27, 27),
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search_off_sharp,
              color: Colors.green,
            ),
          ),
        ],
        leading: const Icon(
          Icons.sort_rounded,
          color: Colors.white,
        ),
        title: Text(
          '  Meloflow ',
          style: ourStyle(
            family: 'Poppins',
            size: 20,
            color: Color.fromARGB(255, 141, 203, 254),
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isPermissionGranted.value) {
          return FutureBuilder<List<SongModel>>(
            future: controller.audioQuery.querySongs(
              ignoreCase: true,
              orderType: OrderType.ASC_OR_SMALLER,
              sortType: null,
              uriType: UriType.EXTERNAL,
            ),
            builder: (BuildContext context, snapshot) {
              if (snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Obx(() {
                          return ListTile(
                            tileColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            leading: QueryArtworkWidget(
                              id: snapshot.data![index].id,
                              type: ArtworkType.AUDIO,
                              nullArtworkWidget: const Icon(
                                (Icons.music_note),
                                color: Color.fromARGB(255, 18, 179, 185),
                              ),
                            ),
                            trailing: controller.playIndex.value == index &&
                                    controller.isPlaying.value
                                ? const Icon(
                                    (Icons.play_circle),
                                    color: Color.fromARGB(255, 9, 120, 167),
                                  )
                                : null,
                            title: Text(
                              snapshot.data![index].displayNameWOExt,
                              style: ourStyle(
                                family: 'bold',
                                size: 19,
                                color: Colors.white,
                              ),
                            ),
                            subtitle: Text(
                              snapshot.data![index].artist!,
                              style: ourStyle(
                                  size: 13.5,
                                  color: Colors.green,
                                  family: 'bold'),
                            ),
                            onTap: () {
                              Get.to(
                                PlayerScreen(
                                  data: snapshot.data!,
                                ),
                                transition: Transition.downToUp,
                              );
                              controller.playSong(
                                  snapshot.data![index].uri, index);
                            },
                          );
                        }),
                      );
                    },
                  ),
                );
              }
            },
          );
        } else {
          // Handle the case when permission is not granted yet
          return NoSongFound();
        }
      }),
    );
  }

  NoSongFound() {
    return const Scaffold(
      body: Center(
        child: Text(
          'No song Found',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
