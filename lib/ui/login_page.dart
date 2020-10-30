part of 'pages.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController nameEditingController = TextEditingController();
  final TextEditingController passwordEditingController =
      TextEditingController();

  final String name = "Kleyy";
  final String password = "togetherwegrow";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: kHorizontalMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.only(top: 81, bottom: 17),
              child: Image(
                width: size.width / 2,
                height: size.height / 5,
                image: AssetImage("assets/logo.png"),
              ),
            ),
            Text(
              "DSC Flutter Weekly",
              textAlign: TextAlign.center,
              style: kBlackTextStyle.copyWith(
                  fontWeight: FontWeight.bold, fontSize: 24.0),
            ),
            SizedBox(
              height: 42.0,
            ),
            TextField(
              controller: nameEditingController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: "Name",
                  hintText: "Name"),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: passwordEditingController,
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: "Password",
                  hintText: "Password"),
            ),
            SizedBox(
              height: 40.0,
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              onPressed: () {
                if (nameEditingController.text != null &&
                    passwordEditingController.text != null) {
                  if (nameEditingController.text == name &&
                      passwordEditingController.text == password) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(
                          name: name,
                        ),
                      ),
                    );
                  }
                }
              },
              color: kAccentColor1,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Login",
                  style: kWhiteTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
