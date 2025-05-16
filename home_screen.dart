import 'package:flutter/material.dart';
import '../widgets/migx_drawer.dart';

class MigXHomeScreen extends StatefulWidget {
  const MigXHomeScreen({super.key});

  @override
  State<MigXHomeScreen> createState() => _MigXHomeScreenState();
}

class _MigXHomeScreenState extends State<MigXHomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  List<String> joinedRooms = []; // Dynamic joined rooms

  final List<Map<String, dynamic>> friends = [
    {'username': 'coolDude', 'status': 'Busy rn', 'statusType': 'busy'},
    {'username': 'oldFriend', 'status': 'Catch you later!', 'statusType': 'offline'},
    {'username': 'pr3ttymiss', 'status': 'Feeling great!', 'statusType': 'online'},
    {'username': 'silentSoul', 'status': 'AFK', 'statusType': 'away'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2 + joinedRooms.length, vsync: this);
  }

  void joinChatroom(String roomName) {
    setState(() {
      joinedRooms.add(roomName);
      _tabController = TabController(length: 2 + joinedRooms.length, vsync: this);
    });
  }

  Color getStatusColor(String statusType) {
    switch (statusType) {
      case 'online':
        return Colors.green;
      case 'busy':
        return Colors.red;
      case 'away':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  Widget buildFriendRow(BuildContext context, Map<String, dynamic> user) {
    return GestureDetector(
      onLongPress: () => showDialog(
        context: context,
        builder: (_) => Dialog(
          backgroundColor: Color(0xFFFF9900),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              ListTile(title: Text("View Profile")),
              Divider(color: Colors.white),
              ListTile(title: Text("Private Chat")),
              Divider(color: Colors.white),
              ListTile(title: Text("Transfer Credit")),
              Divider(color: Colors.white),
              ListTile(title: Text("Block")),
            ]),
          ),
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        margin: EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6)),
        child: Row(
          children: [
            CircleAvatar(radius: 20, backgroundImage: AssetImage('assets/avatar.png')),
            SizedBox(width: 10),
            Icon(Icons.circle, size: 10, color: getStatusColor(user['statusType'])),
            SizedBox(width: 6),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(user['username'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                SizedBox(height: 2),
                Text(user['status'], style: TextStyle(fontSize: 12, color: Colors.grey[700])),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final allTabs = [
      Tab(text: "Friends"),
      Tab(text: "Chatrooms"),
      ...joinedRooms.map((room) => Tab(text: room)),
    ];

    return DefaultTabController(
      length: allTabs.length,
      child: Scaffold(
        drawer: MigXDrawer(),
        backgroundColor: Color(0xFFE6E6FA),
        body: Column(
          children: [
            // Orange Header
            Container(
              padding: EdgeInsets.only(top: 40, left: 12, right: 12, bottom: 12),
              decoration: BoxDecoration(
                color: Color(0xFFFF9900),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: Row(
                children: [
                  Builder(builder: (context) => IconButton(
                        icon: Icon(Icons.menu, color: Colors.white),
                        onPressed: () => Scaffold.of(context).openDrawer(),
                      )),
                  Image.asset('assets/migx_logo.png', height: 28),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.mail, color: Colors.white),
                    onPressed: () => Navigator.pushNamed(context, '/inbox'),
                  ),
                  IconButton(icon: Icon(Icons.notifications, color: Colors.white), onPressed: () {}),
                  IconButton(icon: Icon(Icons.chat_bubble, color: Colors.white), onPressed: () {}),
                ],
              ),
            ),

            // Profile section
            Container(
              color: Color(0xFFFF9900),
              padding: EdgeInsets.all(12),
              child: Row(
                children: [
                  CircleAvatar(radius: 26, backgroundImage: AssetImage('assets/avatar.png')),
                  SizedBox(width: 10),
                  Icon(Icons.circle, size: 10, color: Colors.green),
                  SizedBox(width: 6),
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('myUsername',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16)),
                      RichText(
                        text: TextSpan(
                          text: 'Update your ',
                          style: TextStyle(fontSize: 12, color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(text: 'status', style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic)),
                            TextSpan(text: '...'),
                          ],
                        ),
                      ),
                    ]),
                  ),
                  Row(children: [
                    Icon(Icons.shield, size: 16, color: Colors.white),
                    SizedBox(width: 4),
                    Text('12', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                  ]),
                ],
              ),
            ),

            // Tabs
            TabBar(
              controller: _tabController,
              isScrollable: true,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              tabs: allTabs,
            ),

            // Tab content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Friends Tab
                  ListView.builder(
                    padding: EdgeInsets.all(12),
                    itemCount: friends.length,
                    itemBuilder: (context, index) => buildFriendRow(context, friends[index]),
                  ),
                  // Chatrooms Tab
                  Center(child: Text("Chatrooms Screen Placeholder")),
                  // Joined Rooms Tabs
                  ...joinedRooms.map((room) => Center(child: Text("Chatroom: $room"))).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
