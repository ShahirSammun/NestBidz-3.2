import 'package:flutter/material.dart';
import '../widget/screen_background.dart';
import 'chat_screen.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final chats = [
      {
        'name': 'Kamran Lu',
        'message': 'Ajke 10ta paper der',
        'time': '00:39',
        'unread': true,
      },
      {
        'name': 'Nuzat Rahman',
        'message': 'Korsos ni',
        'time': '00:34',
        'unread': false,
      },
      {
        'name': 'Department of CSE, LU',
        'message': '+880 1315-525144; Check inbox',
        'time': '00:14',
        'unread': false,
      },
      {
        'name': 'Sheme',
        'message': 'Voice call',
        'time': '00:05',
        'unread': true,
      },
    ];

    return ScreenBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Chats',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search, size: 26),
              onPressed: () {},
            ),
          ],
        ),
        body: ListView.separated(
          itemCount: chats.length,
          separatorBuilder: (_, __) => const Divider(
            indent: 72,
            height: 0,
            color: Colors.white12,
          ),
          itemBuilder: (context, index) {
            final chat = chats[index];
            final name = chat['name'] as String;
            final message = chat['message'] as String;
            final time = chat['time'] as String;
            final unread = chat['unread'] as bool;

            return ListTile(
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: CircleAvatar(
                radius: 26,
                backgroundColor: Colors.blue,
                child: Text(
                  name[0],
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              title: Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              subtitle: Text(
                message,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: unread ? FontWeight.w500 : FontWeight.normal,
                ),
              ),
              trailing: Text(
                time,
                style: TextStyle(
                  color: unread ? Colors.greenAccent : Colors.grey,
                  fontSize: 13,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ChatScreen(),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}