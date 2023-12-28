import 'package:flutter/material.dart';

import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../widgets/table_bmi.dart';

class BmiPage extends StatefulWidget {
  const BmiPage({
    super.key,
    required this.updateHeight,
    required this.updateWeight,
    required this.bmiResult,
    required this.calculateBMI,
    required this.cleanFields,
  });
  final ValueChanged<String> updateHeight;
  final ValueChanged<String> updateWeight;
  final Function calculateBMI;
  final Function cleanFields;
  final double bmiResult;

  @override
  State<BmiPage> createState() => _BmiPageState();
}

class _BmiPageState extends State<BmiPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final maskHeight = MaskTextInputFormatter(
    mask: '#,##',
    filter: {"#": RegExp('[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  final maskWeight = MaskTextInputFormatter(
    mask: '##,##',
    filter: {"#": RegExp('[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  Color getResultTextColor() {
    return widget.bmiResult == 0
        ? const Color.fromARGB(0, 0, 0, 0)
        : Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Calcular Índice de Massa Corporal',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Altura (m)',
                  helperText: " ",
                  icon: Icon(Icons.height),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [maskHeight],
                onChanged: (String value) {
                  widget.updateHeight(value);
                },
                onTapOutside: (event) {
                  FocusScopeNode currentFocus = FocusScope.of(context);

                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                },
                textInputAction: TextInputAction.next,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Entre com a altura em metros';
                  }
                  if (value.length < 4) {
                    return 'Altura inválida. Verifique e tente novamente';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  helperText: " ",
                  icon: Icon(Icons.scale),
                  labelText: 'Peso (kg)',
                ),
                inputFormatters: [maskWeight],
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  widget.updateWeight(value);
                },
                onTapOutside: (event) {
                  FocusScopeNode currentFocus = FocusScope.of(context);

                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                },
                textInputAction: TextInputAction.done,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Entre com o peso em quilos';
                  }
                  if (value.length < 5) {
                    return 'Peso inválido. Verifique e tente novamente';
                  }
                  return null;
                },
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                          Theme.of(context).primaryColor,
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          widget.calculateBMI();
                        }
                      },
                      child: const Text(
                        'Calcular',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        widget.cleanFields();
                        _formKey.currentState?.reset();
                      },
                      child: Text(
                        'Limpar',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Resultado IMC: ${widget.bmiResult.toStringAsFixed(1).replaceFirst('.', ',')} - Abaixo do peso',
                      style: TextStyle(
                          color: getResultTextColor(),
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              const TableBmi()
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
