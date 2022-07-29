import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatefulWidget {
  final Widget body;
  final double? spaceFromRight;
  final double? spaceFromBottom;
  final Widget openFloatingActionButton;
  final Widget closeFloatingActionButton;
  final CustomFloatingActionButtonType type;
  final bool? barrierDismissible;
  final List<Widget>? options;
  final Color? backgroundColor;
  final Color? floatinButtonColor;

  const CustomFloatingActionButton({
    Key? key,
    required this.body,
    required this.openFloatingActionButton,
    required this.closeFloatingActionButton,
    this.barrierDismissible = true,
    this.type = CustomFloatingActionButtonType.circular,
    this.spaceFromRight = 10,
    this.spaceFromBottom = 100,
    this.backgroundColor = Colors.black54,
    this.floatinButtonColor = Colors.white,
    this.options,
  }) : super(key: key);

  @override
  State<CustomFloatingActionButton> createState() =>
      _CustomFloatingActionButtonState();
}

class _CustomFloatingActionButtonState
    extends State<CustomFloatingActionButton> {
  GlobalKey key = GlobalKey();
  int count = 0;

  //positions
  double firstItemX = 0;
  double firstItemY = 0;
  double secondItemX = 0;
  double secondItemY = 0;
  double thirdItemX = 0;
  double thirdItemY = 0;
  double fourthItemX = 0;
  double fourthItemY = 0;
  double fifthItemX = 0;
  double fifthItemY = 0;

  //circular positions
  double topPositionY = 160;
  double topPositionX = 15;
  double bottomPositionY = 50;
  double bottomPositionX = 15;
  double centerRightX = 75;
  double centerRightY = 105;
  double bottomCenterY = 60;
  double bottomCenterX = 60;
  double topCenterY = 150;
  double topCenterX = 60;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      count = widget.options != null ? widget.options!.length : 0;
      bottomCenterY = count == 4 ? 75 : 60;
      bottomCenterX = count == 4 ? 65 : 60;
      topCenterY = count == 4 ? 135 : 150;
      topCenterX = count == 4 ? 65 : 60;
    });
  }

  getPosition() {
    RenderBox box = key.currentContext!.findRenderObject() as RenderBox;
    Offset position = box.localToGlobal(Offset.zero); //this is global position
    // ignore: unused_local_variable
    double y = position.dy;
    // ignore: unused_local_variable
    double x = position.dx;
  
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.body,
        Positioned(
          key: key,
          bottom: widget.spaceFromBottom ?? 100,
          right: widget.spaceFromRight ?? 10,
          child: GestureDetector(
            onTap: () {
              if (widget.spaceFromRight! > 50 ||
                  widget.spaceFromBottom! > 500) {
                throw "maximum space from bottom is 500 and maximum space from right is 50";
              } else {
                if (widget.options != null &&
                    widget.options!.length > 1 &&
                    widget.options!.length < 6) {
                  _fabDialog();
                } else {
                  throw "minimum 2 and maximum 5 items allowed";
                }
              }
            },
            child: Container(
              height: 55,
              width: 55,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.floatinButtonColor ?? Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 1,
                  ),
                ],
              ),
              child: widget.openFloatingActionButton,
            ),
          ),
        ),
      ],
    );
  }

  _fabDialog() {
    // getPosition();
    getItemPositions();
    showDialog(
      barrierDismissible: widget.barrierDismissible ?? true,
      useSafeArea: false,
      barrierColor: widget.backgroundColor,
      context: context,
      builder: (context) {
        return _showOptions();
      },
    );
  }

  getItemPositions() {
    if (widget.type == CustomFloatingActionButtonType.horizontal) {
      firstItemX = widget.spaceFromRight! + 60;
      firstItemY = widget.spaceFromBottom! + 5;
      secondItemX = widget.spaceFromRight! + 110;
      secondItemY = widget.spaceFromBottom! + 5;
      thirdItemX = widget.spaceFromRight! + 160;
      thirdItemY = widget.spaceFromBottom! + 5;
      fourthItemX = widget.spaceFromRight! + 210;
      fourthItemY = widget.spaceFromBottom! + 5;
      fifthItemX = widget.spaceFromRight! + 260;
      fifthItemY = widget.spaceFromBottom! + 5;
    } else if (widget.type == CustomFloatingActionButtonType.verticalUp) {
      firstItemX = widget.spaceFromRight! + 5;
      firstItemY = widget.spaceFromBottom! + 60;
      secondItemX = widget.spaceFromRight! + 5;
      secondItemY = widget.spaceFromBottom! + 110;
      thirdItemX = widget.spaceFromRight! + 5;
      thirdItemY = widget.spaceFromBottom! + 160;
      fourthItemX = widget.spaceFromRight! + 5;
      fourthItemY = widget.spaceFromBottom! + 210;
      fifthItemX = widget.spaceFromRight! + 5;
      fifthItemY = widget.spaceFromBottom! + 260;
    } else if (widget.type == CustomFloatingActionButtonType.verticalDown) {
      firstItemX = widget.spaceFromRight! + 5;
      firstItemY = widget.spaceFromBottom! - 60;
      secondItemX = widget.spaceFromRight! + 5;
      secondItemY = widget.spaceFromBottom! - 110;
      thirdItemX = widget.spaceFromRight! + 5;
      thirdItemY = widget.spaceFromBottom! - 160;
      fourthItemX = widget.spaceFromRight! + 5;
      fourthItemY = widget.spaceFromBottom! - 210;
      fifthItemX = widget.spaceFromRight! + 5;
      fifthItemY = widget.spaceFromBottom! - 260;
    } else {
      if (widget.spaceFromBottom != null) {
        topPositionY = 65 + widget.spaceFromBottom!;
        bottomPositionY = widget.spaceFromBottom! - 55;
        centerRightY = widget.spaceFromBottom! + 5;
        bottomCenterY = count == 4
            ? widget.spaceFromBottom! - 25
            : widget.spaceFromBottom! - 40;
        topCenterY = count == 4
            ? 35 + widget.spaceFromBottom!
            : 50 + widget.spaceFromBottom!;
      }
      if (widget.spaceFromRight != null) {
        topPositionX = 5 + widget.spaceFromRight!;
        bottomPositionX = 5 + widget.spaceFromRight!;
        centerRightX = 60 + widget.spaceFromRight!;
        bottomCenterX = count == 4
            ? 60 + widget.spaceFromRight!
            : 50 + widget.spaceFromRight!;
        topCenterX = count == 4
            ? 60 + widget.spaceFromRight!
            : 50 + widget.spaceFromRight!;
      }
      firstItemX = topPositionX;
      firstItemY = topPositionY;
      secondItemX = count == 4 || count == 5
          ? topCenterX
          : count == 2
              ? bottomPositionX
              : centerRightX;
      secondItemY = count == 4 || count == 5
          ? topCenterY
          : count == 2
              ? bottomPositionY
              : centerRightY;
      thirdItemX = count == 4
          ? bottomCenterX
          : count == 5
              ? centerRightX
              : bottomPositionX;
      thirdItemY = count == 4
          ? bottomCenterY
          : count == 5
              ? centerRightY
              : bottomPositionY;
      fourthItemX = count == 5 ? bottomCenterX : bottomPositionX;
      fourthItemY = count == 5 ? bottomCenterY : bottomPositionY;
      fifthItemX = count == 5 ? bottomPositionX : bottomCenterX;
      fifthItemY = count == 5 ? bottomPositionY : bottomCenterY;
    }
  }

  _showOptions() {
    return Stack(
      children: [
        Positioned(
          bottom: widget.spaceFromBottom ?? 100,
          right: widget.spaceFromRight ?? 10,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              height: 55,
              width: 55,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.floatinButtonColor ?? Colors.white,
              ),
              child: Material(
                color: Colors.transparent,
                child: widget.closeFloatingActionButton,
              ),
            ),
          ),
        ),
        if (widget.options != null && widget.options!.isNotEmpty)
          Positioned(
            right: firstItemX,
            bottom: firstItemY,
            child: Material(
              color: Colors.transparent,
              child: widget.options![0],
            ),
          ),
        if (widget.options != null && widget.options!.length > 1)
          Positioned(
            right: secondItemX,
            bottom: secondItemY,
            child: Material(
              color: Colors.transparent,
              child: widget.options![1],
            ),
          ),
        if (widget.options != null && widget.options!.length > 2)
          Positioned(
            bottom: thirdItemY,
            right: thirdItemX,
            child: Material(
              color: Colors.transparent,
              child: widget.options![2],
            ),
          ),
        if (widget.options != null && widget.options!.length > 3)
          Positioned(
            right: fourthItemX,
            bottom: fourthItemY,
            child: Material(
              color: Colors.transparent,
              child: widget.options![3],
            ),
          ),
        if (widget.options != null && widget.options!.length > 4)
          Positioned(
            right: fifthItemX,
            bottom: fifthItemY,
            child: Material(
              color: Colors.transparent,
              child: widget.options![4],
            ),
          ),
      ],
    );
  }
}

enum CustomFloatingActionButtonType {
  circular,
  verticalUp,
  verticalDown,
  horizontal,
}

// enum CustomFloatinActionButtonLocation {
//   bottomRight,
//   bottomLeft,
//   bottomCenter,
//   topRight,
//   topLeft,
//   topCenter,
// }
