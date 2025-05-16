import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  void _showPrivacyPolicy(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          'Privacy & Policy',
          style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: Text(
            '''At MigX, your privacy is important to us. We collect only the necessary information to provide our services and improve user experience. This includes:

- Username, email, gender, and country during sign-up
- Device info for app optimization
- Chatroom and friend activity for safety
- Optional avatar and profile info

We do NOT share personal data with third parties unless required by law or to deliver core services.

Your data is protected with encryption. You can request to delete your account anytime.

By using MigX, you agree to this policy.''',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Done', style: TextStyle(color: Colors.orange)),
          ),
        ],
      ),
    );
  }

  void _showTermsAndConditions(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          'Terms & Conditions',
          style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: Text(
            '''By using MigX, you agree to the following terms:

1. Account Responsibility:
You are responsible for your account activity. Do not share your password. You must be 13 years or older to use MigX.

2. Respectful Behavior:
Harassment, hate speech, threats, or adult content are strictly forbidden. Users must treat others with respect.

3. No Illegal Use:
MigX may not be used for illegal activity such as fraud, spam, or hacking.

4. Content Ownership:
You own the content you post. MigX has a license to display and share your content inside the app.

5. Moderation Rights:
MigX may suspend or remove accounts that break rules without notice.

6. Changes:
Terms may be updated. Continuing to use MigX means you accept the changes.''',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Done', style: TextStyle(color: Colors.orange)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // Orange notch-style header
          Container(
            padding: EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 20),
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                SizedBox(width: 10),
                Text(
                  'About Us',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Main content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Logo placeholder
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        'Logo',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Founders and Company Info
                  Text(
                    'Founders: SS Brothers',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Text(
                    'MigX is a registered company in Singapore',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  SizedBox(height: 30),

                  // Privacy & Terms
                  GestureDetector(
                    onTap: () => _showPrivacyPolicy(context),
                    child: Text(
                      'Privacy & Policy',
                      style: TextStyle(
                        color: Colors.orange,
                        decoration: TextDecoration.underline,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () => _showTermsAndConditions(context),
                    child: Text(
                      'Terms & Conditions',
                      style: TextStyle(
                        color: Colors.orange,
                        decoration: TextDecoration.underline,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Spacer(),

                  // App Version
                  Text(
                    'Version: 1.0.0',
                    style: TextStyle(color: Colors.white38),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
