// Here we are hiding the decoration caz we are using the inset package for neo design
import 'package:flutter/cupertino.dart'hide BoxDecoration,BoxShadow;
import 'package:flutter/material.dart'hide BoxDecoration,BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:math_expressions/math_expressions.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // This is for dark mode
  bool isdark=true;
  // This is for pressed effect
  String value="";

  // double firstNum=0.0;
  // double secondNum=0.0;
  // This is to display the input
  var input="";
  // This is to display the output
  var output="";



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:isdark?const  Color(0xff374353):const Color(0xfffafbff),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              padding:const  EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height*0.3,
              width: double.infinity,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children:  [
                  Expanded(child:
                  Row(
                    children: [
                      // switch for modes
                      CupertinoSwitch(
                        activeColor: Colors.white,
                        thumbColor:isdark? Colors.blue:const Color(0xff374353),
                        value: isdark, onChanged: (bool value) { setState(() {
                        isdark=!isdark;
                      }); },),
                    ],
                  ) ),
                  Text(input,style:  TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color:isdark ?Colors.white:const Color(0xff6bbbf9)),maxLines: 1,),
                 const  SizedBox(height: 10,),
                  Text(output,style:  TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color:isdark ?const Color(0xffbfcfd7): Color(0xff0ffbfcfd7)),maxLines: 1,),
                ],
              ),
            ),
            // bottons part
            Container(
              height: MediaQuery.of(context).size.height*0.65,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    btn("AC"),
                    btn("<"),
                    btn("%"),
                    btn("/"),
                  ],
                ),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      btn("7"),
                      btn("8"),
                      btn("9"),
                      btn("x"),
                    ],
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      btn("4"),
                      btn("5"),
                      btn("6"),
                      btn("-"),
                    ],
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      btn("1"),
                      btn("2"),
                      btn("3"),
                      btn("+"),
                    ],
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      btn("+/-"),
                      btn("0"),
                      btn("."),
                      btn("="),
                    ],
                  ),

                ],
              ),

            )
          ],
        ),
      ),
    );
  }
  Widget btn(String text){

    double blur=value==text?1.0:5;
    Offset distance=value==text?const Offset(3,3):const Offset(4,4);
    // here we are using listener to listen the user press state
    return  Listener(
      // This trigger when user lift the finter
      onPointerUp: (_){
       if(text==text){
         setState(() {
           value="";
         });
       }
      },
      // This trigger when user press button
      onPointerDown: (_){
        if(text==text){
          setState(() {
            value=text;
          });
          // here we are send the selected value to the calculation
          calculatefuction(value);
        }
      },

      child:Container(
        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 25),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color:isdark?const  Color(0xff374353):const Color(0xfffafbff),
            boxShadow:  [
              BoxShadow(

                  color: isdark ?const  Color(0xff2f3b47):const Color(0xffe3effc),
                  offset: distance,
                  blurRadius: blur,
                  inset: value==text

              ),
              BoxShadow(
                  color:isdark ?const Color(0xffb4bcb4).withOpacity(0.2):const Color(0xffffffff),
                  offset:-distance,
                  blurRadius: blur,
                  inset:  value==text

              )
            ]

        ), child:   Text(text,style:  TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: isdark? Colors.white:Color(0xff0185f2)),),
      ),
    );
  }
  // This is where all calculation perform
  calculatefuction(value){
    //
    if(value=="AC"){
      input="";
      output="";
    }else if(value=="<"){
      // this is remove section
      if(input.isNotEmpty){
      input=input.substring(0,input.length-1);}
    }else if(value=="="){

      if(input.isNotEmpty){
      var userInput=input;
      // here we are repalcing X with *
      userInput=input.replaceAll("x", "*");
      // this section is taken from flutter math expression package
      Parser p=Parser();
      Expression expression=p.parse(userInput);
      ContextModel cm=ContextModel();
      var finalValue=expression.evaluate(EvaluationType.REAL, cm);
      output=finalValue.toString();
      if(output.endsWith(".0")){
        output=output.substring(0,output.length-2);
      }
      input=output;
      }
    }else{
      input =input+value;
    }
    setState(() {

    });
  }
}
