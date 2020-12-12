part of 'widgets.dart';

class BookCardItem extends StatelessWidget {
  final String photo;
  final String bookTitle;
  final String bookDesc;

  BookCardItem(
      {@required this.photo,
      @required this.bookDesc,
      @required this.bookTitle});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          border: Border.all(color: kPrimaryColor),
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(12.0),
              topRight: Radius.circular(45.0),
              bottomLeft: Radius.circular(46.0)),
          color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Image.network(
              photo,
              height: 75,
              width: 53,
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bookTitle,
                  style: kBlackTextStyle.copyWith(fontSize: 15.0),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  bookDesc,
                  style: kBlackTextStyle.copyWith(
                    fontSize: 8,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
