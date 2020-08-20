import 'package:flutter/material.dart';
import 'package:flutterappcalculator/buttons.dart';
import 'package:math_expressions/math_expressions.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var userQuestion = '';
  var userAnswer = '';

  final myTextStyle = TextStyle(fontSize: 30 , color: Colors.deepPurple[900]);

  final List<String> buttons =
      [
          'c' , 'DEL' , '%'   , '/' ,
          '7' , '8'   , '9'   , 'X' ,
          '4' , '5'   , '6'   , '-' ,
          '1' , '2'   , '3'   , '+' ,
          '0' , '.'   , 'ANS' , '='
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                        child:
                        Text(userQuestion , style: myTextStyle,),
                    ),
                    Container(
                        alignment: Alignment.centerLeft,
                        child:
                        Text(userAnswer , style: myTextStyle,),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index){
                    if(index == 0)
                      {
                        return MyButton(
                          buttonTapped: ()
                          {
                            setState(() {
                              userQuestion = '';
                            });
                          },
                          color: Colors.green,
                          textColor: Colors.white,
                          buttonText: buttons[index],
                        );
                      }
                    else if(index == 1)
                      {
                        return MyButton(
                          buttonTapped: ()
                          {
                            setState(() {
                              userQuestion = userQuestion.substring(0,userQuestion.length-1);
                            });
                          },
                          color: Colors.red,
                          textColor: Colors.white,
                          buttonText: buttons[index],
                        );
                      }
                    else if(index == buttons.length-1)
                    {
                      return MyButton(
                        buttonTapped: ()
                        {
                          setState(() {
                            equalPressed();
                          });
                        },
                        color: Colors.red,
                        textColor: Colors.white,
                        buttonText: buttons[index],
                      );
                    }
                    else
                      {
                        return MyButton(
                          buttonTapped: ()
                          {
                            setState(() {
                              userQuestion += buttons[index];
                            });
                          },
                          color: isOperator(buttons[index]) ? Colors.deepPurple : Colors.deepPurple[50],
                          textColor: isOperator(buttons[index]) ? Colors.white : Colors.deepPurple,
                          buttonText: buttons[index],
                        );
                      }
                  }
              )
            ),
          )
        ],
      ),
    );
  }

  bool isOperator(String x)
  {
    if(x == '%' || x == '/' || x == 'X' || x == '-' || x == '+' || x == '=')
      return true;
    return false;
  }

  void equalPressed()
  {
    String finalQuistion = userQuestion;
    finalQuistion = finalQuistion.replaceAll('X', '*');

    Parser p = Parser();
    Expression exp = p.parse(finalQuistion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userAnswer = eval.toString();
  }
}
