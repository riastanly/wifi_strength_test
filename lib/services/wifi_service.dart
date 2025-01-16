import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wifi_iot/wifi_iot.dart';
import '../models/wifi_model.dart';

class WifiService {
  static Future<List<WifiModel>> getNearbyWifi() async {
    List<WifiModel> wifiList = [];

    try {
      bool isEnabled = await WiFiForIoTPlugin.isEnabled();
      if (!isEnabled) {
        await WiFiForIoTPlugin.setEnabled(true);
      }

      List<WifiNetwork>? networks = await WiFiForIoTPlugin.loadWifiList();

      if (networks != null) {
        wifiList = networks.map((network) {
          return WifiModel(
            name: network.ssid ?? 'Unknown',
            signalStrength: network.level ?? 0,
          );
        }).toList();
      }
    } catch (e) {
      print('Error fetching Wi-Fi networks: $e');
    }

    return wifiList;
  }
static Future<void> sendWifiDataToApi(List<WifiModel> wifiList) async {
  const apiUrl = 'http://192.168.166.38:5000/';

  try {
    // Convert the list to JSON
    List<Map<String, dynamic>> jsonData = wifiList.map((wifi) {
      return {
        'name': wifi.name,
        'signalStrength': wifi.signalStrength,
      };
    }).toList();

    // Make the POST request with the correct key
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'wifi_devices': jsonData}), // Fixed key
    );

    if (response.statusCode == 200) {
      print('Wi-Fi data sent successfully!');
    } else {
      print('Failed to send Wi-Fi data. Status code: ${response.statusCode}');
      print('Response: ${response.body}');
    }
  } catch (e) {
    print('Error sending Wi-Fi data to API: $e');
  }
}

}
