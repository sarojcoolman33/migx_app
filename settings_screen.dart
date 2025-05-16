import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _showSuccessPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => const AlertDialog(
        backgroundColor: Color(0xFF1E1E1E),
        content: Text('Saved successfully!', style: TextStyle(color: Colors.white)),
      ),
    );

    Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context, rootNavigator: true).pop();
    });
  }

  void _showSecurityQuestionDialog(BuildContext context) {
    String selectedQuestion = "What is your pet's name?";
    final answerController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: const Color(0xFF1E1E1E),
              title: const Text('Set Security Question', style: TextStyle(color: Colors.white)),
              content: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButton<String>(
                      value: selectedQuestion,
                      isExpanded: true,
                      dropdownColor: const Color(0xFF2A2A2A),
                      style: const TextStyle(color: Colors.white),
                      onChanged: (value) => setState(() => selectedQuestion = value!),
                      items: [
                        "What is your pet's name?",
                        "What is your mother's maiden name?",
                        "What was your first school?"
                      ].map((question) {
                        return DropdownMenuItem(
                          value: question,
                          child: Text(question),
                        );
                      }).toList(),
                    ),
                    TextField(
                      controller: answerController,
                      decoration: const InputDecoration(
                        labelText: 'Answer',
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  style: TextButton.styleFrom(foregroundColor: Colors.orange),
                  onPressed: () {
                    Navigator.pop(context);
                    _showSuccessPopup(context);
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showMpinDialog(BuildContext context) {
    final mpinController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        title: const Text('Create MPIN', style: TextStyle(color: Colors.white)),
        content: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: TextField(
            controller: mpinController,
            decoration: const InputDecoration(
              labelText: 'Enter 4-digit MPIN',
            ),
            keyboardType: TextInputType.number,
            maxLength: 4,
            obscureText: true,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.orange),
            onPressed: () {
              Navigator.pop(context);
              _showSuccessPopup(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    final currentController = TextEditingController();
    final newController = TextEditingController();
    final confirmController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        title: const Text('Change Password', style: TextStyle(color: Colors.white)),
        content: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: currentController,
                decoration: const InputDecoration(labelText: 'Current Password'),
                obscureText: true,
                style: const TextStyle(color: Colors.white),
              ),
              TextField(
                controller: newController,
                decoration: const InputDecoration(labelText: 'New Password'),
                obscureText: true,
                style: const TextStyle(color: Colors.white),
              ),
              TextField(
                controller: confirmController,
                decoration: const InputDecoration(labelText: 'Confirm New Password'),
                obscureText: true,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.orange),
            onPressed: () {
              Navigator.pop(context);
              _showSuccessPopup(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 40, bottom: 16),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFFFFA500),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                  },
                ),
                const Expanded(
                  child: Center(
                    child: Text(
                      'Settings',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(width: 48),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: const Icon(Icons.security, color: Colors.white),
            title: const Text('Set Security Question', style: TextStyle(color: Colors.white)),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white),
            onTap: () => _showSecurityQuestionDialog(context),
          ),
          const Divider(color: Colors.white12),
          ListTile(
            leading: const Icon(Icons.lock_outline, color: Colors.white),
            title: const Text('Create MPIN', style: TextStyle(color: Colors.white)),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white),
            onTap: () => _showMpinDialog(context),
          ),
          const Divider(color: Colors.white12),
          ListTile(
            leading: const Icon(Icons.password, color: Colors.white),
            title: const Text('Change Password', style: TextStyle(color: Colors.white)),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white),
            onTap: () => _showChangePasswordDialog(context),
          ),
        ],
      ),
    );
  }
}
