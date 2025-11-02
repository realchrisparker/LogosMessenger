import 'package:flutter/material.dart';

class ConversationsPage extends StatefulWidget {
  const ConversationsPage({super.key});

  @override
  State<ConversationsPage> createState() => _ConversationsPageState();
}

class _ConversationsPageState extends State<ConversationsPage> {
  final Color primaryColor = const Color(0xFF02066f);
  final Color goldColor = const Color(0xFFFFD700);

  // Example dynamic state (you can later load these from API or database)
  final List<Map<String, dynamic>> chats = [
    {
      "name": "Angel Curtis",
      "message": "Please help me find a good monitor for t...",
      "time": "02:11",
      "unread": 2,
      "avatar": "assets/images/user5.jpg",
    },
    {
      "name": "Zaire Dorwart",
      "message": "Gacor pisan kang",
      "time": "02:11",
      "unread": 0,
      "avatar": "assets/images/user6.jpg",
    },
    {
      "name": "Kelas Malam",
      "message": "Bima: No one can come today?",
      "time": "02:11",
      "unread": 2,
      "avatar": "assets/images/user7.jpg",
    },
    {
      "name": "Jocelyn Gouse",
      "message": "You’re now an admin",
      "time": "02:11",
      "unread": 0,
      "avatar": "assets/images/user8.jpg",
    },
    {
      "name": "Jaylon Dias",
      "message": "💬 Buy back 10k gallons, top up credit...",
      "time": "02:11",
      "unread": 0,
      "avatar": "assets/images/user9.jpg",
    },
    {
      "name": "Chance Rhiel Madsen",
      "message": "Thank you mate!",
      "time": "02:11",
      "unread": 2,
      "avatar": "assets/images/user10.jpg",
    },
    {
      "name": "Livia Dias",
      "message": "See you soon!",
      "time": "02:11",
      "unread": 0,
      "avatar": "assets/images/user11.jpg",
    },
    {
      "name": "Livia Dias",
      "message": "See you soon!",
      "time": "02:11",
      "unread": 0,
      "avatar": "assets/images/user11.jpg",
    },
    {
      "name": "Livia Dias",
      "message": "See you soon!",
      "time": "02:11",
      "unread": 0,
      "avatar": "assets/images/user11.jpg",
    },
    {
      "name": "Livia Dias",
      "message": "See you soon!",
      "time": "02:11",
      "unread": 0,
      "avatar": "assets/images/user11.jpg",
    },
    {
      "name": "Livia Dias",
      "message": "See you soon!",
      "time": "02:11",
      "unread": 0,
      "avatar": "assets/images/user11.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'Logos Messenger',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stories Row
          SizedBox(
            height: 95,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                // _buildStoryItem(label: 'Add story', icon: Icons.add, isAdd: true),
                _buildStoryAvatar('Terry', 'assets/images/user1.jpg'),
                _buildStoryAvatar('Craig', 'assets/images/user2.jpg'),
                _buildStoryAvatar('Roger', 'assets/images/user3.jpg'),
                _buildStoryAvatar('Nolan', 'assets/images/user4.jpg'),
              ],
            ),
          ),

          // Chats Section
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Chats',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),

          // Chat List
          Expanded(
            child: ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final chat = chats[index];
                return _buildChatItem(
                  name: chat["name"],
                  message: chat["message"],
                  time: chat["time"],
                  unreadCount: chat["unread"],
                  avatar: chat["avatar"],
                  goldColor: goldColor,
                  onTap: () {
                    setState(() {
                      // Example: mark chat as read when tapped
                      chats[index]["unread"] = 0;
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomAppBar(
        elevation: 8,
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 6,
        child: SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.home_filled, color: Colors.black),
                onPressed: () {},
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                icon: const Icon(Icons.chat_bubble_outline, color: Colors.white),
                label: const Text(
                  'New Conversation',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.person, color: Colors.grey),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
    );
  }

  // --- Reusable Widgets ---

  // Widget _buildStoryItem({String? label, IconData? icon, bool isAdd = false}) {
  //   return Padding(
  //     padding: const EdgeInsets.only(right: 14),
  //     child: Column(
  //       children: [
  //         CircleAvatar(
  //           radius: 30,
  //           backgroundColor: isAdd ? Colors.grey[300] : Colors.transparent,
  //           child: isAdd ? Icon(icon, color: Colors.black, size: 28) : null,
  //         ),
  //         const SizedBox(height: 6),
  //         Text(label ?? '', style: const TextStyle(fontSize: 12)),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildStoryAvatar(String name, String imagePath) {
    return Padding(
      padding: const EdgeInsets.only(right: 14),
      child: Column(
        children: [
          CircleAvatar(radius: 30, backgroundImage: AssetImage(imagePath)),
          const SizedBox(height: 6),
          Text(name, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildChatItem({
    required String name,
    required String message,
    required String time,
    String? avatar,
    int unreadCount = 0,
    Color? goldColor,
    VoidCallback? onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        radius: 26,
        backgroundImage: avatar != null ? AssetImage(avatar) : null,
        backgroundColor: Colors.grey[200],
      ),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
      subtitle: Text(
        message,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: Colors.black54),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(time, style: const TextStyle(fontSize: 12, color: Colors.black54)),
          const SizedBox(height: 6),
          if (unreadCount > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: goldColor ?? Colors.amber,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                unreadCount.toString(),
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }
}
