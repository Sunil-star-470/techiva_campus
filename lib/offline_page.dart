import 'package:flutter/material.dart';

class OfflinePage extends StatefulWidget {
  final VoidCallback onRetry;

  const OfflinePage({super.key, required this.onRetry});

  @override
  State<OfflinePage> createState() => _OfflinePageState();
}

class _OfflinePageState extends State<OfflinePage> {

  bool dialogShown = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Show popup only once
    if (!dialogShown) {
      dialogShown = true;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        showOfflineDialog(context);
      });
    }
  }

  // 🔥 OFFLINE POPUP
  void showOfflineDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),

          title: const Row(
            children: [
              Icon(Icons.wifi_off, color: Colors.red),
              SizedBox(width: 10),
              Text("No Internet"),
            ],
          ),

          content: const Text(
            "Please switch on your mobile data",
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                widget.onRetry();
              },
              child: const Text("Retry"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        child: Column(
          children: [

            // 🔵 NAVBAR
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Image.asset(
                    'assets/images/bgimage.png',
                    height: 40,
                  ),

                  Row(
                    children: [

                      const Text("Features"),

                      const SizedBox(width: 10),

                      const Text("Pricing"),

                      const SizedBox(width: 10),

                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("Sign In"),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 🔵 HERO SECTION
            Container(
              width: double.infinity,

              padding: const EdgeInsets.symmetric(
                vertical: 40,
                horizontal: 20,
              ),

              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF3B82F6),
                    Color(0xFF1D4ED8),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),

              child: Column(
                children: [

                  const Text(
                    "Institute Management System",
                    textAlign: TextAlign.center,

                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Simplify Administration, Enhance Productivity, and Drive Growth",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: widget.onRetry,

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),

                    child: const Text("Retry"),
                  ),

                  const SizedBox(height: 30),

                  // 📸 IMAGE
                  Container(
                    height: 150,
                    width: double.infinity,

                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(10),
                    ),

                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),

                      child: Image.asset(
                        'assets/images/principaldashboard.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ⚫ FEATURES
            Container(
              color: Colors.black,
              padding: const EdgeInsets.all(16),

              child: Column(
                children: [

                  const Text(
                    "Experience the Best-in-Class Features We Offer",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 20),

                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),

                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.9,

                    children: const [

                      FeatureCard(Icons.inventory, "Inventory"),
                      FeatureCard(Icons.people, "Staff Attendance"),
                      FeatureCard(Icons.school, "Student Attendance"),
                      FeatureCard(Icons.bar_chart, "Result Management"),
                      FeatureCard(Icons.campaign, "Notice Board"),
                      FeatureCard(Icons.history, "Event History"),
                      FeatureCard(Icons.payment, "Fees Collection"),
                      FeatureCard(Icons.account_balance_wallet, "Salary"),
                    ],
                  ),
                ],
              ),
            ),

            // 🔻 FOOTER
            Container(
              width: double.infinity,
              color: const Color(0xFF1E293B),
              padding: const EdgeInsets.all(20),

              child: const Column(
                children: [

                  Text(
                    "TECHIVA Innovations",
                    style: TextStyle(color: Colors.white),
                  ),

                  SizedBox(height: 10),

                  Text(
                    "Privacy Policy | Terms",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    "© Copyright 2024 Techiva Innovations",
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 12,
                    ),
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

class FeatureCard extends StatelessWidget {

  final IconData icon;
  final String title;

  const FeatureCard(this.icon, this.title, {super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),

      padding: const EdgeInsets.all(10),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [

          Icon(
            icon,
            size: 30,
            color: Colors.blue,
          ),

          const SizedBox(height: 10),

          Text(
            title,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}