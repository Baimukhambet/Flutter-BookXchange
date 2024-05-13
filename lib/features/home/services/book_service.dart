import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cubit_test/features/auth/services/auth_service.dart';
import 'package:cubit_test/repositories/models/book.dart';

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

  //giving book
  //getting book
  //date time
  //creator

  Future<void> addOrder(Book giveBook, List<Book> getBook) async {
    try {
      await _firestore.collection('orders').doc().set({
        'user_id': authService.getCurrentUser()!.uid,
        'giving': giveBook.name,
        'taking': getBook.map((e) => {
              'title': e.name,
              'imageUrl': e.imageUrl,
            }),
        'givingImageUrl': giveBook.imageUrl,
        'date': DateTime.now().toString()
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
