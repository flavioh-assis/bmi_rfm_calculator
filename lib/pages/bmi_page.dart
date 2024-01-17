import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '/utils.dart';
import '/widgets/table_bmi.dart';

class BmiPage extends StatefulWidget {
  const BmiPage({
    super.key,
    required this.height,
    required this.weight,
    required this.bmiResult,
    required this.calculateBMI,
    required this.cleanFields,
    required this.updateHeight,
    required this.updateWeight,
  });

  final double height;
  final double weight;
  final double bmiResult;
  final Function calculateBMI;
  final Function cleanFields;
  final ValueChanged<String> updateHeight;
  final ValueChanged<String> updateWeight;

  @override
  State<BmiPage> createState() => _BmiPageState();
}

class _BmiPageState extends State<BmiPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static const _maskDoubleThreeDigits = '#,##';
  static const _maskDoubleFourDigits = '##,##';
  static const _maskDoubleFiveDigits = '###,##';

  AgeGroup _selectedAgeGroup = AgeGroup.until60;

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
    List<BmiValues> tableValues = getTableBmiValues(_selectedAgeGroup);

    for (var element in tableValues.reversed) {
      if (bmiValue >= element.min) {
        return element.classification;
      }
    }

    return '';
  }

  String _getInitialValue(double value) {
    return value > 0 ? doubleToText(value, decimalPlaces: 2) : '';
  }

  String _getMask(int textSize) {
    if (textSize >= 4) {
      return _maskDoubleFiveDigits;
    }

    return _maskDoubleFourDigits;
  }

  void _handleSelectAgeGroup(AgeGroup value) {
    setState(() {
      _selectedAgeGroup = value;
    });
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          canPop: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  TextFormField(
                    cursorColor: Theme.of(context).primaryColor,
                    decoration: InputDecoration(
                      labelText: 'Altura (m)',
                      helperText: " ",
                      icon: const Icon(Icons.height),
                      floatingLabelStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 2,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    initialValue: _getInitialValue(widget.height),
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
                    cursorColor: Theme.of(context).primaryColor,
                    decoration: InputDecoration(
                      helperText: " ",
                      icon: const Icon(Icons.scale),
                      labelText: 'Peso (kg)',
                      floatingLabelStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 2,
                        ),
                      ),
                    ),
                    initialValue: _getInitialValue(widget.weight),
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
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedAgeGroup == AgeGroup.until60
                          ? Theme.of(context).primaryColor
                          : Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          topLeft: Radius.circular(25),
                          bottomRight: Radius.circular(0),
                          topRight: Radius.circular(0),
                        ),
                      ),
                    ),
                    onPressed: () => _handleSelectAgeGroup(AgeGroup.until60),
                    child: Text(
                      'De 20 a 60 anos',
                      style: TextStyle(
                        color: _selectedAgeGroup == AgeGroup.until60
                            ? Colors.white
                            : Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedAgeGroup == AgeGroup.plus60
                          ? Theme.of(context).primaryColor
                          : Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(0),
                          topLeft: Radius.circular(0),
                          bottomRight: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                      ),
                    ),
                    onPressed: () => _handleSelectAgeGroup(AgeGroup.plus60),
                    child: Text(
                      'Mais de 60 anos',
                      style: TextStyle(
                        color: _selectedAgeGroup == AgeGroup.plus60
                            ? Colors.white
                            : Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
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
              Text(
                'Resultado IMC: ${doubleToText(widget.bmiResult)} - ${_getBmiClassification(widget.bmiResult)}',
                style: TextStyle(
                  color: _getResultTextColor(),
                  fontWeight: FontWeight.w600,
                ),
              ),
              TableBmi(ageGroup: _selectedAgeGroup)
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
