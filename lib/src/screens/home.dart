import 'package:flutter/material.dart';
import '../widgets/cat.dart';
import 'dart:math';
class Home extends StatefulWidget{

  HomeState createState() => HomeState();


}
class HomeState extends State<Home> with TickerProviderStateMixin {
  Animation<double> catAnimation;
  AnimationController catController;

  Animation<double> boxAnimation;
  AnimationController boxController;


  initState() {
    super.initState();

    boxController = AnimationController(
      duration: Duration(milliseconds: 190),
      vsync: this,
    );
    

    catController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    boxAnimation = Tween(begin: 2.0, end: 2.65).animate(
      CurvedAnimation(
        parent: boxController,
        curve: Curves.linear,
      ),
    );
    boxAnimation.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        boxController.reverse();
      }else if(status == AnimationStatus.dismissed){
        boxController.forward();
      }
    });
    catAnimation = Tween(begin: -35.0, end: -80.0).animate(
      CurvedAnimation(
        parent: catController,
        curve: Curves.easeOutSine,
      ),
    );
  }

  onTap() {

    if (catController.status == AnimationStatus.completed) {
      catController.reverse();
      boxController.forward();
    } else if (catController.status == AnimationStatus.dismissed) {
      catController.forward();
      boxController.stop();
    }

//    if (boxController.status == AnimationStatus.completed) {
//      boxController.stop();
//    } else if (boxController.status == AnimationStatus.dismissed) {
//      boxController.repeat();
//    }
  }

  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation 3'),
      ),
      body: GestureDetector(
        child: Center(
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              buildCatAnimation(),
              buildBox(),
              buildRightFlap(),
              buildLeftFlap(),


            ],
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  Widget buildCatAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (context, child) {
        return Positioned(
          child: child,
          top: catAnimation.value,
          right: 0.0,
          left: 0.0,

        );
      },
      child: Cat(),
    );
  }

  Widget buildBox() {
    return Container(
      height: 200.0,
      width: 200.0,
      color: Colors.brown,
    );
  }

  Widget buildLeftFlap() {

    return Positioned(
      left: 3.0,
      child: AnimatedBuilder(
        animation: boxAnimation,
        child: Container(
          height: 10.0,
          width: 100.0,
          color: Colors.brown,
        ),
        builder: (context, child) {
          return Transform.rotate(
            child: child,
            alignment: Alignment.topLeft,
            angle: boxAnimation.value,
          );
        },
      ),
    );
}
  Widget buildRightFlap() {

    return Positioned(
      right: 3.0,
      child: AnimatedBuilder(
        animation: boxAnimation,
        child: Container(
          height: 10.0,
          width: 100.0,
          color: Colors.brown,
        ),
        builder: (context, child) {
          return Transform.rotate(
            child: child,
            alignment: Alignment.topRight,
            angle: -boxAnimation.value,
          );
        },
      ),
    );
  }
//
//  Widget buildRightFlap() {
//    return Positioned(
//      right: 3.0,
//      child:AnimatedBuilder(
//        animation: boxAnimation,
//        child: Container(
//        height: 10.0,
//        width: 125.0,
//        color: Colors.brown,
//    ),
//    builder: (context, child) {
//          return Transform.rotate(
//          child: child,
//              angle: (pi / 0.750),
//              alignment: Alignment.topRight,
//        );
//          },
//      ),
//    );
//  }

}