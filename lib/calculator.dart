import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';


class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}):super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CalculatorScreenState();
  }
}

class _CalculatorScreenState extends State<CalculatorScreen> {

  var input = "";
  var output = "";
  // variables
  double firstNum = 0.0;
  double secondNum = 0.0;

  var operation = "";

  onButtonClick(value){
    // if value is AC
    if(value == "AC"){
      input = "";
      output = "";
    }
    else if(value == "<"){
      if(input.isNotEmpty) {
        input = input.substring(0, input.length - 1); // this will remove digit from last
      }
    }
    else if(value == "=") {
      try {
        if (input.isNotEmpty) {
          var userInput = input;
          userInput = input.replaceAll("x", "*");
          Parser parser = Parser();
          Expression expression = parser.parse(userInput);
          ContextModel contextModel = ContextModel();
          var finalValue = expression.evaluate(
              EvaluationType.REAL, contextModel);
          output = finalValue.toString();
        }
      }
      catch(e){
        return Exception("Error");
      }
    }else{
      input = input+value;
    }
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF28282B),
      appBar: AppBar(
        title: const Text("Calculator",style: TextStyle(color: Colors.white),),
        backgroundColor: const Color(0xFF28282B),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                // color: Color(0xFF28282B),
                color: Colors.black87,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(input,style: const TextStyle(fontSize: 48,color: Colors.white),),
                    const SizedBox(height: 20,),
                    Text(output,style: TextStyle(fontSize: 34,color: Colors.white.withOpacity(0.7)),),
                    const SizedBox(height: 30,)
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 10,),

            Row(
            children: [
              buttonCalculator(label: "AC",buttonBgColor: Colors.deepOrange,),
              buttonCalculator(label: "<", buttonBgColor: Colors.white54,),
              buttonCalculator(label: "",buttonBgColor: Colors.transparent,),
              buttonCalculator(label: "/",buttonBgColor: Colors.white54,)
            ],
          ),
            Row(
            children: [
              buttonCalculator(label: "7"),
              buttonCalculator(label: "8",),
              buttonCalculator(label: "9",),
              buttonCalculator(label: "x",buttonBgColor: Colors.white54,)
            ],
          ),
            Row(
            children: [
              buttonCalculator(label: "4",),
              buttonCalculator(label: "5", ),
              buttonCalculator(label: "6",),
              buttonCalculator(label: "-",buttonBgColor: Colors.white54,)
            ],
          ),
            Row(
            children: [
              buttonCalculator(label: "1",),
              buttonCalculator(label: "2",),
              buttonCalculator(label: "3",),
              buttonCalculator(label: "+",buttonBgColor: Colors.white54,)
            ],
          ),
          Row(
            children: [
              buttonCalculator(label: "%",buttonBgColor: Colors.deepOrange,),
              buttonCalculator(label: "0",),
              buttonCalculator(label: ".",buttonBgColor: Colors.deepOrange,),
              buttonCalculator(label: "=",buttonBgColor: Colors.deepOrange.shade800,)
            ],
          ),
        ],
      ),
    );
  }

  Widget buttonCalculator({label,textColor=Colors.white,buttonBgColor=Colors.white24}){
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        child: ElevatedButton(
          onPressed: (){
            onButtonClick(label);
          },
          style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(24),
              backgroundColor: buttonBgColor
          ),
          child: Text(label,style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold,color: textColor),),
        ),
      ),
    );
  }
}
