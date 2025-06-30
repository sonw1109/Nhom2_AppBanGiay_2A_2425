import 'package:flutter/material.dart';
import 'package:project/screen/home.dart';

class NotificationModel {
  final String id;
  final String title;
  final String message;
  final String type;
  final DateTime timestamp;
  final bool isRead;
  final String? imageUrl;
  final String? actionData;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.timestamp,
    this.isRead = false,
    this.imageUrl,
    this.actionData,
  });
}

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<NotificationModel> notifications = [
    NotificationModel(
      id: '1',
      title: 'Đơn hàng đã được giao thành công! 🎉',
      message: 'Đơn hàng #12345 - Nike Air Force 1 đã được giao đến địa chỉ của bạn.',
      type: 'delivery',
      timestamp: DateTime.now().subtract(Duration(minutes: 30)),
      isRead: false,
      imageUrl: '👟',
    ),
    NotificationModel(
      id: '2',
      title: 'Flash Sale 50% OFF! ⚡',
      message: 'Giảm giá cực sốc cho tất cả giày Adidas. Chỉ còn 2 giờ!',
      type: 'promotion',
      timestamp: DateTime.now().subtract(Duration(hours: 2)),
      isRead: false,
      imageUrl: '🔥',
    ),
    NotificationModel(
      id: '3',
      title: 'Đơn hàng đang được chuẩn bị',
      message: 'Đơn hàng #12344 - Converse Chuck Taylor đang được đóng gói.',
      type: 'order',
      timestamp: DateTime.now().subtract(Duration(hours: 4)),
      isRead: true,
      imageUrl: '📦',
    ),
    NotificationModel(
      id: '4',
      title: 'Sản phẩm yêu thích giảm giá!',
      message: 'Nike Air Max 90 trong wishlist của bạn đang có giá ưu đãi.',
      type: 'promotion',
      timestamp: DateTime.now().subtract(Duration(days: 1)),
      isRead: true,
      imageUrl: '❤️',
    ),
    NotificationModel(
      id: '5',
      title: 'Chào mừng bạn đến với ShoeMart! 👋',
      message: 'Cảm ơn bạn đã tải ứng dụng. Nhận ngay mã giảm giá 15% cho đơn đầu tiên.',
      type: 'general',
      timestamp: DateTime.now().subtract(Duration(days: 2)),
      isRead: true,
      imageUrl: '🎁',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'Thông báo',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black87),
          onPressed:
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              ),
        ),
        actions: [
          TextButton(
            onPressed: _markAllAsRead,
            child: Text(
              'Đọc tất cả',
              style: TextStyle(color: Colors.blue[600], fontWeight: FontWeight.w600),
            ),
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.black87),
            onPressed: _showMoreOptions,
          ),
        ],
      ),
      body:
          notifications.isEmpty
              ? _buildEmptyState()
              : RefreshIndicator(
                onRefresh: _refreshNotifications,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    return _buildNotificationItem(notifications[index]);
                  },
                ),
              ),
    );
  }

  Widget _buildNotificationItem(NotificationModel notification) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => _onNotificationTap(notification),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon/Avatar
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: _getNotificationColor(notification.type).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Center(
                    child: Text(
                      notification.imageUrl ?? _getNotificationIcon(notification.type),
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(width: 12),

                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title and timestamp
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              notification.title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: notification.isRead ? FontWeight.w500 : FontWeight.w700,
                                color: notification.isRead ? Colors.grey[700] : Colors.black87,
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            _formatTimestamp(notification.timestamp),
                            style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),

                      // Message
                      Text(
                        notification.message,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600], height: 1.4),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      // Notification type badge
                      if (notification.type == 'promotion') ...[
                        SizedBox(height: 8),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.orange[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Khuyến mãi',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.orange[700],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                // Unread indicator
                if (!notification.isRead)
                  Container(
                    width: 8,
                    height: 8,
                    margin: EdgeInsets.only(left: 8, top: 8),
                    decoration: BoxDecoration(
                      color: Colors.blue[600],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(60),
            ),
            child: Icon(Icons.notifications_none, size: 60, color: Colors.grey[400]),
          ),
          SizedBox(height: 24),
          Text(
            'Chưa có thông báo nào',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.grey[600]),
          ),
          SizedBox(height: 8),
          Text(
            'Tất cả thông báo sẽ hiển thị ở đây',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  Color _getNotificationColor(String type) {
    switch (type) {
      case 'order':
        return Colors.blue;
      case 'promotion':
        return Colors.orange;
      case 'delivery':
        return Colors.green;
      case 'general':
      default:
        return Colors.purple;
    }
  }

  String _getNotificationIcon(String type) {
    switch (type) {
      case 'order':
        return '📋';
      case 'promotion':
        return '🎯';
      case 'delivery':
        return '🚚';
      case 'general':
      default:
        return '📱';
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Vừa xong';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}p';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} ngày';
    } else {
      return '${timestamp.day}/${timestamp.month}';
    }
  }

  void _onNotificationTap(NotificationModel notification) {
    setState(() {
      notification = NotificationModel(
        id: notification.id,
        title: notification.title,
        message: notification.message,
        type: notification.type,
        timestamp: notification.timestamp,
        isRead: true,
        imageUrl: notification.imageUrl,
        actionData: notification.actionData,
      );

      // Update in list
      int index = notifications.indexWhere((n) => n.id == notification.id);
      if (index != -1) {
        notifications[index] = notification;
      }
    });

    // Handle different notification types
    switch (notification.type) {
      case 'order':
      case 'delivery':
        _showOrderDetails(notification);
        break;
      case 'promotion':
        _showPromotionDetails(notification);
        break;
      default:
        _showNotificationDetails(notification);
        break;
    }
  }

  void _showOrderDetails(NotificationModel notification) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => Container(
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 12),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Chi tiết đơn hàng',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16),
                      Text(
                        notification.title,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 8),
                      Text(
                        notification.message,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600], height: 1.5),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          // Navigate to order details
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black87,
                          minimumSize: Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Text(
                          'Xem chi tiết đơn hàng',
                          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
    );
  }

  void _showPromotionDetails(NotificationModel notification) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: Text('🎉 Ưu đãi đặc biệt'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(notification.title, style: TextStyle(fontWeight: FontWeight.w600)),
                SizedBox(height: 8),
                Text(notification.message),
              ],
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: Text('Để sau')),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Navigate to promotion/products
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text('Mua ngay', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
    );
  }

  void _showNotificationDetails(NotificationModel notification) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: Text(notification.title),
            content: Text(notification.message),
            actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('Đóng'))],
          ),
    );
  }

  void _markAllAsRead() {
    setState(() {
      notifications =
          notifications
              .map(
                (notification) => NotificationModel(
                  id: notification.id,
                  title: notification.title,
                  message: notification.message,
                  type: notification.type,
                  timestamp: notification.timestamp,
                  isRead: true,
                  imageUrl: notification.imageUrl,
                  actionData: notification.actionData,
                ),
              )
              .toList();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Đã đánh dấu tất cả thông báo là đã đọc'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showMoreOptions() {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Cài đặt thông báo'),
                  onTap: () {
                    Navigator.pop(context);
                    // Navigate to notification settings
                  },
                ),
                ListTile(
                  leading: Icon(Icons.delete_outline),
                  title: Text('Xóa tất cả thông báo'),
                  onTap: () {
                    Navigator.pop(context);
                    _confirmDeleteAll();
                  },
                ),
              ],
            ),
          ),
    );
  }

  void _confirmDeleteAll() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Xóa tất cả thông báo?'),
            content: Text('Bạn có chắc chắn muốn xóa tất cả thông báo không?'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: Text('Hủy')),
              TextButton(
                onPressed: () {
                  setState(() {
                    notifications.clear();
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Đã xóa tất cả thông báo'), backgroundColor: Colors.red),
                  );
                },
                child: Text('Xóa', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
    );
  }

  Future<void> _refreshNotifications() async {
    // Simulate network call
    await Future.delayed(Duration(seconds: 1));

    // Add a new notification for demo
    setState(() {
      notifications.insert(
        0,
        NotificationModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: 'Thông báo mới! 🔔',
          message: 'Bạn có một thông báo mới từ hệ thống.',
          type: 'general',
          timestamp: DateTime.now(),
          isRead: false,
          imageUrl: '📱',
        ),
      );
    });
  }
}
