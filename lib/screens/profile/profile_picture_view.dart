import 'dart:io';
import 'package:book_time/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:book_time/services/storage_service.dart';

class ProfilePictureView extends StatefulWidget {
  const ProfilePictureView({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfilePictureView> createState() => _ProfilePictureViewState();
}

class _ProfilePictureViewState extends State<ProfilePictureView> {
  uploadImg() async {
    final picked_img = await FilePicker.platform.pickFiles();
    var img_file = picked_img?.files[0];
    final File fileForFirebase = File(img_file!.path!);

    // Cheapest solution on refresh problem ever was putting a wait in seconds after uploading time.
    // But converting it the .then to solve it with the promise
    // guarantees the changes to occur whenever the operation is completed.
    StorageRepo().uploadFile(fileForFirebase).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    String? userId = AuthService().getUidofCurrentUser();
    return Center(
      child: StreamBuilder(
        stream: StorageRepo().getUserProfileImage(userId!).asStream(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return InkWell(
              onTap: () async {
                uploadImg();
              },
              child: Center(
                child: Card(
                  elevation: 5,
                  child: Container(
                    height: 280,
                    width: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(snapshot.data),
                        )),
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: InkWell(
                onTap: () async {
                  await uploadImg();
                },
                child: CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.grey[350],
                  child: Image.network(
                    "https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png",
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.width * 0.5,
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
