import 'package:flutter/material.dart';

class HelpSupportScreen extends StatefulWidget {
  @override
  _HelpSupportScreenState createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  final List<String> issues = [
    'Login problem',
    'Signup failed',
    'Chat not loading',
    'Cannot send/receive message',
    'App crashes',
    'Other',
  ];

  final Map<String, bool> selectedIssues = {};
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    for (var issue in issues) {
      selectedIssues[issue] = false;
    }
  }

  void _submitIssue() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        content: Text(
          'Issue submitted successfully!',
          style: TextStyle(color: Colors.black87),
        ),
      ),
    );

    Future.delayed(Duration(seconds: 1), () {
      Navigator.of(context).pop();
    });

    setState(() {
      for (var key in selectedIssues.keys) {
        selectedIssues[key] = false;
      }
      descriptionController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Help & Support'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select your issue:',
                      style: TextStyle(color: Colors.black87, fontSize: 16),
                    ),
                    ...issues.map((issue) {
                      return CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(issue, style: TextStyle(color: Colors.black87)),
                        value: selectedIssues[issue],
                        onChanged: (val) {
                          setState(() {
                            selectedIssues[issue] = val!;
                          });
                        },
                        activeColor: Colors.orange,
                        checkColor: Colors.white,
                      );
                    }).toList(),
                    SizedBox(height: 16),
                    Text(
                      'Describe the issue:',
                      style: TextStyle(color: Colors.black87, fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: descriptionController,
                      maxLines: 4,
                      style: TextStyle(color: Colors.black87),
                      decoration: InputDecoration(
                        hintText: 'Describe your issue...',
                        hintStyle: TextStyle(color: Colors.black54),
                        filled: true,
                        fillColor: Color(0xFFF0F0F0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    Center(
                      child: ElevatedButton(
                        onPressed: _submitIssue,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
