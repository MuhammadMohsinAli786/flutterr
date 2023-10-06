import 'package:calculator/Components/My_Button.dart';
import 'package:calculator/Constant.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var userinput = '';
  var Answer = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(child: const Text('Calculator',style: TextStyle(fontSize: 20,color: Colors.deepOrange),)),
      ),
      body: SafeArea(

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Align(
                          alignment:Alignment.bottomLeft ,
                        ),
                        Text(userinput.toString(),style: const TextStyle(fontSize: 30,color: Colors.white),),
                        const SizedBox(height: 20),
                        Text(Answer.toString(),style: const TextStyle(fontSize: 30,color: Colors.white),),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          MyButton(title: 'Ac', onpress: (){
                            userinput = '';
                            Answer = '';
                            setState(() {

                            });
                          },),
                          MyButton(title: '+/-', onpress: (){
                            userinput += '+/-';
                            setState(() {

                            });
                          },),
                          MyButton(title: '%', onpress: (){
                            userinput += '%';
                            setState(() {

                            });
                          },),
                          MyButton(title: '/', colors: const Color(0xffffa00a), onpress: (){
                            userinput += '/';
                            setState(() {

                            });
                          },),
                        ],
                      ),
                      Row(
                        children: [
                          MyButton(title: '7', onpress: (){
                            userinput += '7';
                            setState(() {

                            });
                          },),
                          MyButton(title: '8', onpress: (){
                            userinput += '8';
                            setState(() {

                            });
                          },),
                          MyButton(title: '9', onpress: (){
                            userinput += '9';
                            setState(() {

                            });
                          },),
                          MyButton(title: 'x', colors: const Color(0xffffa00a), onpress: (){
                            userinput += 'x';
                            setState(() {

                            });
                          },),
                        ],
                      ),
                      Row(
                        children: [
                          MyButton(title: '4', onpress: (){
                            userinput += '4';
                            setState(() {

                            });
                          },),
                          MyButton(title: '5', onpress: (){
                            userinput += '5';
                            setState(() {

                            });
                          },),
                          MyButton(title: '6', onpress: (){
                            userinput += '6';
                            setState(() {

                            });
                          },),
                          MyButton(title: '-', colors: const Color(0xffffa00a), onpress: (){
                            userinput += '-';
                            setState(() {

                            });
                          },),
                        ],
                      ),
                      Row(
                        children: [
                          MyButton(title: '1', onpress: (){
                            userinput += '1';
                            setState(() {

                            });
                          },),
                          MyButton(title: '2', onpress: (){
                            userinput += '2';
                            setState(() {

                            });
                          },),
                          MyButton(title: '3', onpress: (){
                            userinput += '3';
                            setState(() {

                            });
                          },),
                          MyButton(title: '+', colors: const Color(0xffffa00a), onpress: (){
                            userinput += '+';
                            setState(() {

                            });
                          },),
                        ],
                      ),
                      Row(
                        children: [
                          MyButton(title: '0', onpress: (){
                            userinput += '0';
                            setState(() {

                            });
                          },),
                          MyButton(title: '.', onpress: (){
                            userinput += '.';
                            setState(() {

                            });
                          },),
                          MyButton(title: 'Del', onpress: (){
                            userinput = userinput.substring(0,userinput.length-1);
                            setState(() {

                            });
                          },),
                          MyButton(title: '=', colors: const Color(0xffffa00a), onpress: (){
                            equalpress();
                            setState(() {

                            });
                          },),
                        ],
                      ),
                    ],
                  ),
                ),


              ],

            ),
          )),
    );
  }
  void equalpress(){
    String finaluserinput =userinput;
    finaluserinput = userinput.replaceAll('x','*');
    Parser p =Parser();
    Expression expression= p.parse(finaluserinput);
    ContextModel contextModel = ContextModel();
    double eval = expression.evaluate(EvaluationType.REAL, contextModel);
    Answer = eval.toString();

  }
}

