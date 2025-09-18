// lib/profile.dart
import 'package:flutter/material.dart';
import 'dart:io';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static const _primary = Colors.teal; // 🔹 نفس اللون الأساسي اللي عندك في Home

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              // صورة دائرية
              CircleAvatar(
                radius: 80,
                backgroundColor: Colors.teal.shade100, // خلفية أنعم
                child: ClipOval(
                  child: Image.asset(
                    'image/76d79a84-36ef-447d-b8b1-567e4fd3cb2d.png',
                    width: 160,
                    height: 160,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // الاسم
              const Text(
                'Nassar Barahmeh',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 6),

              // الإيميل
              Text(
                'Nassar1@gmail.com',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade700,
                ),
              ),

              const SizedBox(height: 30),

              // زر تعديل البروفايل
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.edit, color: Colors.white),
                label: const Text(
                  'Edit Profile',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  elevation: 3,
                ),
              ),

              const SizedBox(height: 16),


              ElevatedButton.icon(
                onPressed: () {

                },
                icon: const Icon(Icons.logout, color: Colors.white),
                label: const Text(
                  'Log Out',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade600,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  elevation: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
