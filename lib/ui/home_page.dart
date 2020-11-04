part of 'pages.dart';

class HomePage extends StatefulWidget {
  final String name;
  HomePage({this.name});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        leadingWidth: size.width,
        backgroundColor: Colors.transparent,
        title: Container(
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
      ),
      body: ListView(
        children: [
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
                  child: ListView.builder(
                      itemCount: bookList.length,
                      itemBuilder: (context, index) {
                        final String bookTitle = bookList[index].bookTitle;
                        final String bookDesc = bookList[index].bookDesc;
                        final String photo = bookList[index].photo;
                        return BookCardItem(
                          bookDesc: bookDesc,
                          bookTitle: bookTitle,
                          photo: photo,
                        );
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
