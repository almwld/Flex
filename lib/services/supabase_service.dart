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
