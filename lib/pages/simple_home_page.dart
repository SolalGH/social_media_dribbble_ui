import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:link_ui_sandbox/components/my_expand_button.dart';
import 'package:link_ui_sandbox/components/my_simple_like_button.dart';
import 'package:link_ui_sandbox/components/my_simple_post%20copy.dart';

class SimpleHomePage extends StatelessWidget {
  const SimpleHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.025,
            ),
            child: Column(
              children: [
                // Appbar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Bouton de profil
                    Container(
                      width: MediaQuery.of(context).size.height * 0.065,
                      height: MediaQuery.of(context).size.height * 0.065,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.0),
                        color: Colors.white,
                      ),
                      margin: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.0250,
                      ),
                      child: Center(
                        child: Icon(
                          CupertinoIcons.person,
                          size: MediaQuery.of(context).size.height * 0.03,
                        ),
                      ),
                    ),

                    Row(
                      children: [
                        // Bouton de recherche (de compte)
                        Container(
                          width: MediaQuery.of(context).size.height * 0.065,
                          height: MediaQuery.of(context).size.height * 0.065,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                            color: Colors.white,
                          ),
                          margin: EdgeInsets.symmetric(
                            vertical:
                                MediaQuery.of(context).size.height * 0.0250,
                          ),
                          child: Center(
                            child: Icon(
                              CupertinoIcons.search,
                              size: MediaQuery.of(context).size.height * 0.03,
                            ),
                          ),
                        ),

                        Gap(MediaQuery.of(context).size.width * 0.025),

                        // Bouton de réglages
                        Container(
                          width: MediaQuery.of(context).size.height * 0.065,
                          height: MediaQuery.of(context).size.height * 0.065,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                            color: Colors.white,
                          ),
                          margin: EdgeInsets.symmetric(
                            vertical:
                                MediaQuery.of(context).size.height * 0.0250,
                          ),
                          child: Center(
                            child: Icon(
                              CupertinoIcons.settings,
                              size: MediaQuery.of(context).size.height * 0.03,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                Gap(MediaQuery.of(context).size.height * 0.0125),

                Expanded(
                  child: Stack(
                    children: [
                      // Message plus de posts (en dessous des tous les posts ce qui le rend visible seulement quand il n'y en a plus)
                      Center(
                        child: Text(
                          "Plus de posts ...",
                          style: GoogleFonts.kanit(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // Posts
                      Stack(
                        children: List.generate(
                          300,
                          (index) {
                            return MySimplePost(stackIndex: 299 - index);
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        // Bouton de like
                        const MySimpleLikeButton(),

                        Gap(MediaQuery.of(context).size.width * 0.025),

                        // Bouton d'accès au profil de l'utilisateur
                        Container(
                          width: MediaQuery.of(context).size.height * 0.065,
                          height: MediaQuery.of(context).size.height * 0.065,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                            color: Colors.white,
                          ),
                          margin: EdgeInsets.symmetric(
                            vertical:
                                MediaQuery.of(context).size.height * 0.0250,
                          ),
                          child: Center(
                            child: Icon(
                              CupertinoIcons.chat_bubble,
                              size: MediaQuery.of(context).size.height * 0.03,
                            ),
                          ),
                        ),

                        Gap(MediaQuery.of(context).size.width * 0.025),

                        // Bouton expand
                        const MyExpandButton(),
                      ],
                    ),

                    // Bouton d'accès au profil de l'utilisateur
                    Container(
                      width: MediaQuery.of(context).size.height * 0.065,
                      height: MediaQuery.of(context).size.height * 0.065,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.0),
                        color: Colors.white,
                      ),
                      margin: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.0250,
                      ),
                      child: Center(
                        child: Icon(
                          CupertinoIcons.add,
                          size: MediaQuery.of(context).size.height * 0.03,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
