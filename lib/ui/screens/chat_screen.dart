import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:mobile_application6/ui/widget/screen_background.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ImagePicker _picker = ImagePicker();

  final List<Map<String, dynamic>> _messages = [
    {"text": "Hey! How are you?", "isMe": false, "time": DateTime.now().subtract(const Duration(minutes: 60)), "image": null},
    {"text": "I'm good! How about you?", "isMe": true, "time": DateTime.now().subtract(const Duration(minutes: 58)), "image": null},
    {"text": "Did you finish the project?", "isMe": false, "time": DateTime.now().subtract(const Duration(minutes: 55)), "image": null},
    {"text": "Yes, submitted it yesterday.", "isMe": true, "time": DateTime.now().subtract(const Duration(minutes: 53)), "image": null},
    {"text": "Great! Any plans for this weekend?", "isMe": false, "time": DateTime.now().subtract(const Duration(minutes: 50)), "image": null},
    {"text": "Not much. Just relaxing. You?", "isMe": true, "time": DateTime.now().subtract(const Duration(minutes: 48)), "image": null},
    {"text": "Thinking of hiking with friends 🏞", "isMe": false, "time": DateTime.now().subtract(const Duration(minutes: 45)), "image": null},
    {"text": "That sounds fun! Take some pictures 😄", "isMe": true, "time": DateTime.now().subtract(const Duration(minutes: 43)), "image": null},
    {"text": "Sure! Also, we might camp overnight.", "isMe": false, "time": DateTime.now().subtract(const Duration(minutes: 40)), "image": null},
    {"text": "Wow, that’s exciting! Don’t forget marshmallows 😆", "isMe": true, "time": DateTime.now().subtract(const Duration(minutes: 38)), "image": null},
    {"text": "Haha, definitely! 🍫🔥", "isMe": false, "time": DateTime.now().subtract(const Duration(minutes: 35)), "image": null},
    {"text": "Btw, did you check the meeting notes from yesterday?", "isMe": true, "time": DateTime.now().subtract(const Duration(minutes: 30)), "image": null},
    {"text": "Yes, all clear. I’ll forward the summary to the team.", "isMe": false, "time": DateTime.now().subtract(const Duration(minutes: 28)), "image": null},
    {"text": "Perfect, thanks!", "isMe": true, "time": DateTime.now().subtract(const Duration(minutes: 25)), "image": null},
    {"text": "No problem 😎", "isMe": false, "time": DateTime.now().subtract(const Duration(minutes: 23)), "image": null},
    {"text": "Catch you later?", "isMe": true, "time": DateTime.now().subtract(const Duration(minutes: 20)), "image": null},
    {"text": "Sure! See you tonight.", "isMe": false, "time": DateTime.now().subtract(const Duration(minutes: 18)), "image": null},
  ];

  void _sendMessage({String? text, File? imageFile}) {
    if ((text != null && text.trim().isNotEmpty) || imageFile != null) {
      setState(() {
        _messages.add({
          "text": text,
          "image": imageFile,
          "isMe": true,
          "time": DateTime.now(),
        });
      });
      _controller.clear();
      Future.delayed(const Duration(milliseconds: 100), () {
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        }
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _sendMessage(imageFile: File(pickedFile.path));
    }
  }

  Widget _buildMessage(Map<String, dynamic> message) {
    final bool isMe = message["isMe"];
    final DateTime time = message["time"];
    final String formattedTime = DateFormat('hh:mm a').format(time);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe)
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.grey[400],
              child: const Icon(Icons.person, size: 16, color: Colors.white),
            ),
          if (!isMe) const SizedBox(width: 6),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12),
              constraints: const BoxConstraints(maxWidth: 250),
              decoration: BoxDecoration(
                gradient: isMe
                    ? LinearGradient(colors: [Colors.green[400]!, Colors.green[300]!])
                    : LinearGradient(colors: [Colors.grey[200]!, Colors.grey[300]!]),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [const BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
              ),
              child: Column(
                crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  if (message["image"] != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.file(
                        message["image"],
                        width: 200,
                        height: 160,
                        fit: BoxFit.cover,
                      ),
                    ),
                  if (message["text"] != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        message["text"],
                        style: TextStyle(fontSize: 16, color: isMe ? Colors.white : Colors.black87),
                      ),
                    ),
                  const SizedBox(height: 4),
                  Text(formattedTime, style: TextStyle(fontSize: 11, color: isMe ? Colors.white70 : Colors.black54)),
                ],
              ),
            ),
          ),
          if (isMe) const SizedBox(width: 6),
          if (isMe)
            const CircleAvatar(
              radius: 16,
              backgroundColor: Colors.green,
              child: Icon(Icons.person, size: 16, color: Colors.white),
            ),
        ],
      ),
    );
  }

  Widget _buildInputRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: [
          GestureDetector(
            onTap: _pickImage,
            child: Container(
              decoration: BoxDecoration(color: Colors.grey[200], shape: BoxShape.circle),
              padding: const EdgeInsets.all(12),
              child: const Icon(Icons.image, color: Colors.black54),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextFormField(
              controller: _controller,
              cursorColor: Colors.black,
              style: const TextStyle(color: Colors.black),
              onChanged: (_) => setState(() {}), // ensures send button updates
              decoration: InputDecoration(
                hintText: "Type your message...",
                hintStyle: const TextStyle(color: Colors.black),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                prefixIcon: const Icon(Icons.emoji_emotions_outlined, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: _controller.text.trim().isEmpty ? null : () => _sendMessage(text: _controller.text),
            child: Container(
              decoration: BoxDecoration(
                color: _controller.text.trim().isEmpty ? Colors.grey[400] : Colors.green[400],
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(12),
              child: const Icon(Icons.send, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SafeArea(
          child: Column(
            children: [
              // Custom heading with back button
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, size: 28),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          "Chat",
                          style: TextStyle(
                            fontSize: 29,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 48), // placeholder for symmetry
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.only(bottom: 75),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) => _buildMessage(_messages[index]),
                ),
              ),
              _buildInputRow(),
            ],
          ),
        ),
      ),
    );
  }
}