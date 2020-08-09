import 'package:flutter/material.dart';
import '../widgets/cat.dart';
import 'dart:math';
class Home extends StatefulWidget{

  HomeState createState() => HomeState();


}
class HomeState extends State<Home> with TickerProviderStateMixin{
  Animation<double> catAnimation;
  AnimationController catController;

  Animation<double> boxAnimation;
  AnimationController boxController;


  initState(){
    super.initState();

    boxController= AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    catController=AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    boxAnimation=Tween(begin: 0.0,end: pi).animate(
      CurvedAnimation(
        parent: boxController,
        curve: Curves.linear,
      ),
    );

    catAnimation= Tween(begin: -35.0,end: -80.0).animate(
      CurvedAnimation(
        parent: catController,
        curve: Curves.easeIn,
      ),
    );


  }
  onTap(){
    print("lol");

    if(catController.status == AnimationStatus.completed){
      catController.reverse();
    }else if(catController.status == AnimationStatus.dismissed){
      catController.forward();

    }
  }

  Widget build(context){
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
  Widget buildCatAnimation(){
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (context,child){
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
  Widget buildBox(){
    return Container(
      height: 200.0,
      width: 200.0,
      color: Colors.brown,
    );
  }
  Widget buildLeftFlap(){
    return Positioned(
      left: 3.0,
      child: Transform.rotate(
        child: Container(
          height: 10.0,
          width: 125.0,
          color: Colors.brown,
        ),
        angle: (pi*0.655),
        alignment: Alignment.topLeft,
      ),
    );
  }

  Widget buildRightFlap() {
    return Transform.rotate(
      child: Container(
        height: 10.0,
        width: 200.0,
        color: Colors.red,
      ),
      angle: (pi / 0.750),
      alignment: Alignment.topRight,
    );
  }
}