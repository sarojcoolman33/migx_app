import 'package:flutter/material.dart';
import 'home_screen.dart'; // Adjust if your path is different

class MentorScreen extends StatelessWidget {
  const MentorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          // Header with back button
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 30, left: 8, right: 16, bottom: 16),
            color: const Color(0xFFFFA500),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                    );
                  },
                ),
                const SizedBox(width: 8),
                const Text(
                  'How to Become a Mentor & Merchant',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Mentor Section
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Mentor Role',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Mentors play a key role in expanding the MigX community by guiding users and managing merchants.',
                            style: TextStyle(fontSize: 14),
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            'Benefits:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 6),
                          const Text('- Create and manage unlimited merchants.'),
                          const Text('- Sell credits/coins to both users and merchants.'),
                          const Text('- Communicate directly with your Country Head staff.'),
                          const SizedBox(height: 15),
                          const Text(
                            'Requirements:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 6),
                          const Text('- Submit front and back images of your citizenship or passport.'),
                          const Text('- One-time application fee of \$300 to MigX.'),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              // TODO: mentor apply logic
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFFA500),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text('Apply for Mentorship'),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Merchant Section
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Merchant Role',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Merchants support the MigX ecosystem by selling digital goods and assisting users under their network.',
                            style: TextStyle(fontSize: 14),
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            'Application Process:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 6),
                          const Text('- Contact a Mentor in your country.'),
                          const Text('- Provide front and back images of your citizenship or passport.'),
                          const Text('- Pay a \$50 application fee directly to your Mentor.'),
                          const SizedBox(height: 15),
                          const Text(
                            'Benefits:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 6),
                          const Text('- Ability to create sub-merchants (requires Mentor approval).'),
                          const Text('- Sell credits/coins to users and other merchants.'),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              // TODO: contact mentor logic
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFFA500),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text('Contact Mentor to Apply'),
                          ),
                        ],
                      ),
                    ),
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
