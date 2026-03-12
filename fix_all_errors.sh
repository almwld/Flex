#!/bin/bash

cd ~/flex

echo "🔧 إصلاح جميع أخطاء الكود..."

# 1. إصلاح AppTheme - إضافة goldColor و CardThemeData
cat > lib/theme/app_theme.dart << 'EOF'
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  // الألوان الأساسية
  static const Color goldColor = Color(0xFFD4AF37);
  static const Color darkGold = Color(0xFFB8860B);
  static const Color lightGold = Color(0xFFF4E4BC);
  static const Color black = Color(0xFF0A0A0A);
  static const Color darkGrey = Color(0xFF1A1A1A);
  static const Color grey = Color(0xFF2A2A2A);
  static const Color lightGrey = Color(0xFF888888);
  static const Color white = Colors.white;

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: black,
      primaryColor: goldColor,
      colorScheme: const ColorScheme.dark(
        primary: goldColor,
        secondary: darkGold,
        surface: darkGrey,
        onPrimary: Colors.black,
        onSecondary: Colors.white,
        onSurface: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        iconTheme: IconThemeData(color: goldColor),
        titleTextStyle: TextStyle(
          color: goldColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: darkGrey,
        selectedItemColor: goldColor,
        unselectedItemColor: lightGrey,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      cardTheme: CardThemeData(
        color: darkGrey,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: goldColor,
          foregroundColor: Colors.black,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: grey,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: goldColor, width: 2),
        ),
        labelStyle: const TextStyle(color: lightGrey),
        hintStyle: const TextStyle(color: lightGrey),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: goldColor,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
        bodyMedium: TextStyle(
          color: lightGrey,
          fontSize: 14,
        ),
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      primaryColor: goldColor,
      colorScheme: const ColorScheme.light(
        primary: goldColor,
        secondary: darkGold,
        surface: Colors.white,
        onPrimary: Colors.black,
        onSecondary: Colors.black,
        onSurface: Colors.black,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: goldColor),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: goldColor,
          foregroundColor: Colors.black,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
EOF

# 2. إصلاح supabase_service.dart - إضافة dart:typed_data
cat > lib/services/supabase_service.dart << 'EOF'
import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseClient client = Supabase.instance.client;
  
  static User? get currentUser => client.auth.currentUser;
  
  static Future<void> initialize() async {
    // Already initialized in main.dart
  }
  
  static Future<AuthResponse> signIn(String email, String password) async {
    return await client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }
  
  static Future<AuthResponse> signUp(String email, String password, Map<String, dynamic> data) async {
    return await client.auth.signUp(
      email: email,
      password: password,
      data: data,
    );
  }
  
  static Future<void> signOut() async {
    await client.auth.signOut();
  }
  
  static Future<List<Map<String, dynamic>>> getAds({String? category, String? city}) async {
    var query = client.from('ads').select('*, profiles(*)');
    
    if (category != null && category != 'الكل') {
      query = query.eq('category', category);
    }
    
    if (city != null && city != 'الكل') {
      query = query.eq('city', city);
    }
    
    final response = await query.order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(response);
  }
  
  static Future<void> addAd(Map<String, dynamic> adData) async {
    await client.from('ads').insert(adData);
  }
  
  static Future<List<Map<String, dynamic>>> getChats(String userId) async {
    final response = await client
        .from('chats')
        .select('*, other_user:profiles!other_user_id(*)')
        .or('user_id.eq.$userId,other_user_id.eq.$userId')
        .order('last_message_time', ascending: false);
    
    return List<Map<String, dynamic>>.from(response);
  }
  
  static Future<void> sendMessage(String chatId, String content) async {
    await client.from('messages').insert({
      'chat_id': chatId,
      'sender_id': currentUser!.id,
      'content': content,
      'created_at': DateTime.now().toIso8601String(),
    });
    
    await client.from('chats').update({
      'last_message': content,
      'last_message_time': DateTime.now().toIso8601String(),
    }).eq('id', chatId);
  }
  
  static Stream<List<Map<String, dynamic>>> messagesStream(String chatId) {
    return client
        .from('messages')
        .stream(primaryKey: ['id'])
        .eq('chat_id', chatId)
        .order('created_at')
        .map((data) => List<Map<String, dynamic>>.from(data));
  }
  
  static Future<double> getBalance(String userId) async {
    try {
      final response = await client
          .from('wallets')
          .select('balance')
          .eq('user_id', userId)
          .single();
      return (response['balance'] as num).toDouble();
    } catch (e) {
      return 0.0;
    }
  }
  
  static Future<void> createTransaction(Map<String, dynamic> transaction) async {
    await client.from('transactions').insert(transaction);
  }
  
  static Future<Map<String, dynamic>?> getUserProfile(String userId) async {
    final response = await client
        .from('profiles')
        .select('*')
        .eq('id', userId)
        .single();
    return response;
  }
  
  static Future<void> updateUserProfile(String userId, Map<String, dynamic> data) async {
    await client.from('profiles').update(data).eq('id', userId);
  }
  
  static Future<String?> uploadImage(String bucket, String path, Uint8List fileBytes) async {
    try {
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final fullPath = '$path/$fileName';
      
      await client.storage.from(bucket).uploadBinary(
        fullPath,
        fileBytes,
        fileOptions: const FileOptions(contentType: 'image/jpeg'),
      );
      
      return client.storage.from(bucket).getPublicUrl(fullPath);
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }
}
EOF

# 3. إنشاء مجلدات الأصول الفارغة
mkdir -p assets/{images,animations,fonts}

# 4. إنشاء ملف placeholder
touch assets/images/.gitkeep
touch assets/animations/.gitkeep
touch assets/fonts/.gitkeep

echo "☁️ رفع التغييرات..."

git add .
git commit -m "🔧 Fix: Add goldColor, CardThemeData, Uint8List, and create asset directories"
git push origin main

echo "✅ تم إصلاح جميع الأخطاء!"
echo "🚀 جاري البناء..."
