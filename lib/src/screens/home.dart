import 'package:flutter/material.dart';
import '../widgets/cat.dart';
import 'dart:math';
class Home extends StatefulWidget{
  HomeState createState() => HomeState();

}

class HomeState extends State<Home> with TickerProviderStateMixin{
  /*
  * animation and animation controler to control the animation part for different elements
  * */
  late Animation<double>    catAnimation;
  late AnimationController  catController;
  late Animation<double>    boxAnimation;
  late AnimationController  boxControler;

  /*
  * initState control the whole animation controler,
  * */

  initState(){
    super.initState();

    boxControler = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    boxAnimation = Tween(begin: pi * 0.6, end: pi * 0.65).animate(
      CurvedAnimation(
          parent: boxControler,
          curve: Curves.linear,
      )
    );
    boxAnimation.addStatusListener((status){
      if(status == AnimationStatus.completed){
        boxControler.reverse();
      }else if (status == AnimationStatus.dismissed){
        boxControler.forward();
      }
    });
    boxControler.forward();

    catController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    catAnimation = Tween(begin: -50.0, end: -180.0).animate(
      CurvedAnimation(
          parent: catController,
          curve: Curves.easeIn,
      ),
    );

    }
  onTap(){
    // boxControler.stop();
    if(catController.status == AnimationStatus.completed){
      boxControler.forward();
      catController.reverse();
    }else if(catController.status == AnimationStatus.dismissed){
      boxControler.stop();
      catController.forward();
    }

  }

/*
*
* main widget for the boday
* */

  Widget build(context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation'),
      ),
      body: GestureDetector(
        child: Center(
          child: Stack(
            clipBehavior: Clip.none,
            // fit: StackFit.values,
            alignment: AlignmentDirectional.topStart,
            children: [

              buildCatAnimation(),
              buildBox(),
              buildLeftFlap(),

            ],
          ),
        ),


        onTap: onTap,
      ),
    );

  }
  /*
  * animation builder for cat  image
  * */
  Widget buildCatAnimation(){
    return AnimatedBuilder(
        animation: catAnimation,
        builder: (context, child) {
          return Positioned(
            child: Cat(),
            top: catAnimation.value,
            right: 0.0,
            left: 0.0,

          );
        },
      // child: Cat(),
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
        child: AnimatedBuilder(
            animation: boxAnimation,
            child: Container(
              height: 10.0,
              width: 125.0,
              color: Colors.brown,
            ),
            builder: (context, child){
              return Transform.rotate(
                child: child,
                alignment: Alignment.topLeft,
                angle: boxAnimation.value,
              );
            }
        ),
    );

  }

}