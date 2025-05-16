import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'chatrooms_screen.dart';
import 'chatroom_screen.dart';
import 'migx_drawer.dart';

class TabbedHomeScreen extends StatefulWidget {
  @override
  _TabbedHomeScreenState createState() => _TabbedHomeScreenState();
}

class _TabbedHomeScreenState extends State<TabbedHomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  late List<Tab> _tabs;
  late List<Widget> _tabViews;

  @override
  void initState() {
    super.initState();
    _tabs = [
      const Tab(text: 'Home'),
      const Tab(text: 'Chatrooms'),
    ];
    _tabViews = [
      HomeScreen(),
      ChatroomsScreen(onJoinChatroom: _handleJoinChatroom),
    ];
    _initTabController();
  }

  void _initTabController() {
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  void _handleJoinChatroom(String chatroomName) {
    setState(() {
      _tabs.add(Tab(text: chatroomName));
      _tabViews.add(ChatroomScreen(roomName: chatroomName));
      _initTabController();
      _tabController.animateTo(_tabs.length - 1);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MigXDrawer(),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF9900),
        title: const Text('MigX'),
        bottom: TabBar(
          controller: _tabController,
          tabs: _tabs,
          isScrollable: true,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _tabViews,
      ),
    );
  }
}
