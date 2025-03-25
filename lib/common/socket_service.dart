import 'dart:convert';
import 'dart:io';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:windows_notification/windows_notification.dart';
import 'package:windows_notification/notification_message.dart';

class SocketIOService {
  late IO.Socket socket;

  final _winNotifyPlugin = WindowsNotification(
    applicationId: "e_hujjat", // oddiy app nomi — to‘g‘ri
  );

  bool _initialized = false;

  void connect(int userId) async {
    socket = IO.io(
      'http://10.100.26.2:5000',
      IO.OptionBuilder()
          .setTransports(['websocket']) // kerakli transport
          .disableAutoConnect()
          .build(),
    );

    socket.connect();

    socket.onConnect((_) {
      print('✅ SocketIO ulandi');

      socket.on('new_control_card', (data) {
        _handleIncoming(data, userId);
      });
    });

    socket.onConnectError((err) {
      print('❌ Ulanishda xatolik: $err');
    });

    socket.onDisconnect((_) {
      print('🔌 Socket uzildi');
    });
  }

  Future<void> _handleIncoming(dynamic raw, int userId) async {
    try {
      final data = raw is String ? jsonDecode(raw) : raw;
      print("📥 Kelgan event: $data");

      final List responsibleIds = List.from(data['responsible_id'] ?? []);
      final List responsiblePersonIds = List.from(data['responsible_person_id'] ?? []);

      final isMatch = responsibleIds.contains(userId) || responsiblePersonIds.contains(userId);

      if (isMatch) {
        final id = data['id'];
        final number = data['number'];
        final naming = data['naming'];
        final launchUrl = "http://e-hujjat.uz";

        // 🔁 Init only once
        if (!_initialized) {
          await _winNotifyPlugin.initNotificationCallBack((arg) {
            if (arg.eventType == 'activated') {
              print("🔔 Notification clicked");
              Process.run('start', [launchUrl], runInShell: true);
            }
          });
          _initialized = true;
        }

        final message = NotificationMessage.fromPluginTemplate(
          "cc_$id",
          "Yangi Nazorat kartasi",
          "$number - $naming",
          launch: launchUrl,
                     
        );

        _winNotifyPlugin.showNotificationPluginTemplate(message);
        print("📤 Bildirishnoma yuborildi");
      } else {
        print("ℹ️ Bu xabar bu foydalanuvchiga tegishli emas.");
      }
    } catch (e) {
      print("❌ Xatolikni o'qishda: $e");
    }
  }

  void disconnect() {
    if (socket.connected) {
      socket.disconnect();
      print("🔌 Socket uzildi (foydalanuvchi chiqdi)");
    }
  }
}
