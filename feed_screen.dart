import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final TextEditingController _postController = TextEditingController();
  final List<Map<String, dynamic>> _posts = [];

  void _uploadPost() {
    if (_postController.text.trim().isEmpty) return;

    setState(() {
      _posts.insert(0, {
        'username': 'Shiv',
        'badge': 'Gold',
        'profileUrl': 'https://i.pravatar.cc/150?img=1',
        'text': _postController.text,
        'timestamp': DateTime.now(),
      });
    });

    _postController.clear();
    _showInstantPopup(context);
  }

  void _showInstantPopup(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.of(context).pop();
        });
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: Row(
            children: const [
              Icon(Icons.check_circle, color: Colors.green),
              SizedBox(width: 10),
              Text('Post uploaded successfully!', style: TextStyle(color: Colors.black)),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MigX Feed'),
        backgroundColor: Color(0xFFFF9900),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Upload Box
            Container(
              padding: const EdgeInsets.all(12),
              color: Color(0xFFFFF3E0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Share something with your friends:',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _postController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: "What's on your mind?",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      contentPadding: const EdgeInsets.all(12),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: _uploadPost,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFF9900),
                      ),
                      child: const Text('Post'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // Posts
            Expanded(
              child: _posts.isEmpty
                  ? const Center(child: Text('No recent posts', style: TextStyle(color: Colors.grey)))
                  : ListView.builder(
                      itemCount: _posts.length,
                      itemBuilder: (context, index) {
                        final post = _posts[index];
                        final time = DateFormat('MMM dd, hh:mm a').format(post['timestamp']);
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white12,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // User info
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(post['profileUrl']),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(post['username'],
                                          style: const TextStyle(fontWeight: FontWeight.bold)),
                                      Container(
                                        margin: const EdgeInsets.only(top: 2),
                                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: Colors.orange,
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        child: Text(post['badge'],
                                            style: const TextStyle(
                                                fontSize: 10, fontWeight: FontWeight.bold)),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                                ],
                              ),
                              const SizedBox(height: 10),
                              // Post text
                              Text(post['text'], style: const TextStyle(fontSize: 14)),
                              const SizedBox(height: 10),
                              // Like & Comment
                              Row(
                                children: const [
                                  Icon(Icons.thumb_up_alt_outlined, size: 18, color: Colors.grey),
                                  SizedBox(width: 8),
                                  Icon(Icons.comment_outlined, size: 18, color: Colors.grey),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}
