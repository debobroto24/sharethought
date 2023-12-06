import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../network/database_constant.dart';

final usernameAvailabilityProvider = StreamProvider.autoDispose<bool>((ref) async* {
  final usernameController = ref.watch(usernameControllerProvider);

  if (usernameController.text.isNotEmpty) {
    yield await isUsernameAvailable(usernameController.text);
  }

  final stream = FirebaseFirestore.instance
      .collection("users")
      .where(DatabaseConst.username, isEqualTo: usernameController.text)
      .snapshots();

  await for (final snapshot in stream) {
    yield snapshot.docs.isEmpty;
  }
});

final usernameControllerProvider = Provider<TextEditingController>((ref) {
  return TextEditingController();
});

Future<bool> isUsernameAvailable(String username) async {
  // Implement your logic to check username availability here.
  // This can be a simple function that checks a local list or
  // makes a network request to validate the username.
  // Return true if the username is available, false otherwise.
  // For simplicity, you can return a hardcoded value here.
  return true;
}