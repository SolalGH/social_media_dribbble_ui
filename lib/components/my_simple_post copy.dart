import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:link_ui_sandbox/components/my_profile_picture.dart';
import 'package:link_ui_sandbox/utilities/my_provider.dart';
import 'package:provider/provider.dart';

class MySimplePost extends StatefulWidget {
  int stackIndex;
  MySimplePost({
    super.key,
    required this.stackIndex,
  });

  @override
  State<MySimplePost> createState() => _MySimplePostState();
}

class _MySimplePostState extends State<MySimplePost>
    with TickerProviderStateMixin {
  double _width = 0.0;
  double _height = 0.0;
  double _position = 0.0;

  final ScrollController _scrollController = ScrollController();
  bool _isScrollable = false;

  late double _angle;
  late double _scale;
  late double _endAngle;
  late double _endScale;
  late double _opacity;

  late AnimationController _angleAnimationController;
  late AnimationController _scaleAnimationController;
  late Animation<double> _angleAnimation;
  late Animation<double> _scaleAnimation;

  double? _fingerYLocation;

  late StreamSubscription<String> _stream;

  void notifyOthers(context) {
    Provider.of<MyProvider>(context, listen: false).addValue("slide");
  }

  void slide() {
    if (widget.stackIndex == 0) {
      // Index
      widget.stackIndex = -1;

      // Angle
      _angleAnimationController.reset();
      _endAngle = -pi * 0.25;
      _angleAnimation = Tween<double>(begin: _angle, end: _endAngle)
          .animate(_angleAnimationController)
        ..addListener(() {
          setState(() {});
        });
      _angleAnimationController.forward();

      // Position
      _position = -MediaQuery.of(context).size.height * 0.5;
    } else if (widget.stackIndex == 1) {
      // Index
      widget.stackIndex = 0;

      // Angle
      _angleAnimationController.reset();
      _endAngle = 0;
      _angleAnimation = Tween<double>(begin: _angle, end: _endAngle)
          .animate(_angleAnimationController)
        ..addListener(() {
          setState(() {});
        });
      _angleAnimationController.forward();

      // Scale
      _scaleAnimationController.reset();
      _endScale = 1;
      _scaleAnimation = Tween<double>(begin: _scale, end: _endScale)
          .animate(_scaleAnimationController)
        ..addListener(() {
          setState(() {});
        });
      _scaleAnimationController.forward();

      // Opacity
      _opacity = 1;

      // Position
      _position = 0;
    } else if (widget.stackIndex == 2) {
      // Index
      widget.stackIndex = 1;

      // Angle
      _angleAnimationController.reset();
      _endAngle = -pi * 0.025;
      _angleAnimation = Tween<double>(begin: _angle, end: _endAngle)
          .animate(_angleAnimationController)
        ..addListener(() {
          setState(() {});
        });
      _angleAnimationController.forward();

      // Scale
      _scaleAnimationController.reset();
      _endScale = 0.9;
      _scaleAnimation = Tween<double>(begin: _scale, end: _endScale)
          .animate(_scaleAnimationController)
        ..addListener(() {
          setState(() {});
        });
      _scaleAnimationController.forward();

      // Opacity
      _opacity = 0.8;

      // Position
      _position = MediaQuery.of(context).size.height * 0.075;
    } else if (widget.stackIndex == 3) {
      // Index
      widget.stackIndex = 2;

      // Angle
      _angleAnimationController.reset();
      _endAngle = pi * 0.025;
      _angleAnimation = Tween<double>(begin: _angle, end: _endAngle)
          .animate(_angleAnimationController)
        ..addListener(() {
          setState(() {});
        });
      _angleAnimationController.forward();

      // Scale
      _scaleAnimationController.reset();
      _endScale = 0.8;
      _scaleAnimation = Tween<double>(begin: _scale, end: _endScale)
          .animate(_scaleAnimationController)
        ..addListener(() {
          setState(() {});
        });
      _scaleAnimationController.forward();

      // Opacity
      _opacity = 0.6;

      // Position
      _position = MediaQuery.of(context).size.height * 0.075 * 2;
    } else {
      // Index
      widget.stackIndex--;
    }
  }

  @override
  void initState() {
    _angle = widget.stackIndex == 1
        ? -pi * 0.025
        : widget.stackIndex == 2
            ? pi * 0.025
            : 0;
    _endAngle = _angle;
    _scale = widget.stackIndex == 0
        ? 1
        : widget.stackIndex == 1
            ? 0.9
            : 0.8;
    _endScale = _scale;
    _opacity = widget.stackIndex == 0
        ? 1
        : widget.stackIndex == 1
            ? 0.8
            : widget.stackIndex == 2
                ? 0.6
                : 0;

    _scaleAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: _scale, end: _endScale)
        .animate(_scaleAnimationController)
      ..addListener(() {
        if (_scaleAnimation.isCompleted) {
          _scale = _endScale;
        }
        setState(() {});
      });

    _angleAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _angleAnimation = Tween<double>(begin: _angle, end: _endAngle)
        .animate(_angleAnimationController)
      ..addListener(() {
        if (_angleAnimationController.isCompleted) {
          _angle = _endAngle;
        }
        setState(() {});
      });

    _stream = Provider.of<MyProvider>(context, listen: false).stream.listen(
      (String data) {
        if (data == "slide") {
          slide();
        } else if (data == "expand") {
          if (widget.stackIndex == 0) {
            if (_height == MediaQuery.of(context).size.height * 0.4) {
              setState(() {
                _height = MediaQuery.of(context).size.height * 0.7;
                _isScrollable = true;
              });
            } else {
              setState(() {
                _height = MediaQuery.of(context).size.height * 0.4;
                _isScrollable = false;
                _scrollController.animateTo(0,
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.linear);
              });
            }
          }
        } else {}
      },
    );

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        setState(() {
          _width = MediaQuery.of(context).size.width * 0.95;
          _height = MediaQuery.of(context).size.height * 0.4;
          _position = widget.stackIndex >= 3
              ? MediaQuery.of(context).size.height * 0.075 * 3
              : MediaQuery.of(context).size.height * 0.075 * widget.stackIndex;
        });
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _stream.cancel();
    _angleAnimationController.dispose();
    _scaleAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 500),
      bottom: _position,
      child: Transform.rotate(
        angle: _angleAnimation.value,
        child: Transform.scale(
          scale: _scaleAnimation.value,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity: _opacity,
            child: GestureDetector(
              onPanDown: (details) {
                _fingerYLocation = details.globalPosition.dy;
              },
              onPanEnd: (details) {
                if (_height != MediaQuery.of(context).size.height * 0.8) {
                  if ((details.globalPosition.dy - 75) > _fingerYLocation!) {
                    // Slide
                    notifyOthers(context);
                  }
                }
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: _width,
                  height: _height,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.width * 0.025,
                      left: MediaQuery.of(context).size.width * 0.025,
                      right: MediaQuery.of(context).size.width * 0.025,
                    ),
                    child: SingleChildScrollView(
                      physics: _isScrollable
                          ? null
                          : const NeverScrollableScrollPhysics(),
                      controller: _scrollController,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  MyProfilePicture(
                                    size: 60,
                                    color: Colors.grey[100],
                                  ),
                                  Gap(MediaQuery.of(context).size.width *
                                      0.025),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "@username",
                                        style: GoogleFonts.kanit(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        "Lieu du post",
                                        style: GoogleFonts.kanit(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ],
                          ),

                          Gap(MediaQuery.of(context).size.height * 0.025),

                          // Contenu du post
                          Container(
                            width: MediaQuery.of(context).size.width * 0.925,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.width * 0.0125),
                            child: Text(
                              "qdfsdf jd jfoidj fsoijdfsoidjfsoifj soid fsoid foisd jfiosjf dosijd osijf soidf siod sifioj io iid isf odj sifj ",
                              style: GoogleFonts.kanit(
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),

                          Gap(MediaQuery.of(context).size.height * 0.025),

                          // Images
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: InstaImageViewer(
                              child: CachedNetworkImage(
                                imageUrl:
                                    "https://images2.giant-bicycles.com/b_white%2Cc_pad%2Ch_1000%2Cq_80%2Cw_1920/fdu0z1q5akoeefrodgt2/lp_glory_adv_banner_d.jpg",
                              ),
                            ),
                          ),
                          Gap(MediaQuery.of(context).size.height * 0.0125),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: InstaImageViewer(
                              child: CachedNetworkImage(
                                imageUrl:
                                    "https://images2.giant-bicycles.com/b_white%2Cc_pad%2Ch_1000%2Cq_80%2Cw_1920/fdu0z1q5akoeefrodgt2/lp_glory_adv_banner_d.jpg",
                              ),
                            ),
                          ),
                          Gap(MediaQuery.of(context).size.height * 0.0125),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: InstaImageViewer(
                              child: CachedNetworkImage(
                                imageUrl:
                                    "https://images2.giant-bicycles.com/b_white%2Cc_pad%2Ch_1000%2Cq_80%2Cw_1920/fdu0z1q5akoeefrodgt2/lp_glory_adv_banner_d.jpg",
                              ),
                            ),
                          ),

                          Gap(MediaQuery.of(context).size.height * 0.0125),

                          // Date du post
                          Text(
                            "31/07/2024",
                            style: GoogleFonts.kanit(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
