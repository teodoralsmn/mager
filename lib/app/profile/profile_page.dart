import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mager/app/profile/profile_form_page.dart';
import 'package:mager/shared/font_style.dart';
import 'package:mager/shared/providers/user_provider.dart';
import 'package:mager/shared/size_helper.dart';
import 'package:mager/shared/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Stack(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + margin16,
              bottom: 50,
            ),
            margin: const EdgeInsets.only(bottom: 100),
            decoration: const BoxDecoration(
                color: Color(0xff436edb),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50))),
            alignment: Alignment.center,
            child: Text(
              'Profile',
              style: mainBody1.copyWith(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Center(
              child: Column(
                children: [
                  Provider.of<UserProvider>(context, listen: false)
                              .data!
                              .profilePicture ==
                          null
                      ? Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).primaryColor),
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.account_circle,
                            color: Colors.white,
                            size: 60,
                          ),
                        )
                      : FutureBuilder(
                          future: FirebaseStorage.instance
                              .ref(
                                  'user_profile_picture/${Provider.of<UserProvider>(context, listen: false).data!.profilePicture}')
                              .getDownloadURL(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(snapshot.data!)),
                                    shape: BoxShape.circle,
                                    color: Colors.black12),
                              );
                            }
                            return Container(
                              width: 100,
                              height: 100,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black12),
                            );
                          }),
                  SizedBox(
                    height: margin8,
                  ),
                  Text(
                      Provider.of<UserProvider>(context, listen: false)
                          .data!
                          .name,
                      style: mainBodyFont(context, type: FontBodyType.body1)
                          .copyWith(fontWeight: FontWeight.bold))
                ],
              ),
            ),
          )
        ],
      ),
      Expanded(
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            padding: EdgeInsets.all(margin16),
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black26))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Email',
                  style: mainBodyFont(context)
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  Provider.of<UserProvider>(context, listen: false).data!.email,
                  style: mainBodyFont(context),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(margin16),
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black26))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Nomor Telepon',
                  style: mainBodyFont(context)
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  Provider.of<UserProvider>(context, listen: false)
                          .data!
                          .phone ??
                      'Phone is not set yet',
                  style: mainBodyFont(context,
                          textOpacity:
                              Provider.of<UserProvider>(context, listen: false)
                                          .data!
                                          .phone ==
                                      null
                                  ? 0.5
                                  : 1)
                      .copyWith(
                          fontStyle:
                              Provider.of<UserProvider>(context, listen: false)
                                          .data!
                                          .phone ==
                                      null
                                  ? FontStyle.italic
                                  : FontStyle.normal),
                ),
              ],
            ),
          ),
          SizedBox(
            height: margin32,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: margin16),
            child: CustomButton(
              title: 'Update Profile',
              onTap: () async {
                bool? result = await Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const ProfileFormPage()));

                if (result != null) {
                  setState(() {});
                }
              },
            ),
          )
        ],
      ))
    ]);
  }
}
