import 'package:flutter/material.dart';
import '../widgets/contact_info_card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit, color: Colors.black87),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          const CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(
              "https://i.pravatar.cc/150?img=3",
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            "John Doe",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const Text(
            "johndoe@gmail.com",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "contact information",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black.withOpacity(0.7),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(top: 8),
              children: const [
                ContactInfoCard(
                  icon: Icons.email,
                  title: "Email address:",
                  value: "johndoe@gmail.com",
                ),
                ContactInfoCard(
                  icon: Icons.phone,
                  title: "Phone Number",
                  value: "+2517479262",
                ),
                ContactInfoCard(
                  icon: Icons.phone,
                  title: "Additional Phone number",
                  value: "+251716489722",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
