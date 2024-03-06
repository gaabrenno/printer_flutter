import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:elgin/elgin.dart';

class Tela extends StatefulWidget {
  const Tela({super.key});

  @override
  State<Tela> createState() => _TelaState();
}

class _TelaState extends State<Tela> {

  @override
  void initState(){
    super.initState();
    ();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Directionality(
              textDirection: TextDirection.ltr,
              child: Text("Printer")
          ),
        ),
        body: SizedBox(
          child: Center(
            child: CupertinoButton(
              onPressed: () {
                imprimirElgin(context);
              },
              child: const Text('Imprimir'),
            )
          ),
        ),
      ),
    );
  }


  imprimirElgin(context) async {
    final _driver = ElginPrinter(
      type: ElginPrinterType.TCP,
      model: ElginPrinterModel.GENERIC_TCP,
      connection: '192.168.10.56',
      parameter: 2400,
    );

    try {
      final int? result = await Elgin.printer.connect(driver: _driver);
      if (result != null) {
        if (result == 0) {
          await Elgin.printer.printString('HELLO WORD!!!');
          await Elgin.printer.feed(2);
          await Elgin.printer.cut(lines: 2);
          await Elgin.printer.disconnect();
        }
      }
    } on ElginException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Directionality(
              textDirection: TextDirection.ltr,
              child: Text(e.error.message)
          ),
        ),
      );
    }
  }
}