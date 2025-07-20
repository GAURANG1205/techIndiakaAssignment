import 'package:flutter/material.dart';
import '../logic/socket_manager.dart';

class GroupchatScreen extends StatefulWidget {
  final String username;
  const GroupchatScreen({super.key, required this.username});

  @override
  State<GroupchatScreen> createState() => _GroupchatScreenState();
}

class _GroupchatScreenState extends State<GroupchatScreen> {
  final SocketManager socketManager = SocketManager();
  final TextEditingController messageController = TextEditingController();
  final List<String> messages = [];
  final Set<String> typingUsers = {};
  @override
  void initState() {
    super.initState();
    socketManager.connect(
      user: widget.username,
      onNewMessage: (data) {
        setState(() {
          messages.add("${data['username']}: ${data['message']}");
        });
      },
      onUserJoined: (data) {
        setState(() {
          messages.add("${data['username']} joined the chat");
        });
      },
      onUserLeft: (data) {
        setState(() {
          messages.add("${data['username']} left the chat");
        });
      },
      onTyping: (data) {
        setState(() {
          typingUsers.add(data['username']);
        });
      },
      onStopTyping: (data) {
        setState(() {
          typingUsers.remove(data['username']);
        });
      },
    );
  }


  @override
  void dispose() {
    socketManager.dispose();
    messageController.dispose();
    super.dispose();
  }

  void sendMessage() {
    final msg = messageController.text.trim();
    if (msg.isNotEmpty) {
      socketManager.sendMessage(msg);
      setState(() {
        messages.add("You: $msg");
        messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isWide = size.width > 600;

    return Scaffold(
      appBar: AppBar(title: Text("Chat as ${widget.username}")),
      body: Center(
        child: Container(
          width: isWide ? 600 : double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            children: [
              if (typingUsers.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${typingUsers.join(', ')} is typing...",
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              Expanded(
                child: messages.isEmpty
                    ? const Center(child: Text("No messages yet..."))
                    : ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (_, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Align(
                      alignment: messages[index].startsWith("You:")
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Card(
                        color: messages[index].startsWith("You:")
                            ? Colors.blue.shade100
                            : Colors.grey.shade300,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(messages[index]),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: messageController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Type a message...",
                          ),
                          onSubmitted: (_) => sendMessage(),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: sendMessage,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}