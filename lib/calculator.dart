import 'package:flutter/material.dart';
import 'history_page.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  bool isDarkMode = true;
  List<String> history = [];
  dynamic currentEquation = '';

  ColorScheme getThemeColors() {
    return isDarkMode
        ? const ColorScheme(
            brightness: Brightness.dark,
            primary: Colors.white,
            secondary: Color(0xFFEBAE06),
            surface: Color(0xFF424242),
            error: Colors.red,
            onPrimary: Colors.black,
            onSecondary: Colors.white,
            onSurface: Colors.white,
            onError: Colors.white,
          )
        : const ColorScheme(
            brightness: Brightness.light,
            primary: Colors.black,
            secondary: Color(0xFFEBAE06),
            surface: Color(0xFFE0E0E0),
            error: Colors.red,
            onPrimary: Colors.white,
            onSecondary: Colors.black,
            onSurface: Colors.black,
            onError: Colors.white,
          );
  }

  Widget calbutton(String btntxt, Color btncolor, Color txtcolor) {
    return SizedBox(
      width: 90,
      height: 90,
      child: ElevatedButton(
        onPressed: () {
          calculation(btntxt);
        },
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: btncolor,
        ),
        child: Center(
          child: Text(
            btntxt,
            style: TextStyle(fontSize: 30, color: txtcolor),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = getThemeColors();

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        title: Text('Calculator', style: TextStyle(color: colors.primary)),
        backgroundColor: colors.surface,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.dark_mode : Icons.light_mode,
              color: colors.primary,
              size: 30,
            ),
            onPressed: () => setState(() {
              isDarkMode = !isDarkMode;
            }),
          ),
          IconButton(
            icon: Icon(
              Icons.history,
              color: colors.primary,
              size: 30,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HistoryPage(
                    history: history,
                    onClear: () {
                      setState(() {
                        history.clear();
                      });
                    },
                    isDarkMode: isDarkMode,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    currentEquation,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: colors.primary.withOpacity(0.7),
                      fontSize: 24,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    text,
                    textAlign: TextAlign.left,
                    style: TextStyle(color: colors.primary, fontSize: 100),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calbutton('AC', colors.surface, colors.onSurface),
                calbutton('+/-', colors.surface, colors.onSurface),
                calbutton('%', colors.surface, colors.onSurface),
                calbutton('/', colors.secondary, colors.onSecondary),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calbutton('7', colors.surface, colors.onSurface),
                calbutton('8', colors.surface, colors.onSurface),
                calbutton('9', colors.surface, colors.onSurface),
                calbutton('x', colors.secondary, colors.onSecondary),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calbutton('4', colors.surface, colors.onSurface),
                calbutton('5', colors.surface, colors.onSurface),
                calbutton('6', colors.surface, colors.onSurface),
                calbutton('-', colors.secondary, colors.onSecondary),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calbutton('1', colors.surface, colors.onSurface),
                calbutton('2', colors.surface, colors.onSurface),
                calbutton('3', colors.surface, colors.onSurface),
                calbutton('+', colors.secondary, colors.onSecondary),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 180,
                  height: 85,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      backgroundColor: colors.surface,
                    ),
                    onPressed: () {
                      calculation('0');
                    },
                    child: Center(
                      child: Text(
                        "0",
                        style: TextStyle(fontSize: 30, color: colors.onSurface),
                      ),
                    ),
                  ),
                ),
                calbutton('.', colors.surface, colors.onSurface),
                calbutton('=', colors.secondary, colors.onSecondary),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  dynamic text = '0';
  double numOne = 0;
  double numTwo = 0;
  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';

  bool isOperator(String btnText) {
    return btnText == '+' ||
        btnText == '-' ||
        btnText == 'x' ||
        btnText == '/' ||
        btnText == '=' ||
        btnText == '%' ||
        btnText == '+/-';
  }

  void calculation(btnText) {
    if (opr == '=' && !isOperator(btnText)) {
      text = '0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '';
      opr = '';
      preOpr = '';
      currentEquation = '';
    }

    if (btnText == 'AC') {
      text = '0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
      currentEquation = '';
    } else if (opr == '=' && btnText == '=') {
      if (preOpr == '+') {
        finalResult = add();
      } else if (preOpr == '-') {
        finalResult = sub();
      } else if (preOpr == 'x') {
        finalResult = mul();
      } else if (preOpr == '/') {
        finalResult = div();
      }
    } else if (btnText == '+' ||
        btnText == '-' ||
        btnText == 'x' ||
        btnText == '/' ||
        btnText == '=') {
      if (numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      if (opr == '+') {
        finalResult = add();
      } else if (opr == '-') {
        finalResult = sub();
      } else if (opr == 'x') {
        finalResult = mul();
      } else if (opr == '/') {
        finalResult = div();
      }
      preOpr = opr;
      opr = btnText;
      result = '';
    } else if (btnText == '%') {
      result = numOne / 100;
      finalResult = doesContainDecimal(result);
    } else if (btnText == '.') {
      if (!result.toString().contains('.')) {
        result = '$result.';
      }
      finalResult = result;
    } else if (btnText == '+/-') {
      result.toString().startsWith('-')
          ? result = result.toString().substring(1)
          : result = '-$result';
      finalResult = result;
    } else {
      result = result + btnText;
      finalResult = result;
    }

    if (btnText == 'AC') {
      currentEquation = '';
    } else if (btnText == '=') {
      currentEquation = '$currentEquation = $finalResult';
      history.add(currentEquation);
    } else {
      currentEquation = currentEquation + btnText;
    }

    setState(() {
      text = finalResult;
    });
  }

  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0)) {
        return result = splitDecimal[0].toString();
      }
    }
    return result;
  }
}
