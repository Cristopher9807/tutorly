import 'package:flutter/material.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Términos y Condiciones'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Términos y Condiciones\n',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                'Acuerdo de servicio\n'
                'Al utilizar Tutorly, acepta cumplir con los siguientes términos y condiciones que se describen en este documento.\n\n'
                'Alcance de los servicios\n'
                'Tutorly proporciona recursos y herramientas educativas para mejorar las experiencias de aprendizaje de los estudiantes y educadores. Esto incluye, entre otras cosas, lecciones interactivas, cuestionarios y seguimiento del progreso.\n\n'
                'Limitaciones del servicio\n'
                'Los usuarios deben crear una cuenta para acceder a los servicios de Tutorly. Se debe proporcionar información precisa y completa durante el registro. Los usuarios son responsables de mantener la confidencialidad de las credenciales de su cuenta.\n\n'
                'Pago\n'
                'Tutorly puede exigir el pago. El pago debe realizarse al momento de la suscripción al servicio. Aceptamos tarjetas de crédito/débito y pagos electrónicos. Las tarifas de suscripción y cualquier cargo adicional se detallarán claramente.\n\n'
                'Política de cancelación\n'
                'Los usuarios pueden cancelar su suscripción en cualquier momento. Las cancelaciones deben realizarse a través de la configuración de la cuenta. Los reembolsos se proporcionarán de acuerdo con nuestra política de reembolsos descrita en nuestro sitio web.\n\n'
                'Responsabilidad\n'
                'Todo el contenido proporcionado en Tutorly es para uso personal y no comercial. Los usuarios no pueden distribuir, modificar, transmitir, reutilizar ni utilizar el contenido para fines públicos o comerciales sin permiso explícito.\n\n'
                'Responsabilidades del cliente\n'
                'Los usuarios son responsables de garantizar que su uso de Tutorly cumpla con todas las leyes y regulaciones aplicables. Cualquier uso indebido de la plataforma, incluido, entre otros, compartir contenido ofensivo o inapropiado, dará como resultado la cancelación de la cuenta.\n\n'
                'Garantía\n'
                'Tutorly se compromete a proteger la privacidad del usuario. La información personal recopilada durante el registro y el uso del servicio se manejará de acuerdo con nuestra Política de privacidad, a la que se puede acceder en nuestro sitio web.\n\n'
                'Indemnización\n'
                'Los usuarios aceptan indemnizar y eximir de responsabilidad a Tutorly y sus empleados de cualquier reclamo, daño o responsabilidad que surja de su uso de los servicios proporcionados.\n\n'
                'Modificación de los términos\n'
                'Tutorly se reserva el derecho de modificar o actualizar estos términos y condiciones en cualquier momento. Se notificará a los usuarios sobre cualquier cambio antes de su aplicación.\n',
                style: TextStyle(fontSize: 16, height: 1.6),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
