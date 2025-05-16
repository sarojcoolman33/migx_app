import 'package:flutter/material.dart';
import 'mail_detail_screen.dart';

class InboxScreen extends StatelessWidget {
  final List<Map<String, String>> mails = [
    {
      'title': 'Daily Rank Points',
      'message': 'Congratulations! You earned 120 points today.',
      'date': 'May 12, 2025',
    },
    {
      'title': 'Mentor Approval',
      'message': 'Your mentor request has been approved. Welcome aboard!',
      'date': 'May 11, 2025',
    },
    {
      'title': 'Official Reward',
      'message': 'You received 50 coins as a reward for your activity.',
      'date': 'May 10, 2025',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Inbox'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context), // Go back to home
        ),
      ),
      body: ListView.builder(
        itemCount: mails.length,
        itemBuilder: (context, index) {
          final mail = mails[index];
          return Card(
            color: Colors.grey[900],
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              title: Text(mail['title']!, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              subtitle: Text(
                mail['message']!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey[300]),
              ),
              trailing: Text(mail['date']!, style: TextStyle(color: Colors.grey, fontSize: 12)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MailDetailScreen(
                      title: mail['title']!,
                      message: mail['message']!,
                      date: mail['date']!,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
