import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:link_ui_sandbox/components/my_simple_post%20copy.dart';
import 'package:link_ui_sandbox/utilities/my_provider.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.025,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Posts
              Expanded(
                child: Stack(
                  children: List.generate(
                    300,
                    (index) {
                      return MySimplePost(stackIndex: 299 - index);
                    },
                  ),
                ),
              ),

              Row(
                children: [
                  // Bouton de like
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
                        CupertinoIcons.heart,
                        size: MediaQuery.of(context).size.height * 0.03,
                      ),
                    ),
                  ),

                  Gap(MediaQuery.of(context).size.width * 0.025),

                  // Bouton de like
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

                  Gap(MediaQuery.of(context).size.width * 0.025),

                  // Bouton déployer / refermer
                  GestureDetector(
                    onTap: () {
                      Provider.of<MyProvider>(context, listen: false)
                          .addValue("deploy");
                    },
                    child: Container(
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
                          CupertinoIcons.arrow_up,
                          size: MediaQuery.of(context).size.height * 0.03,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
