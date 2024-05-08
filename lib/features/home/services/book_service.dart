import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cubit_test/features/auth/services/auth_service.dart';

class BookService {
  static final BookService shared = BookService._instance();
  BookService._instance();
  AuthService authService = AuthService.shared;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // book name
  // book name
  // category
  // date time
  // creator
  Future<void> addOrder(String getBookName, String giveBookName) async {
    try {
      await _firestore.collection('orders').doc().set({
        'user_id': authService.getCurrentUser()!.uid,
        'giving': giveBookName,
        'taking': getBookName,
        'date': DateTime.now().toString()
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
