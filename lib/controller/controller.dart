import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/reader_stats.dart';

class ReaderStatsController {
  Future<int> fetchProgress() async {
    final response = await http.get(Uri.parse(
        'https://www.randomnumberapi.com/api/v1.0/random?min=100&max=1000&count=1'));
    if (response.statusCode == 200) {
      return json.decode(response.body)[0];
    } else {
      throw Exception('Failed to load progress');
    }
  }

  ReaderStats getStaticData() {
    return ReaderStats(
      time: '6:24',
      streak: 7,
      level: 2,
    );
  }
}
