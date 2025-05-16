import 'package:flutter/material.dart';

void main() => runApp(MigXApp());

class MigXApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MigX Chatrooms',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<Map<String, dynamic>> chatrooms = [
    {'title': 'General', 'description': 'General chat', 'capacity': 10, 'owner': 'Admin', 'category': 'Own', 'members': 5},
    {'title': 'Crash Game', 'description': 'Crash game discussion', 'capacity': 10, 'owner': 'GameMaster', 'category': 'Game', 'members': 10},
    {'title': 'Official News', 'description': 'Official announcements', 'capacity': 50, 'owner': 'Admin', 'category': 'Official', 'members': 45},
    {'title': 'Recent Hangout', 'description': 'Chill room', 'capacity': 15, 'owner': 'User1', 'category': 'Recently', 'members': 10},
  ];

  bool searching = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void openSearchPopup() {
    setState(() {
      searching = true;
    });

    showDialog(
      context: context,
      builder: (context) => SearchPopup(
        rooms: chatrooms,
        onClose: () {
          setState(() {
            searching = false;
          });
          Navigator.of(context).pop();
        },
      ),
    ).then((_) {
      setState(() {
        searching = false;
      });
    });
  }

  void openCreatePopup() {
    showDialog(
      context: context,
      builder: (context) => CreateChatroomPopup(
        existingRooms: chatrooms,
        onCreate: (newRoom) {
          setState(() {
            chatrooms.add(newRoom);
          });
        },
      ),
    );
  }

  void tryJoinRoom(Map<String, dynamic> room) {
    if (room['members'] >= room['capacity']) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${room['title']} is full. Try again later.'),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Joined ${room['title']}!'),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green,
      ),
    );
  }

  List<Widget> buildCategoryRooms(String category) {
    final rooms = chatrooms.where((r) => r['category'] == category).toList();

    if (rooms.isEmpty) {
      return [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('No chatrooms available.'),
        )
      ];
    }

    return rooms.map((room) {
      return ListTile(
        title: Text(room['title']),
        subtitle: Text(room['description']),
        trailing: Text('${room['members']}/${room['capacity']}'),
        onTap: () => tryJoinRoom(room),
      );
    }).toList();
  }

  Widget _buildCategorySection(String category, String title) {
    return ExpansionTile(
      title: Text(title,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.orange)),
      initiallyExpanded: true,
      children: buildCategoryRooms(category),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Orange Notch Top bar with TabBar
            Container(
              color: Colors.orange,
              child: TabBar(
                controller: _tabController,
                indicatorColor: Colors.white,
                tabs: const [
                  Tab(icon: Icon(Icons.home), text: 'Home'),
                  Tab(icon: Icon(Icons.chat), text: 'Chatrooms'),
                ],
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white70,
              ),
            ),

            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Center(child: Text('Home Screen')),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        child: Row(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              onPressed: openSearchPopup,
                              child: const Text('Search'),
                            ),
                            const SizedBox(width: 12),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              onPressed: openCreatePopup,
                              child: const Text('Create Chatroom'),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          children: [
                            _buildCategorySection('Own', 'Own Chatrooms'),
                            _buildCategorySection('Game', 'Game Rooms'),
                            _buildCategorySection('Official', 'Official Rooms'),
                            _buildCategorySection('Recently', 'Recently Visited'),
                          ],
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

class SearchPopup extends StatefulWidget {
  final List<Map<String, dynamic>> rooms;
  final VoidCallback onClose;

  const SearchPopup({
    Key? key,
    required this.rooms,
    required this.onClose,
  }) : super(key: key);

  @override
  State<SearchPopup> createState() => _SearchPopupState();
}

class _SearchPopupState extends State<SearchPopup> {
  List<Map<String, dynamic>> searchResults = [];
  final TextEditingController _searchController = TextEditingController();

  void _performSearch(String query) {
    final results = widget.rooms
        .where((room) =>
            room['title'].toString().toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {
      searchResults = results;
    });
  }

  @override
  void initState() {
    super.initState();
    searchResults = widget.rooms;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildRoomTile(Map<String, dynamic> room) {
    return ListTile(
      title: Text(room['title']),
      subtitle: Text(room['description']),
      trailing: Text('${room['members']}/${room['capacity']}'),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Selected ${room['title']}')),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: SizedBox(
        height: 400,
        child: Column(
          children: [
            Container(
              height: 50,
              decoration: const BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: widget.onClose,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: 'Search chatrooms',
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.white70),
                      ),
                      style: const TextStyle(color: Colors.white),
                      onChanged: _performSearch,
                      autofocus: true,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: searchResults.isEmpty
                  ? const Center(child: Text('No results found'))
                  : ListView.builder(
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) =>
                          _buildRoomTile(searchResults[index]),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class CreateChatroomPopup extends StatefulWidget {
  final List<Map<String, dynamic>> existingRooms;
  final Function(Map<String, dynamic>) onCreate;

  const CreateChatroomPopup({
    Key? key,
    required this.existingRooms,
    required this.onCreate,
  }) : super(key: key);

  @override
  _CreateChatroomPopupState createState() => _CreateChatroomPopupState();
}

class _CreateChatroomPopup

