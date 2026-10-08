import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Flexible(
            flex: 2,
            child: SideInfo(),
          ),
          Flexible(
            flex: 5,
            child: MainAuth(),
          ),
        ],
      ),
    );
  }
}

class MainAuth extends StatelessWidget {
  const new({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 218, 210, 203),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 190.0,
          horizontal: 240.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AuthHeader(),
            AuthForm(),
            TwoFactorAuthWidget(),
            Warning2FA(),
            AuthButton(),
          ],
        ),
      ),
    );
  }
}

class AuthHeader extends StatelessWidget {
  const new({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [Text('Autorize'), Text('vvedite')]);
  }
}

class AuthButton extends StatelessWidget {
  const new({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text('Подтвердить и войти'),
    );
  }
}

class AuthForm extends StatelessWidget {
  const new({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(children: [Text('Corporativ'), TextField()]),
        SizedBox(height: 10.0),
        Column(children: [Text('password'), TextField()]),
      ],
    );
  }
}

class SideInfo extends StatelessWidget {
  const new({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 10, 20, 41),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset("images/Logo-Mark.png"),
                //Icon(Icons.add, color: Colors.white),
                SizedBox(width: 10.0),
                Text(
                  'TriBit Bank',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            Container(
              child: Column(
                children: [
                  Text(
                    'Внутренний защищенный портал',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
    
                  Text(
                    'Доступ к операционной системе тралялялял',
                    style: TextStyle(
                      color: Color(0xFF8F9CAE),
                      fontSize: 15.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.add, color: Colors.white),
                      SizedBox(width: 5.0),
                      Text(
                        'TriBit Bank',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.add, color: Colors.white),
                      SizedBox(width: 5.0),
                      Text(
                        'TriBit Bank',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.add, color: Colors.white),
                      SizedBox(width: 5.0),
                      Text(
                        'TriBit Bank',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TwoFactorAuthWidget extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 234, 237, 255),
        border: Border.all(
          color: Color.fromARGB(255, 53, 68, 207),
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        children: [
          Text('123'),
          SizedBox(height: 10,),
          Text('123'),
          SizedBox(width: 10.0),
          DigitBoxes()
        ],
      ),
    );
  }
}

class DigitBoxes extends StatelessWidget {
  const new({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
      DigitBox(),  
      DigitBox(),  
      DigitBox(),  
      DigitBox(),  
      DigitBox(),  
      DigitBox(),  
    ],);
  }
}

class DigitBox extends StatelessWidget {
  const new({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(width: 2, color: Colors.blue,), borderRadius: BorderRadius.circular(10)),
      child: Padding(padding: EdgeInsets.all(10), child: Text('7', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),),
    );
  }
}

class Warning2FA extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Color(0xFFFFEAEA),
        border: Border.all(
          color: Color.fromARGB(255, 245, 137, 137),
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: Color.fromARGB(255, 245, 137, 137),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: RichText(
              text: TextSpan(
                text: 'Внимание! Несанкционированный вход преследуется по закону. Все действия в системе записываются. Служба СБ ведет постоянный мониторинг.',
                style: TextStyle(color: Color.fromARGB(255, 245, 137, 137)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
