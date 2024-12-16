// ignore_for_file: avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';

class TokobukuService {
  static CollectionReference productCollection =
      FirebaseFirestore.instance.collection('product');

  // Create or update a product
  static Future<void> createOrUpdateProduct(
    String penulis,
    String judul,
    DateTime rilis,
    int price,
    String imageUrl, {
    String? id,
  }) async {
    try {
      if (id == null) {
        // Create new product
        await productCollection.add({
          'penulis': penulis,
          'judul': judul,
          'rilis': Timestamp.fromDate(rilis),
          'price': price,
          'imageUrl': imageUrl,
        });
      } else {
        // Update existing product
        await productCollection.doc(id).update({
          'penulis': penulis,
          'judul': judul,
          'rilis': Timestamp.fromDate(rilis),
          'price': price,
          'imageUrl': imageUrl,
        });
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  // Fetch all products
  static Stream<List<Map<String, dynamic>>> getProducts() {
    return productCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {
          'id': doc.id,
          ...data,
        };
      }).toList();
    });
  }

  // Delete product
  static Future<void> deleteProduct(String id) async {
    try {
      await productCollection.doc(id).delete();
    } catch (e) {
      print("Error saat menghapus produk: $e");
    }
  }
}
