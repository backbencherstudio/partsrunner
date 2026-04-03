import 'package:flutter/material.dart';
import 'package:partsrunner/core/constant/app_color.dart';

class NoticationScreen extends StatefulWidget {
  const NoticationScreen({super.key});

  @override
  State<NoticationScreen> createState() => _NoticationScreenState();
}

class _NoticationScreenState extends State<NoticationScreen> {
  final List<Map<String, dynamic>> _todayNotifications = [
    {
      "id": "1",
      "icon": "📦",
      "title": "New Delivery Request",
      "subtitle": "You've been added to a new task.\nCheck to see the details.",
      "time": "04 m ago",
      "isUnread": true,
    },
    {
      "id": "2",
      "icon": "🏪",
      "title": "Driver Arrives At Supply Store",
      "subtitle": "Driver is at Halls Chophouse",
      "time": "04 m ago",
      "isUnread": false,
    }
  ];

  final List<Map<String, dynamic>> _yesterdayNotifications = [
    {
      "id": "3",
      "icon": "📦",
      "title": "Hang tight, your delivery is on the way!",
      "subtitle": "Driver has picked up your delivery.",
      "time": "34m ago",
      "isUnread": false,
    },
    {
      "id": "4",
      "icon": "💸",
      "title": "Order Paid",
      "subtitle": "Your order at Halls Chophouse is 49,700₫ has been paid successfully.",
      "time": "34m ago",
      "isUnread": false,
    },
    {
      "id": "5",
      "icon": "🧍",
      "title": "Found a Driver!",
      "subtitle": "Driver is heading to merchant - Halls Chophouse",
      "time": "34m ago",
      "isUnread": false,
    }
  ];

  void _markAllAsRead() {
    setState(() {
      for (var item in _todayNotifications) {
        item['isUnread'] = false;
      }
      for (var item in _yesterdayNotifications) {
        item['isUnread'] = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isEmpty =
        _todayNotifications.isEmpty && _yesterdayNotifications.isEmpty;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,
              color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Notification',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: isEmpty ? _buildEmptyState() : _buildNotificationList(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.primary.withOpacity(0.05),
            ),
            child: Center(
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.primary.withOpacity(0.1),
                ),
                child: const Icon(
                  Icons.notifications_outlined,
                  color: AppColor.primary,
                  size: 36,
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            'No Notifications Yet',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            "You'll be notified here once there's\nsomething new.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: Colors.black54,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }

  Widget _buildNotificationList() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_todayNotifications.isNotEmpty) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Today',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                GestureDetector(
                  onTap: _markAllAsRead,
                  child: const Text(
                    'Mark all as read',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColor.primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ..._todayNotifications
                .map((e) => _buildNotificationCard(e, true))
                ,
          ],
          if (_yesterdayNotifications.isNotEmpty) ...[
            const SizedBox(height: 16),
            const Text(
              'Yesterday',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            ..._yesterdayNotifications
                .map((e) => _buildNotificationCard(e, false))
                ,
          ],
        ],
      ),
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> data, bool isToday) {
    return Dismissible(
      key: Key(data['id']),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        setState(() {
          if (isToday) {
            _todayNotifications
                .removeWhere((element) => element['id'] == data['id']);
          } else {
            _yesterdayNotifications
                .removeWhere((element) => element['id'] == data['id']);
          }
        });
      },
      background: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFEF4444), // red-500 equivalent
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        child: const Icon(Icons.delete_outline, color: Colors.white, size: 28),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: data['isUnread'] == true
              ? AppColor.primary.withOpacity(0.04)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColor.primary.withOpacity(0.1)),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data['icon'],
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['title'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          data['subtitle'],
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            height: 1.4,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        data['time'],
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}