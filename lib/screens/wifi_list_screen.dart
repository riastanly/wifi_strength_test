import 'package:flutter/material.dart';
import '../services/wifi_service.dart';
import '../models/wifi_model.dart';

class WifiListScreen extends StatefulWidget {
  @override
  _WifiListScreenState createState() => _WifiListScreenState();
}

class _WifiListScreenState extends State<WifiListScreen> {
  List<WifiModel> wifiList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadWifiData();
  }

  void loadWifiData() async {
    try {
      final data = await WifiService.getNearbyWifi();
      setState(() {
        wifiList = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error loading Wi-Fi data: $e');
    }
  }

  void sendWifiData() async {
    try {
      await WifiService.sendWifiDataToApi(wifiList);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Wi-Fi data sent to the server!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send Wi-Fi data: $e')),
      );
      print('Error sending Wi-Fi data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nearby Wi-Fi Networks'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : wifiList.isEmpty
              ? Center(child: Text('No Wi-Fi networks found.'))
              : ListView.builder(
                  itemCount: wifiList.length,
                  itemBuilder: (context, index) {
                    final wifi = wifiList[index];
                    return ListTile(
                      leading: Icon(Icons.wifi, color: Colors.blue),
                      title: Text(wifi.name),
                      subtitle: Text('Signal Strength: ${wifi.signalStrength} dBm'),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: sendWifiData,
        child: Icon(Icons.send),
        tooltip: 'Send Wi-Fi Data',
      ),
    );
  }
}
