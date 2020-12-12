part of 'widgets.dart';

File _image;

var firestore = FirebaseFirestore.instance;

class AddItemScreen extends StatefulWidget {
  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  TextEditingController titleController = TextEditingController();

  TextEditingController descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: kHorizontalMargin),
        width: size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.only(top: 28.0),
              child: Text(
                "Tambahkan Data Buku",
                style: kBlackTextStyle.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 40,
                bottom: 30,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                        child: _image != null
                            ? Image.asset(
                                _image.path,
                                height: 200,
                              )
                            : GestureDetector(
                                onTap: chooseFile,
                                child: Container(
                                  child: Text("Chooes image"),
                                ))),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: Column(
                        children: [
                          TextField(
                            controller: titleController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: "Nama buku",
                                hintText: "Nama buku"),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: descController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: "Deskripsi",
                                hintText: "Deskripsi"),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            CustomButton(
              title: "Tambahkan Data",
              onPressed: uploadFile,
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }

  Future chooseFile() async {
    try {
      await ImagePicker.pickImage(source: ImageSource.gallery).then((value) {
        setState(() {
          _image = value;
        });
      });
    } catch (e) {
      print(e);
    }
  }

  Future uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('books/${Path.basename(_image.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    storageReference.getDownloadURL().then((fileURL) {
      // print(url);
      addDatabase(titleController.text, descController.text, fileURL);
    });
  }

  Future addDatabase(String bookTitle, String bookDesc, String photo) async {
    CollectionReference books = firestore.collection('books');
    try {
      DocumentReference result = await books.add(<String, dynamic>{
        'bookDesc': bookDesc,
        'bookTitle': bookTitle,
        'photo': photo,
      });
      if (result.id != null) {
        _image = null;
        Navigator.pop(context);
      }
    } catch (e) {
      print(e);
    }
  }
}
