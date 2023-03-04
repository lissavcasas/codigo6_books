import 'dart:math';

import 'package:codigo6_books/db/db_admin.dart';
import 'package:codigo6_books/models/book_model.dart';
import 'package:codigo6_books/pages/modals/form_book_modal.dart';
import 'package:codigo6_books/widgets/item_home_widget.dart';
import 'package:codigo6_books/widgets/item_slider_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BookModel? booKTemp;
  bool isRegister = true;

  showFormBook() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: FormBookModal(
            book: booKTemp,
            isRegister: isRegister,
          ),
        );
      },
    ).then((value) {
      setState(() {});
    });
  }

  showDeleteDialog(int idBook) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Atención"),
              const SizedBox(
                height: 8.0,
              ),
              const Text("¿Deseas eliminar este libro?"),
              const SizedBox(
                height: 12.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Cancelar",
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 6.0,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        DBAdmin().deleteBook(idBook).then((value) {
                          if (value >= 0) {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "El libro se eliminó correctamente",
                                ),
                              ),
                            );
                            setState(() {});
                            //SnackBar
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff22223b),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                      ),
                      child: const Text(
                        "Aceptar",
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double pyth = sqrt(pow(height, 2) + pow(width, 2));

    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () {
          isRegister = true;
          showFormBook();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8.0),
          decoration: BoxDecoration(
            color: const Color(0xff22223b),
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.add,
                color: Colors.white,
              ),
              Text(
                "Agregar",
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: pyth * 0.42,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    "https://images.pexels.com/photos/14454202/pexels-photo-14454202.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                  ),
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    Container(
                      width: pyth * 0.35,
                      padding: const EdgeInsets.symmetric(
                        vertical: 12.0,
                      ),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 14.0,
                            offset: const Offset(4, 4),
                          ),
                        ],
                      ),
                      child: TextField(
                        style: const TextStyle(
                          fontSize: 14.0,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Buscar libro...",
                          hintStyle: const TextStyle(
                            fontSize: 14.0,
                          ),
                          suffixIcon: const Icon(
                            Icons.search,
                            size: 19.0,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(22.0),
                      child: Row(
                        children: const [
                          Text(
                            "Guarda \ntus libros \nfavoritos.",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 36.0,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            FutureBuilder(
              future: DBAdmin().getBooks(),
              builder: (BuildContext context, AsyncSnapshot snap) {
                if (snap.hasData) {
                  List<BookModel> myBooks = snap.data;
                  return myBooks.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 8.0,
                              ),
                              const Text(
                                "Mis libros favoritos",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                child: Row(
                                  children: myBooks
                                      .map((mandarina) => ItemSliderWidget(
                                            book: mandarina,
                                          ))
                                      .toList(),
                                ),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              const Text(
                                "Lista general",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              ListView.builder(
                                itemCount: myBooks.length,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return ItemHomeWidget(
                                    book: myBooks[index],
                                    onDelete: () {
                                      showDeleteDialog(myBooks[index].id!);
                                    },
                                    onUpdate: () {
                                      booKTemp = myBooks[index];
                                      isRegister = false;
                                      showFormBook();
                                      // print(myBooks[index].toJson());
                                    },
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 40.0,
                              ),
                            ],
                          ),
                        )
                      : Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/images/box.png",
                                  height: pyth * 0.1,
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                const Text(
                                    "Por favor registra tu primer libro.")
                              ],
                            ),
                          ),
                        );
                }
                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}
