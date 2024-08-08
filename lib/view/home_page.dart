import 'package:finsire/widgets/progress_card.dart';
import 'package:flutter/material.dart';

import '../controller/controller.dart';
import '../model/reader_stats.dart';
import '../utils/images.dart';

class ReaderStatsScreen extends StatefulWidget {
  const ReaderStatsScreen({super.key});

  @override
  _ReaderStatsScreenState createState() => _ReaderStatsScreenState();
}

class _ReaderStatsScreenState extends State<ReaderStatsScreen> {
  final ReaderStatsController _controller = ReaderStatsController();
  int? _progress;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    int progress = await _controller.fetchProgress();
    setState(() {
      _progress = progress;
    });
  }

  @override
  Widget build(BuildContext context) {
    ReaderStats stats = _controller.getStaticData();

    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(Images.profile),
              radius: 14,
            ),
            SizedBox(width: 5),
            Text("Amy's Reader Stats"),
          ],
        ),
        backgroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        Images.book,
                        height: 40,
                        width: 30,
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        'War and Peace',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey,
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ProgressCard(
                progress: _progress != null ? _progress! / 1000 : null,
                color: Colors.orange,
                title: 'PROGRESS',
                content: _progress != null ? '$_progress' : "0",
                bgColor: Colors.orangeAccent.shade200,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                      child: _buildCard(
                          iconImage: Images.clock,
                          color: Colors.red,
                          bgColor: Colors.red.shade200,
                          title: 'TIME',
                          content: stats.time,
                          subTitle:
                              'Global avg, read time for your progress 7:28',
                          footer: '23% faster')),
                  const SizedBox(width: 10),
                  Expanded(
                      child: _buildCard(
                          iconImage: Images.flash,
                          color: Colors.green,
                          bgColor: Colors.green.shade200,
                          title: 'STREAK',
                          subTitle:
                              'Day streak ,come back tomorrow to keep it up!',
                          content: '${stats.streak}',
                          footer: '19% more more consistent')),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                      child: _buildCard(
                          iconImage: Images.premium,
                          color: Colors.purple,
                          bgColor: Colors.purple.shade200,
                          title: 'LEVEL',
                          content: '${stats.level}',
                          subTitle: '140 reader points to level up!',
                          footer: 'Top 5% for this book')),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: 155,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Badges",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.blue.shade200,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      Images.share,
                                      color: Colors.white,
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                            ],
                          ),
                          const SizedBox(height: 20),
                          ..._iconBadges([
                            Images.light,
                            Images.high,
                            Images.loop,
                          ]),
                          const SizedBox(height: 20),
                          ..._iconBadges([
                            Images.time,
                            Images.bookIcon,
                            Images.like,
                          ]),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildLeaderboardButton(),
              const SizedBox(height: 10),
              const Text('Leaderboard',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _iconBadges(List<String> imagePaths) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: imagePaths.map((path) {
          return Image.asset(
            path,
            color: Colors.black,
            fit: BoxFit.cover,
            height: 25,
            width: 25,
          );
        }).toList(),
      )
    ];
  }

  Widget _buildCard(
      {Color? color,
      required String title,
      String? subTitle,
      Color? bgColor,
      String? content,
      String? iconImage,
      String? footer}) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 155,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(08),
                    color: bgColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      Images.share,
                      color: Colors.white,
                      fit: BoxFit.cover,
                    ),
                  )),
            ],
          ),
          const SizedBox(height: 05),
          Row(
            children: [
              Image.asset(
                iconImage!,
                fit: BoxFit.cover,
                height: 35,
                width: 35,
              ),
              const SizedBox(width: 10),
              Text(
                content!,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                subTitle!,
                style: const TextStyle(fontSize: 12),
                maxLines: 2,
              ),
              Text(
                footer!,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                maxLines: 1,
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLeaderboardButton() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(primary: Colors.grey),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                Text('Add friends', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                Images.share,
                color: Colors.white,
                fit: BoxFit.cover,
              ),
            )),
      ],
    );
  }
}
