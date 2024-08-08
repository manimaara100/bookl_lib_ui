import 'package:flutter/material.dart';

import '../utils/images.dart';

class ProgressCard extends StatefulWidget {
  final Color color;
  final String title;
  final Color bgColor;
  final String content;
  final double? progress;

  const ProgressCard({
    super.key,
    required this.color,
    required this.title,
    required this.bgColor,
    required this.content,
    required this.progress,
  });

  @override
  State<ProgressCard> createState() => _ProgressCardState();
}

class _ProgressCardState extends State<ProgressCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: widget.bgColor,
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
                Images.bookIcon,
                fit: BoxFit.cover,
                height: 55,
                width: 40,
              ),
              const SizedBox(width: 10),
              Text(
                widget.content,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 20),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Out of 1000 pages",
                  ),
                  Text(
                    "#5 among friends",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
          const SizedBox(height: 15),
          LinearProgressIndicator(
            minHeight: 08,
            value: widget.progress,
            backgroundColor: Colors.white,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.black),
          ),
          const SizedBox(height: 10),
          ..._iconBadges([
            Images.img,
            Images.profile,
            Images.img1,
            Images.img2,
          ]),
        ],
      ),
    );
  }

  List<Widget> _iconBadges(List<String> imagePaths) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: imagePaths.map((path) {
          return CircleAvatar(radius: 15, backgroundImage: AssetImage(path));
        }).toList(),
      )
    ];
  }
}
