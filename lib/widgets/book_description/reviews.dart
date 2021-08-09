import 'package:books_app/providers/user.dart';
import 'package:books_app/services/auth.dart';
import 'package:books_app/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Reviews extends StatefulWidget {
  @override
  _ReviewsState createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: AuthService().getUID).userData,
      builder: (BuildContext ctx, AsyncSnapshot<UserData> snap) {
        if (snap.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Reviews',
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 20),
              ),
              AspectRatio(
                aspectRatio: 343 / 52,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextField(
                    controller: _commentController,
                    maxLines: 5,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                        prefixIcon: CircleAvatar(
                          radius: 5,
                          backgroundImage: NetworkImage(snap.data.photoURL),
                        ),
                        suffixIcon: const Icon(Icons.send),
                        hintText: 'Add your comment',
                        hintStyle: GoogleFonts.muli(
                          color: Colors.grey,
                          fontSize: 14,
                        )),
                    onSubmitted: (String value) {
                      setState(() {
                        _commentController.text = value;
                      });
                    },
                  ),
                ),
              ),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
//  value: DatabaseService(uid: AuthService().getUID).userData,
    );
  }
}
