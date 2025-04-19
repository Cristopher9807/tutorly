// Archivo: DetallesPedido.dart
import 'package:flutter/material.dart';
import 'package:tutorly/home_script/menu/perfil.dart';
import 'dart:math';
import 'package:tutorly/PaymentScreen.dart' as pantalla_pago;


class DetallesPedido extends StatefulWidget {
  final int horasSeleccionadas;

  const DetallesPedido({Key? key, required this.horasSeleccionadas}) : super(key: key);

  @override
  State<DetallesPedido> createState() => _DetallesPedidoState();
}

class _DetallesPedidoState extends State<DetallesPedido> {
  bool showPromoDialog = false;
  bool promoAplicado = false;
  String promoCode = '';

  static const double precioPorHora = 30.0;
  double descuento = 0.0;

  @override
  void initState() {
    super.initState();
    calcularDescuento();
  }

  void calcularDescuento() {
    int horas = widget.horasSeleccionadas;
    double subtotal = horas * precioPorHora;

    if (horas > 10) {
      descuento = subtotal * 0.10;
    } else {
      descuento = subtotal * 0.05;
    }

    if (promoAplicado) {
      descuento = subtotal * 0.15;
    }
  }

  @override
  Widget build(BuildContext context) {
    int horas = widget.horasSeleccionadas;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double subtotal = horas * precioPorHora;
    calcularDescuento();
    double iva = (subtotal - descuento) * 0.09;
    double total = subtotal - descuento + iva;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del pedido', textAlign: TextAlign.center),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Volver a ScheduleScreen
          },
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Sesión en línea de $horas hora${horas > 1 ? 's' : ''}',
                          style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 8),
                      detalleFila('Subtotal', '\$${subtotal.toStringAsFixed(2)}'),
                      detalleFila('Descuento', '-\$${descuento.toStringAsFixed(2)}'),
                      detalleFila('IVA (+9%)', '\$${iva.toStringAsFixed(2)}'),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                          Text('\$${total.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          const Text('¿Tienes un código promocional?'),
                          const Spacer(),
                          GestureDetector(
                            onTap: () => setState(() => showPromoDialog = true),
                            child: const Text('Aplicar aquí',
                                style: TextStyle(color: Colors.blue)),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                side: const BorderSide(color: Colors.black),
                              ),
                              onPressed: () {
                                // TODO: Lógica para añadir al carrito
                              },
                              child: const Text('Añadir al carrito'),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const pantalla_pago.PaymentScreen(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('Comprar ahora'),
                            ),
                          )
                        ],
                      ),
                      if (showPromoDialog)
                        AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          title: const Text('Código promocional'),
                          content: TextField(
                            onChanged: (value) => promoCode = value,
                            decoration:
                                const InputDecoration(hintText: 'Promo123'),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => setState(() => showPromoDialog = false),
                              child: const Text('Cancelar'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (promoCode == 'Promo123') {
                                  setState(() {
                                    promoAplicado = true;
                                    showPromoDialog = false;
                                  });
                                }
                              },
                              child: const Text('Aplicar código'),
                            )
                          ],
                        )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget detalleFila(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14)),
          Text(value, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
