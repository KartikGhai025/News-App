import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/user_service.dart';

class UserProvider with ChangeNotifier {
  final UserService userService;
  DocumentSnapshot? userProfile;
  bool isLoading = false;

  UserProvider({required this.userService});

  Future<void> fetchUserProfile(String userId) async {
    isLoading = true;
    notifyListeners();

    try {
      userProfile = await userService.getUserProfile(userId);
    } catch (e) {
      log('Error fetching user profile: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
