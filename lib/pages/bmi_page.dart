import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '/utils.dart';
import '/widgets/table_bmi.dart';

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
  static const _maskDoubleThreeDigits = '#,##';
  static const _maskDoubleFourDigits = '##,##';
  static const _maskDoubleFiveDigits = '###,##';

  final _maskHeight = MaskTextInputFormatter(
    mask: _maskDoubleThreeDigits,
    filter: {"#": RegExp('[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  final _maskWeight = MaskTextInputFormatter(
    mask: _maskDoubleFourDigits,
    filter: {"#": RegExp('[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  Color _getResultTextColor() {
    return widget.bmiResult == 0 ? Colors.transparent : Colors.black;
  }

  String _getBmiClassification(double bmiValue) {
    for (var element in values20to60YearsOld.reversed) {
      if (bmiValue >= element.min) {
        return element.classification;
      }
    }

    return '';
  }

  String _getMask(int textSize) {
    if (textSize >= 4) {
      return _maskDoubleFiveDigits;
    }

    return _maskDoubleFourDigits;
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      widget.calculateBMI();
    }
  }

  String? _validateHeight(String? height) {
    if (height == null || height.isEmpty) {
      return 'Entre com a altura em metros';
    }
    if (height.length < 4 ||
        textToDouble(height) < 0.5 ||
        textToDouble(height) >= 3) {
      return 'Altura inválida. Verifique e tente novamente';
    }
    return null;
  }

  String? _validateWeight(String? value) {
    if (value == null || value.isEmpty) {
      return 'Entre com o peso em quilos';
    }
    if (value.length < 5 ||
        textToDouble(value) < 5 ||
        textToDouble(value) >= 700) {
      return 'Peso inválido. Verifique e tente novamente';
    }
    return null;
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
          canPop: false,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Altura (m)',
                  helperText: " ",
                  icon: Icon(Icons.height),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [_maskHeight],
                onChanged: (String value) {
                  widget.updateHeight(value);
                },
                onTapOutside: (_) {
                  FocusScopeNode currentFocus = FocusScope.of(context);

                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                },
                textInputAction: TextInputAction.next,
                validator: (String? value) => _validateHeight(value),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  helperText: " ",
                  icon: Icon(Icons.scale),
                  labelText: 'Peso (kg)',
                ),
                inputFormatters: [_maskWeight],
                keyboardType: TextInputType.number,
                onChanged: (String value) {
                  widget.updateWeight(value);

                  _maskWeight.updateMask(
                    mask: _getMask(_maskWeight.getUnmaskedText().length),
                  );
                },
                onFieldSubmitted: (_) => _handleSubmit(),
                onTapOutside: (_) {
                  FocusScopeNode currentFocus = FocusScope.of(context);

                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                },
                textInputAction: TextInputAction.go,
                validator: (String? value) => _validateWeight(value),
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
                      onPressed: () => _handleSubmit(),
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
                      'Resultado IMC: ${doubleToText(widget.bmiResult)} - ${_getBmiClassification(widget.bmiResult)}',
                      style: TextStyle(
                        color: _getResultTextColor(),
                        fontWeight: FontWeight.w600,
                      ),
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
