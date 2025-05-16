import 'package:flutter/material.dart';

class Message {
  final String id;
  final String username;
  final String avatarUrl;
  final String message;
  final String timestamp;
  final String rank; // e.g. admin, mod, user
  final bool isOwn;

  Message({
    required this.id,
    required this.username,
    required this.avatarUrl,
    required this.message,
    required this.timestamp,
    required this.rank,
    required this.isOwn,
  });
}

class ChatroomScreen extends StatefulWidget {
  final String chatroomName;
  final String chatroomDescription;
  final String ownerName;
  final List<String> participants;
  final List<Message> messages;

  const ChatroomScreen({
    Key? key,
    required this.chatroomName,
    required this.chatroomDescription,
    required this.ownerName,
    required this.participants,
    required this.messages,
  }) : super(key: key);

  @override
  State<ChatroomScreen> createState() => _ChatroomScreenState();
}

class _ChatroomScreenState extends State<ChatroomScreen> {
  final TextEditingController _msgController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isAtBottom = true;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
          _isAtBottom = true;
        }
      } else {
        _isAtBottom = false;
      }
    });
  }

  @override
  void dispose() {
    _msgController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Color _getRankColor(String rank, bool isOwn) {
    if (isOwn) return Colors.green;
    switch (rank.toLowerCase()) {
      case 'admin':
        return Colors.red;
      case 'mod':
        return Colors.blue;
      case 'vip':
        return Colors.purple;
      default:
        return Colors.black87;
    }
  }

  void _sendMessage() {
    final text = _msgController.text.trim();
    if (text.isEmpty) return;
    final newMsg = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      username: 'YourUsername', // Replace with actual logged-in user
      avatarUrl: 'https://i.pravatar.cc/150?img=5', // Replace with actual avatar
      message: text,
      timestamp: _formatTimestamp(DateTime.now()),
      rank: 'user', // Replace accordingly
      isOwn: true,
    );
    setState(() {
      widget.messages.add(newMsg);
    });
    _msgController.clear();

    if (_isAtBottom) {
      Future.delayed(Duration(milliseconds: 100), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  String _formatTimestamp(DateTime dt) {
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  void _showThreeDotMenu() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Colors.white,
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.info_outline),
                title: Text('Chatroom Info'),
                onTap: () {
                  Navigator.pop(context);
                  _showChatroomInfo();
                },
              ),
              ListTile(
                leading: Icon(Icons.group),
                title: Text('Participants'),
                onTap: () {
                  Navigator.pop(context);
                  _showParticipants();
                },
              ),
              ListTile(
                leading: Icon(Icons.account_balance_wallet),
                title: Text('Balance Check'),
                onTap: () {
                  Navigator.pop(context);
                  _showBalanceCheck();
                },
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Leave Chatroom'),
                onTap: () {
                  Navigator.pop(context);
                  _leaveChatroom();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showChatroomInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Chatroom Info'),
        content: Text(widget.chatroomDescription),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Close')),
        ],
      ),
    );
  }

  void _showParticipants() {
    final usersText = widget.participants.length <= 5
        ? widget.participants.join(', ')
        : widget.participants.sublist(0, 5).join(', ') +
            ' and ${widget.participants.length - 5} others';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Participants'),
        content: Text(usersText),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Close')),
        ],
      ),
    );
  }

  void _showBalanceCheck() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Balance Check'),
        content: Text('Your current balance is: \$100'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Close')),
        ],
      ),
    );
  }

  void _leaveChatroom() {
    Navigator.pop(context); // Replace with actual leave logic
  }

  @override
  Widget build(BuildContext context) {
    final usersPreview = widget.participants.length <= 5
        ? widget.participants.join(', ')
        : widget.participants.sublist(0, 5).join(', ') +
            ' and ${widget.participants.length - 5} others';

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(widget.chatroomName),
        leading: BackButton(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onPressed: _showThreeDotMenu,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Container(
            color: Colors.orange[300],
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.chatroomDescription,
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  'Owner: ${widget.ownerName}',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
                SizedBox(height: 4),
                Text(
                  'Users: $usersPreview',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.symmetric(vertical: 8),
                itemCount: widget.messages.length,
                itemBuilder: (context, index) {
                  final msg = widget.messages[index];
                  return Align(
                    alignment: msg.isOwn ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                      decoration: BoxDecoration(
                        color: msg.isOwn ? Colors.green[300] : Colors.grey[300],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                          bottomLeft: msg.isOwn ? Radius.circular(12) : Radius.circular(0),
                          bottomRight: msg.isOwn ? Radius.circular(0) : Radius.circular(12),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(msg.avatarUrl),
                            radius: 16,
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  msg.username,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: _getRankColor(msg.rank, msg.isOwn),
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  msg.message,
                                  style: TextStyle(color: Colors.black87),
                                ),
                                SizedBox(height: 4),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    msg.timestamp,
                                    style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Divider(height: 1),
            Container(
              color: Colors.grey[200],
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.more_vert),
                    onPressed: _showThreeDotMenu,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _msgController,
                      decoration: InputDecoration(
                        hintText: 'Type a message',
                        border: InputBorder.none,
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.emoji_emotions_outlined),
                    onPressed: () {
                      // TODO: open emoji picker
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: _sendMessage,
                    color: Colors.orange,
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
