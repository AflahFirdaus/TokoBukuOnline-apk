import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tokobukuonline_apk/services/tokobuku_service.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final TextEditingController _penulisController = TextEditingController();
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  DateTime? _selectedDate;

  String? _editingProductId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin - Produk Toko Buku"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _penulisController,
              decoration: const InputDecoration(labelText: "Penulis"),
            ),
            TextField(
              controller: _judulController,
              decoration: const InputDecoration(labelText: "Judul"),
            ),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: "Harga"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _imageUrlController,
              decoration: const InputDecoration(labelText: "URL Gambar"),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  _selectedDate == null
                      ? "Tanggal Rilis: Belum Dipilih"
                      : "Tanggal Rilis: ${_selectedDate!.toLocal()}"
                          .split(' ')[0],
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _selectedDate = pickedDate;
                      });
                    }
                  },
                  child: const Text("Pilih Tanggal"),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                if (_penulisController.text.isNotEmpty &&
                    _judulController.text.isNotEmpty &&
                    _priceController.text.isNotEmpty &&
                    _imageUrlController.text.isNotEmpty &&
                    _selectedDate != null) {
                  try {
                    await TokobukuService.createOrUpdateProduct(
                      _penulisController.text,
                      _judulController.text,
                      _selectedDate!,
                      int.parse(_priceController.text),
                      _imageUrlController.text,
                      id: _editingProductId,
                    );
                    _resetForm();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(_editingProductId == null
                            ? "Produk berhasil ditambahkan!"
                            : "Produk berhasil diperbarui!"),
                      ),
                    );
                  } catch (e) {
                    print("Error: $e");
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Terjadi kesalahan saat menyimpan!")),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Mohon isi semua field!")),
                  );
                }
              },
              child: Text(_editingProductId == null
                  ? "Simpan Produk"
                  : "Update Produk"),
            ),
            const SizedBox(height: 32),
            const Text(
              "Daftar Produk",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: StreamBuilder<List<Map<String, dynamic>>>(
                stream: TokobukuService.getProducts(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                        child: Text("Error saat mengambil data"));
                  }
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final products = snapshot.data!;
                  if (products.isEmpty) {
                    return const Text("Belum ada produk.");
                  }
                  return ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return Card(
                        child: ListTile(
                          leading: Image.network(
                            product['imageUrl'],
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.error),
                          ),
                          title: Text(product['judul']),
                          subtitle: Text(
                            "Penulis: ${product['penulis']}\nHarga: ${product['price']} \nRilis: ${DateFormat('dd MMM yyyy').format((product['rilis'] as Timestamp).toDate())}",
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon:
                                    const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () {
                                  setState(() {
                                    _editingProductId = product['id'];
                                    _penulisController.text =
                                        product['penulis'];
                                    _judulController.text = product['judul'];
                                    _priceController.text =
                                        product['price'].toString();
                                    _imageUrlController.text =
                                        product['imageUrl'];
                                    _selectedDate =
                                        (product['rilis'] as Timestamp)
                                            .toDate();
                                  });
                                },
                              ),
                              IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => TokobukuService.deleteProduct(
                                    product['id']),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _resetForm() {
    _penulisController.clear();
    _judulController.clear();
    _priceController.clear();
    _imageUrlController.clear();
    setState(() {
      _selectedDate = null;
      _editingProductId = null;
    });
  }
}
