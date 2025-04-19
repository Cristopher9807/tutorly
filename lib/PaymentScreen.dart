// Archivo: Payment.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'PaymentSuccessful.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  bool showCard = true;
  String cardNumber = '';
  DateTime? selectedExpiryDate;
  String cvv = '';
  bool obscureCVV = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Verificar'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          onChanged: () => setState(() {}),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => showCard = true),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        decoration: BoxDecoration(
                          color: showCard ? Colors.blue.shade100 : Colors.white,
                          border: Border.all(color: showCard ? Colors.blue : Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.credit_card, color: showCard ? Colors.blue : Colors.grey),
                            const SizedBox(width: 8),
                            Text(
                              'Crédito/débito',
                              style: TextStyle(color: showCard ? Colors.blue : Colors.black),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => showCard = false),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        decoration: BoxDecoration(
                          color: !showCard ? Colors.blue.shade100 : Colors.white,
                          border: Border.all(color: !showCard ? Colors.blue : Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.account_balance_wallet, color: !showCard ? Colors.blue : Colors.grey),
                            const SizedBox(width: 8),
                            Text(
                              'Paypal',
                              style: TextStyle(color: !showCard ? Colors.blue : Colors.black),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              if (showCard) ...[
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  maxLength: 16,
                  decoration: const InputDecoration(
                    labelText: 'Número de tarjeta',
                    prefixIcon: Icon(Icons.credit_card),
                    border: OutlineInputBorder(),
                    counterText: '',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Este campo es obligatorio';
                    if (value.length != 16) return 'Debe tener exactamente 16 dígitos';
                    return null;
                  },
                  onChanged: (value) => cardNumber = value,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          final now = DateTime.now();
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: now,
                            firstDate: now,
                            lastDate: DateTime(now.year + 10),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  dialogBackgroundColor: Colors.white,
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (picked != null) {
                            setState(() {
                              selectedExpiryDate = picked;
                            });
                          }
                        },
                        child: AbsorbPointer(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Fecha de caducidad',
                              prefixIcon: Icon(Icons.calendar_today),
                              border: OutlineInputBorder(),
                            ),
                            validator: (_) {
                              if (selectedExpiryDate == null) {
                                return 'Seleccione una fecha válida';
                              }
                              return null;
                            },
                            controller: TextEditingController(
                              text: selectedExpiryDate != null
                                  ? DateFormat('MM/yy').format(selectedExpiryDate!)
                                  : '',
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        obscureText: obscureCVV,
                        maxLength: 3,
                        decoration: const InputDecoration(
                          labelText: 'CVV/CVC',
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(),
                          counterText: '',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Obligatorio';
                          if (value.length != 3) return 'Debe tener 3 dígitos';
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            cvv = value;
                            obscureCVV = value.length > 1;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _formKey.currentState?.validate() == true
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const PaymentSuccessful(),
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey.shade300,
                  ),
                  child: const Text('Verificar'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
