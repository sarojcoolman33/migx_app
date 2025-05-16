import 'package:flutter/material.dart';
import 'package:migx/screens/home_screen.dart';

class StoresScreen extends StatelessWidget {
  final List<Map<String, String>> emojiPacks = [
    {
      'name': 'Funny Pack',
      'price': '25 Coins',
      'image': 'assets/emojis/funny_pack.png',
    },
    {
      'name': 'Love Pack',
      'price': '30 Coins',
      'image': 'assets/emojis/love_pack.png',
    },
  ];

  final List<Map<String, String>> gifts = [
    {
      'name': 'Balloon',
      'price': '8 Coins',
      'image': 'assets/gifts/balloon.png',
    },
    {
      'name': 'Rose',
      'price': '10 Coins',
      'image': 'assets/gifts/rose.png',
    },
    {
      'name': 'Cake',
      'price': '15 Coins',
      'image': 'assets/gifts/cake.png',
    },
    {
      'name': 'Chocolate Box',
      'price': '18 Coins',
      'image': 'assets/gifts/chocolate_box.png',
    },
    {
      'name': 'Teddy Bear',
      'price': '20 Coins',
      'image': 'assets/gifts/teddy.png',
    },
  ];

  final List<Map<String, String>> avatars = [
    {
      'name': 'Coming Soon',
      'price': '',
      'image': 'assets/avatars/placeholder.png',
    },
  ];

  void showCenterPopup(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              message,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
    Future.delayed(const Duration(seconds: 1), () {
      overlayEntry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: SafeArea(
          child: Column(
            children: [
              // Orange Top Bar
              Container(
                color: Colors.orange,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context); // back to previous HomeScreen
                      },
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      'MigX Stores',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Segmented Tab Bar
              Container(
                color: Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TabBar(
                    indicator: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.orange,
                    labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                    tabs: const [
                      Tab(text: 'Emojis'),
                      Tab(text: 'Gifts'),
                      Tab(text: 'Avatars'),
                    ],
                  ),
                ),
              ),

              // Tab Views
              Expanded(
                child: TabBarView(
                  children: [
                    _buildPackList(context, emojiPacks),
                    _buildGiftList(gifts),
                    _buildItemList(avatars),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Emoji Pack List
  Widget _buildPackList(BuildContext context, List<Map<String, String>> packs) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: packs.length,
      itemBuilder: (context, index) {
        final pack = packs[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 10),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Image.asset(
                  pack['image']!,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(pack['name']!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      Text(pack['price']!, style: const TextStyle(fontSize: 14)),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    showCenterPopup(context, 'Successfully bought!');
                  },
                  child: const Text('Buy'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Gift List - Read-only, sorted low to high price
  Widget _buildGiftList(List<Map<String, String>> gifts) {
    final sortedGifts = [...gifts];
    sortedGifts.sort((a, b) {
      int priceA = int.parse(a['price']!.replaceAll(' Coins', ''));
      int priceB = int.parse(b['price']!.replaceAll(' Coins', ''));
      return priceA.compareTo(priceB);
    });

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: sortedGifts.length,
      itemBuilder: (context, index) {
        final gift = sortedGifts[index];
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
            ],
          ),
          child: ListTile(
            leading: Image.asset(
              gift['image']!,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(gift['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(gift['price']!),
          ),
        );
      },
    );
  }

  // Avatar List - Placeholder
  Widget _buildItemList(List<Map<String, String>> items) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            leading: Image.asset(
              item['image']!,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(item['name']!),
            subtitle: Text(item['price']!),
          ),
        );
      },
    );
  }
}
