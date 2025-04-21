import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Política de Privacidad"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Política de privacidad',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                'Introducción\n\n'
                'Tutorly ("nosotros", "nuestro" o "nos") se compromete a proteger su privacidad. '
                'Esta Política de privacidad explica cómo recopilamos, usamos y salvaguardamos su información cuando utiliza nuestra aplicación educativa ("Aplicación"). '
                'Al utilizar la Aplicación, usted acepta esta política.\n\n'
                'Información que recopilamos\n'
                'Información personal\n\n'
                '- Nombre\n'
                '- Dirección de correo electrónico\n'
                '- Número de teléfono\n'
                '- Información de pago (para servicios de suscripción)\n\n'
                'Uso de datos\n\n'
                '- Dirección IP\n'
                '- Tipo y versión del navegador\n'
                '- Páginas visitadas\n'
                '- Hora y fecha de las visitas\n'
                '- Tiempo dedicado a las páginas\n'
                '- Identificadores únicos de dispositivos\n'
                '- Datos de diagnóstico\n'
                '- Cookies y tecnologías de seguimiento\n\n'
                'Usamos cookies y tecnologías similares para rastrear la actividad en nuestra Aplicación. '
                'Puede configurar su navegador para que rechace las cookies, pero es posible que algunas funciones de la Aplicación no funcionen correctamente sin ellas.\n\n'
                'Cómo utilizamos su información\n\n'
                '- Para proporcionar y mantener nuestra aplicación\n'
                '- Para mejorar y personalizar la experiencia del usuario\n'
                '- Para analizar patrones de uso\n'
                '- Para desarrollar nuevas funciones\n'
                '- Para gestionar transacciones y suscripciones\n'
                '- Para comunicarnos con los usuarios\n'
                '- Para enviar correos electrónicos\n'
                '- Para prevenir fraudes\n'
                '- Para analizar tendencias y datos demográficos\n\n'
                'Cómo compartimos su información\n\n'
                '- Con proveedores de servicios: para tareas como procesamiento de pagos, análisis de datos, envío de correos electrónicos, alojamiento, servicio al cliente y marketing.\n'
                '- Para transferencias comerciales: durante negociaciones o en caso de fusión, venta o adquisición.\n'
                '- Con afiliados: podemos compartir información con afiliados que cumplan con esta política.\n'
                '- Con socios comerciales: para ofrecer determinados productos, servicios o promociones.',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
