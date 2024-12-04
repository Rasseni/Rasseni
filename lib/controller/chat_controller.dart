// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class ChatController extends ChangeNotifier {
//   List<Map<String, dynamic>> _messages = [];
//   bool _isLoading = false;

//   List<Map<String, dynamic>> get messages => _messages;
//   bool get isLoading => _isLoading;

//   Future<void> fetchMessages() async {
//     if (_messages.isNotEmpty) return; // Avoid refetching if data exists
//     _isLoading = true;
//     notifyListeners();

//     try {
//       final snapshot = await FirebaseFirestore.instance
//           .collection('messages')
//           .orderBy('timestamp', descending: false)
//           .get();

//       _messages = snapshot.docs
//           .map((doc) => doc.data() as Map<String, dynamic>)
//           .toList();
//     } catch (e) {
//       print('Error fetching messages: $e');
//     }

//     _isLoading = false;
//     notifyListeners();
//   }

//   Future<void> sendMessage(String text) async {
//     try {
//       final message = {
//         'text': text,
//         'isSentByUser': false,
//         'timestamp': Timestamp.now(),
//       };

//       await FirebaseFirestore.instance.collection('messages').add(message);

//       _messages.add(message);
//       notifyListeners();
//     } catch (e) {
//       print('Error sending message: $e');
//     }
//   }
// }
