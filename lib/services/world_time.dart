import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  late String time;
  String flag;
  String url;
  late bool isDayTime;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      var timeJson = Uri.parse("http://worldtimeapi.org/api/timezone/$url");
      Response response = await get(timeJson);
      Map data = jsonDecode(response.body);
      // print(data);
      String datetime = data["datetime"];
      String offset = data["utc_offset"].substring(1, 3);

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));
      isDayTime = now.hour >6 && now.hour <19 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print("Caught Error : $e");
      time = "Unable to Load Time Data";
    }
  }
}
