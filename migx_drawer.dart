import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MigXDrawer extends StatelessWidget {
  const MigXDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFFFF9900)),
              child: Center(
                child: Text('MigX Menu',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white)),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 10),
                children: [
                  _ignoreDrawerItem(icon: Icons.account_balance_wallet, title: 'Balance'),
                  _buildDrawerNavItem(context, Icons.announcement, 'Announcements', '/announcements'),
                  _buildDrawerNavItem(context, Icons.feed, 'MigX Feed', '/feed'),
                  _buildDrawerNavItem(context, Icons.store, 'MigX Stores', '/stores'),
                  _buildDrawerNavItem(context, Icons.star, 'Become a Mentor / Merchant', '/mentor'),
                  _buildDrawerNavItem(context, Icons.settings, 'Settings', '/settings'),
                  _buildDrawerNavItem(context, Icons.help, 'Help & Support', '/help'),
                  _buildDrawerNavItem(context, Icons.info, 'About Us', '/about'),
                  Divider(),
                  _buildDrawerNavItem(context, Icons.logout, 'Logout', '/login', replace: true),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  FaIcon(FontAwesomeIcons.facebook, color: Colors.blue),
                  FaIcon(FontAwesomeIcons.instagram, color: Colors.purple),
                  FaIcon(FontAwesomeIcons.twitter, color: Colors.lightBlue),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({required IconData icon, required String title}) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.black),
          SizedBox(width: 10),
          Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildDrawerNavItem(BuildContext context, IconData icon, String title, String route,
      {bool replace = false}) {
    return InkWell(
      onTap: () {
        if (replace) {
          Navigator.pushReplacementNamed(context, route);
        } else {
          Navigator.pushNamed(context, route);
        }
      },
      child: _buildDrawerItem(icon: icon, title: title),
    );
  }

  Widget _ignoreDrawerItem({required IconData icon, required String title}) {
    return IgnorePointer(
      ignoring: true,
      child: Opacity(
        opacity: 0.9,
        child: _buildDrawerItem(icon: icon, title: title),
      ),
    );
  }
}
