import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart';

class Advice
{
  String _advice = '';
  String _slipID = '';
  
  Advice();
  
  get advice => _advice;
  get slipID => _slipID;
  
  static Future<Advice> getAdvice(String key) async
  {
    bool multiple = false;
    Response response;
    if (key.isEmpty)
    {
        response = await get("https://api.adviceslip.com/advice");
    }
    else
    {
      multiple = true;
      response = await get("https://api.adviceslip.com/advice/search/"+key);
    }

    Map<dynamic,dynamic> result = jsonDecode(response.body);
    Advice advice = new Advice();

    if (multiple)
    {
      int total = int.parse(result['total_results']);
      List<dynamic> slips = result['slips'];
      Random random = new Random();
      int ran = random.nextInt(total); // generate a random number from 0 to total - 1
      Map<dynamic,dynamic> slip = slips[ran];

      advice._advice = slip['advice'];
      advice._slipID = slip['slip_id'];

    } else {
      Map<dynamic,dynamic> slip = result['slip'];
      advice._advice = slip['advice'];
      advice._slipID = slip['slip_id'];
    }

    print(result);
    print(advice._advice);

    return advice;
  }
  
  
}