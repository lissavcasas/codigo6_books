import 'package:codigo6_books/db/db_admin.dart';
import 'package:codigo6_books/models/book_model.dart';
import 'package:codigo6_books/widgets/common_textfield_widget.dart';
import 'package:flutter/material.dart';

class FormBookModal extends StatefulWidget {
  final BookModel? book;
  final bool isRegister;

  const FormBookModal({
    super.key,
    this.book,
    required this.isRegister,
  });

  @override
  State<FormBookModal> createState() => _FormBookModalState();
}

class _FormBookModalState extends State<FormBookModal> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final _myFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (!widget.isRegister) {
      _titleController.text = widget.book!.title;
      _authorController.text = widget.book!.author;
      _imageController.text = widget.book!.image;
      _descriptionController.text = widget.book!.description;
    }
  }

  void saveBook() {
    if (_myFormKey.currentState!.validate()) {
      //Registrar un libro
      // String title = _titleController.text;
      // String author = _authorController.text;
      // String image = _imageController.text;
      // String description = _descriptionController.text;
      // DBAdmin().insertBook(title, author, description, image);

      // Map<String, dynamic> bookMap = {
      //   "image": _imageController.text,
      //   "title": _titleController.text,
      //   "description": _descriptionController.text,
      //   "author": _authorController.text,
      // };

      // DBAdmin().insertBook(bookMap);

      BookModel myBook = BookModel(
        title: _titleController.text,
        author: _authorController.text,
        image: _imageController.text,
        description: _descriptionController.text,
      );

      if (widget.isRegister) {
        DBAdmin().insertBook(myBook).then((mandarina) {
          if (mandarina >= 0) {
            //Se agregó el libro correctamente
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: const Color(0xff06d6a0),
                duration: const Duration(seconds: 5),
                behavior: SnackBarBehavior.floating,
                // padding: EdgeInsets.all(12.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                content: Row(
                  children: const [
                    Icon(Icons.check, color: Colors.white),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Text(
                        "El libro se registró correctamente.",
                      ),
                    ),
                  ],
                ),
              ),
            );
            Navigator.pop(context);
          } else {}
        }).catchError((error) {
          // print(error);
        });
      } else {
        myBook.id = widget.book!.id;
        DBAdmin().updateBook(myBook).then((mandarina) {
          if (mandarina >= 0) {
            //Se agregó el libro correctamente
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: const Color(0xff06d6a0),
                duration: const Duration(seconds: 5),
                behavior: SnackBarBehavior.floating,
                // padding: EdgeInsets.all(12.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                content: Row(
                  children: const [
                    Icon(Icons.check, color: Colors.white),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Text(
                        "El libro se actualizó correctamente.",
                      ),
                    ),
                  ],
                ),
              ),
            );
            Navigator.pop(context);
          } else {}
        }).catchError(
          (error) {
            //  print(error);
          },
        );
        //Actualizar un libro...

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.book!.title);
    // print(widget.isRegister);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(36.0),
          topRight: Radius.circular(36.0),
        ),
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: _myFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.isRegister ? "Agregar libro" : "Actualizar libro",
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              CommonTextFieldWidget(
                hintText: "Ingresa un título",
                icon: Icons.rocket,
                label: "Título",
                controller: _titleController,
              ),
              CommonTextFieldWidget(
                hintText: "Ingresa un autor",
                icon: Icons.person,
                label: "Autor",
                controller: _authorController,
              ),
              CommonTextFieldWidget(
                hintText: "Ingresa el url de la portada",
                icon: Icons.image,
                label: "Portadaaaa",
                controller: _imageController,
              ),
              CommonTextFieldWidget(
                hintText: "Ingresa una descripción",
                icon: Icons.view_headline,
                label: "Descripción",
                maxLines: 4,
                controller: _descriptionController,
              ),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: double.infinity,
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () {
                    saveBook();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff22223b),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                  ),
                  child: Text(
                    widget.isRegister ? "Agregar" : "Actualizar",
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
