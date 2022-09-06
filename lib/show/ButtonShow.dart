import 'package:flutter/material.dart';

void ShowBotton( BuildContext context,var _height) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20.0),
            ),
            SizedBox(
              height: _height * 0.5,
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 20.0),
                  ),
                  const Text("  Share to",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  const Padding(
                    padding: EdgeInsets.only(top: 20.0),
                  ),
                  Row(children: [
                    icon('assets/images/f.png'),
                    Spacer(),
                    icon('assets/images/gmail.png'),
                    Spacer(),
                    icon('assets/images/ins.png'),
                    Spacer(),
                    icon('assets/images/pin.png'),
                    Spacer(),
                    icon('assets/images/whatsapp.png'),
                  ]),
                  const Padding(
                    padding: EdgeInsets.only(top: 20.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Container(
                      height: 0.3,
                      width: double.infinity,
                      color: Colors.white,
                    ),
                  ),
                  text("Download image"),
                  text("Hide Pin"),
                  text("Report Pin"),
                  const Padding(
                    padding: EdgeInsets.only(top: 20.0),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Container(
                      height: 0.3,
                      width: double.infinity,
                      color: Colors.white,
                    ),
                  ),
                  text("This Pin was inspired by your recent activity ")
                ],
              ),
            )
          ],
        );
      });
}

Widget icon(String url) {
  return GestureDetector(
    child: Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: ExactAssetImage(url), fit: BoxFit.fill),
        shape: BoxShape.circle,
      ),
      width: 30,
      height: 30,
    ),
    onTap: () {},
  );
}

Widget text(String text) {
  return Column(children: [
    const Padding(
      padding: EdgeInsets.only(top: 20.0),
    ),
    Text(text, style: const TextStyle(color: Colors.white, fontSize: 15.0)),
  ]);
}
