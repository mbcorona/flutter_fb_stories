import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

const black1 = Color(0xFF434343);
const black2 = Color(0xFF656565);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Fb Stories',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("facebook"),
        centerTitle: false,
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.message)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            WhatsOnYourMind(),
            Shortcuts(),
            SizedBox(
              height: 8,
            ),
            StoriesBox(),
            SizedBox(
              height: 8,
            ),
            UserPost(),
            UserPost(),
          ],
        ),
      ),
    );
  }
}

class Shortcuts extends StatelessWidget {
  const Shortcuts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: black2,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: const [
            ShortcutChip(
              iconData: Icons.movie,
              color: Colors.pinkAccent,
              text: 'Reel',
            ),
            ShortcutChip(
              iconData: Icons.video_call_rounded,
              color: Colors.purple,
              text: 'Room',
            ),
            ShortcutChip(
              iconData: Icons.group,
              color: Colors.blue,
              text: 'Group',
            ),
            ShortcutChip(
              iconData: Icons.live_tv,
              color: Colors.red,
              text: 'Live',
            ),
          ],
        ),
      ),
    );
  }
}

class ShortcutChip extends StatelessWidget {
  const ShortcutChip({
    Key? key,
    required this.iconData,
    required this.color,
    required this.text,
  }) : super(key: key);

  final IconData iconData;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white38,
          ),
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Icon(
            iconData,
            color: color,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(text)
        ],
      ),
    );
  }
}

class UserPost extends StatelessWidget {
  const UserPost({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final n = Random().nextInt(5);
    return Container(
      color: black1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/user_${n + 1}.jpeg'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "User X",
                          style: TextStyle(fontSize: 16),
                        ),
                        TextSpan(
                          text: "\n10 min",
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
            ),
            child: Text("This is the description, lorem ipsum"),
          ),
          Image.asset(
            'assets/story_${n + 1}.jpeg',
            width: double.infinity,
            height: 500,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          )
        ],
      ),
    );
  }
}

class WhatsOnYourMind extends StatelessWidget {
  const WhatsOnYourMind({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: const [
          CircleAvatar(
            backgroundImage: AssetImage('assets/user_0.jpeg'),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                "What's on your mind?",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          Icon(
            Icons.photo_library_outlined,
            color: Colors.green,
          )
        ],
      ),
    );
  }
}

class StoriesBox extends StatefulWidget {
  const StoriesBox({
    Key? key,
  }) : super(key: key);

  @override
  State<StoriesBox> createState() => _StoriesBoxState();
}

class _StoriesBoxState extends State<StoriesBox> {
  final double width = 90.0;
  final controller = ScrollController();
  double scroll = 0.0;

  void onScroll() {
    setState(() {
      scroll = controller.offset > width ? 1 : controller.offset / width;
      if (scroll < 0) scroll = 0;
    });
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(onScroll);
  }

  @override
  void dispose() {
    super.dispose();
    controller.removeListener(onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: black1,
      width: double.infinity,
      height: 160,
      child: Stack(
        children: [
          SingleChildScrollView(
            controller: controller,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                7,
                (index) {
                  if (index == 0) {
                    return const SizedBox(
                      width: 105,
                    );
                  }
                  return Container(
                    width: width,
                    height: double.infinity,
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/story_$index.jpeg',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: 40,
                        height: 40,
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(
                            width: 3,
                            color: Colors.blueAccent,
                          ),
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/user_$index.jpeg',
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            width: width,
            height: double.infinity,
            margin: EdgeInsets.only(
              top: 5,
              left: (1 - scroll) * 10,
              bottom: 5,
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 50 * scroll,
                  bottom: 50 * scroll,
                  right: 40 * scroll,
                  left: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(lerpDouble(10, 0, scroll)!),
                        bottomLeft: Radius.circular(lerpDouble(10, 0, scroll)!),
                        topRight: Radius.circular(lerpDouble(10, 50, scroll)!),
                        bottomRight:
                            Radius.circular(lerpDouble(10, 50, scroll)!),
                      ),
                      color: black2,
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            width: lerpDouble(width, 40, scroll),
                            height: lerpDouble(90, 40, scroll),
                            margin: EdgeInsets.only(
                              top: lerpDouble(0, 5, scroll)!,
                              right: lerpDouble(0, 5, scroll)!,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                    lerpDouble(10, 40, scroll)!),
                                topRight: Radius.circular(
                                    lerpDouble(10, 40, scroll)!),
                                bottomLeft:
                                    Radius.circular(lerpDouble(0, 40, scroll)!),
                                bottomRight:
                                    Radius.circular(lerpDouble(0, 40, scroll)!),
                              ),
                              image: const DecorationImage(
                                image: AssetImage(
                                  'assets/user_0.jpeg',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        if (scroll < 0.2)
                          const Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Create\nStory",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 70,
                  right: lerpDouble(0, 15, scroll),
                  left: 0,
                  child: Transform.scale(
                    scale: lerpDouble(1, 0.5, scroll),
                    child: Center(
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            width: 3,
                            color: black2,
                          ),
                        ),
                        child: const Icon(Icons.add),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
