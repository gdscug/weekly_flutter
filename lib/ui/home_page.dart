part of 'pages.dart';

class HomePage extends StatefulWidget {
  final String name;
  HomePage({this.name});

  @override
  _HomePageState createState() => _HomePageState();
}

final firestore = FirebaseFirestore.instance;

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 100,
            width: size.width,
            margin: EdgeInsets.only(bottom: 15),
            padding: EdgeInsets.symmetric(
              horizontal: 29,
              vertical: 21,
            ),
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/profile.jpg"),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(360.0)),
                ),
                SizedBox(
                  width: 14,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome!",
                        style: kWhiteTextStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.name,
                        style: kWhiteTextStyle.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Daftar Buku",
                  style: kBlackTextStyle.copyWith(
                      fontSize: 20, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  width: size.width,
                  height: size.height - 100,
                  child: StreamBuilder<QuerySnapshot>(
                      stream: firestore.collection('books').snapshots(),
                      builder: (context, snapshot) {
                        return !snapshot.hasData
                            ? Center(
                                child: Text("Waiting..."),
                              )
                            : ListView.builder(
                                itemCount: snapshot.data.docs.length,
                                itemBuilder: (context, index) {
                                  DocumentSnapshot books =
                                      snapshot.data.docs[index];
                                  final String bookTitle =
                                      books.get('bookTitle');
                                  final String bookDesc = books.get('bookDesc');
                                  final String photo = books.get('photo');
                                  return Dismissible(
                                    key: new Key(bookTitle),
                                    onDismissed: (direction) {
                                      firestore
                                          .collection('books')
                                          .doc(books.id)
                                          .delete();
                                    },
                                    child: BookCardItem(
                                      bookDesc: bookDesc,
                                      bookTitle: bookTitle,
                                      photo: photo,
                                    ),
                                  );
                                });
                      }),
                )
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Todo: add bottom sheet
          showModalBottomSheet(
            context: context,
            builder: (context) => SingleChildScrollView(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: AddItemScreen(),
            ),
          );
          // Navigator.of(context)
          //     .push(MaterialPageRoute(builder: (context) => ExamplePage()));
          // Navigator.of(context)
          //     .push(MaterialPageRoute(builder: (context) => AddItemScreen()));
        },
        backgroundColor: Colors.white,
        child: Icon(
          Icons.add,
          size: 30,
          color: Colors.black,
        ),
      ),
    );
  }
}
