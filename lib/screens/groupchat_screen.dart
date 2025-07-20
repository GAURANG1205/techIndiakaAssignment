import 'package:flutter/material.dart';

class GroupchatScreen extends StatefulWidget {
  final String username;
  const GroupchatScreen({super.key, required this.username});

  @override
  State<GroupchatScreen> createState() => _GroupchatScreenState();
}

class _GroupchatScreenState extends State<GroupchatScreen> {
  final TextEditingController messageController = TextEditingController();
  final List<String> messages = [];

  @override
  void initState() {
    super.initState();
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
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: (){},
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
