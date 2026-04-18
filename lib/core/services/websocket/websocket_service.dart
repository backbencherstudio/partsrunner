import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class WebsocketService {
  IO.Socket? socket;
  StreamSubscription<Position>? _positionSub;

  void connect({required String baseUrl, required String jwtToken}) {
    socket?.dispose();
    socket = null;

    socket = IO.io(
      baseUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .setAuth({'token': jwtToken})
          .disableAutoConnect()
          .enableReconnection()
          .build(),
    );

    socket!.onConnect((_) {
      print('socket connected');
    });

    socket!.onConnectError((err) {
      print('connect error: $err');
    });

    socket!.onError((err) {
      print('socket error: $err');
    });

    socket!.on('runner.error', (data) {
      print('runner.error: $data');
    });

    socket!.connect();
  }

  void startLocationUpdates() {
    _positionSub?.cancel();
    _positionSub =
        Geolocator.getPositionStream(
          locationSettings: const LocationSettings(distanceFilter: 10),
        ).listen(
          (pos) => sendLocation(pos.latitude, pos.longitude),
          onError: (e) {
            print('Location stream error: $e');
          },
        );
  }

  void stopLocationUpdates() {
    _positionSub?.cancel();
    _positionSub = null;
  }

  void sendLocation(double lat, double lng) {
    print('Sending location update to server: lat: $lat, lng: $lng');
    socket?.emit('runner.location.update', {'lat': lat, 'lng': lng});
  }

  void updateTokenAndReconnect(String newToken) {
    if (socket == null) return;

    socket!.disconnect();
    socket!.io.options!['auth'] = {'token': newToken};
    socket!.connect();
  }

  void dispose() {
    stopLocationUpdates();
    socket?.dispose();
    socket = null;
  }
}
