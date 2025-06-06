import 'package:financiera_app/features/documents/presentation/documents_screen.dart';
import 'package:flutter/material.dart';
import 'package:financiera_app/core/widgets/custom_button.dart';
import 'package:financiera_app/core/widgets/custom_text_field.dart';
import 'package:financiera_app/features/home/domain/home_service.dart';
import 'package:financiera_app/features/home/domain/models/response/client_response.dart';

class AddClient extends StatefulWidget {
  final ClientResponse? client;
  const AddClient({Key? key, this.client}) : super(key: key);

  @override
  AddClientState createState() => AddClientState();
}
class AddClientState extends State<AddClient> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> controllers = {};

  final Map<String, String> fieldLabels = {
    // Datos del Cliente
    'name': 'Nombre',
    'phone': 'Teléfono',
    'email': 'Correo electrónico',
    'rfc': 'RFC',
    'curp': 'CURP',
    'street': 'Calle',
    'colony': 'Colonia',
    'state': 'Estado',
    'municipality': 'Municipio',
    'nationality': 'Nacionalidad',
    'postal_code': 'Código postal',
    'birthplace': 'Lugar de nacimiento',
    'birthdate': 'Fecha de nacimiento',
    'marital_status': 'Estado civil',
    'gender': 'Género',
    'marital_regime': 'Régimen matrimonial',
    'occupation': 'Ocupación',
    'spouse_name': 'Nombre del cónyuge',
    'spouse_nationality': 'Nacionalidad del cónyuge',
    'spouse_email': 'Correo del cónyuge',
    'pep_position': 'Puesto como PEP',
    'pep_period': 'Período como PEP',
    'related_pep_name': 'Nombre del PEP relacionado',
    'related_pep_position': 'Puesto del PEP relacionado',
    'credit_destination': 'Destino del crédito',
    'resource_origin': 'Origen de recursos',
    'payment_frequency': 'Frecuencia de pagos',
    'payment_type': 'Forma de pago',
    'status': 'Estatus',
    'monthly_income': 'Ingreso mensual',
    'other_income': 'Otros ingresos',
    'payment_count': 'Número de pagos',
    'payment_amount': 'Monto del pago',

    // Datos del Aval
    'aval_name': 'Nombre del Aval',
    'aval_phone': 'Teléfono del Aval',
    'aval_email': 'Correo del Aval',
    'aval_fiel_serial_number': 'Número de serie FIEL del Aval',
    'aval_rfc': 'RFC del Aval',
    'aval_curp': 'CURP del Aval',
    'aval_street': 'Calle del Aval',
    'aval_colony': 'Colonia del Aval',
    'aval_state': 'Estado del Aval',
    'aval_municipality': 'Municipio del Aval',
    'aval_nationality': 'Nacionalidad del Aval',
    'aval_postal_code': 'Código postal del Aval',
    'aval_birthplace': 'Lugar de nacimiento del Aval',
    'aval_birthdate': 'Fecha de nacimiento del Aval',
    'aval_gender': 'Género del Aval',
    'aval_marital_status': 'Estado civil del Aval',
    'aval_marital_regime': 'Régimen matrimonial del Aval',
    'aval_occupation': 'Ocupación del Aval',
    'aval_spouse_name': 'Nombre del cónyuge del Aval',
    'aval_spouse_nationality': 'Nacionalidad del cónyuge del Aval',
    'aval_spouse_email': 'Correo del cónyuge del Aval',
  };

  final List<String> fields = [
    'name', 'phone', 'email', 'rfc', 'curp', 'street', 'colony', 'state',
    'municipality', 'nationality', 'postal_code', 'birthplace', 'birthdate',
    'marital_status', 'gender', 'marital_regime', 'occupation', 'spouse_name',
    'spouse_nationality', 'spouse_email', 'pep_position', 'pep_period',
    'related_pep_name', 'related_pep_position', 'credit_destination',
    'resource_origin', 'payment_frequency', 'payment_type', 'status', 'monthly_income',
    'other_income', 'payment_count', 'payment_amount',

    // Datos del Aval
    'aval_name', 'aval_phone', 'aval_email', 'aval_fiel_serial_number', 'aval_rfc',
    'aval_curp', 'aval_street', 'aval_colony', 'aval_state', 'aval_municipality',
    'aval_nationality', 'aval_postal_code', 'aval_birthplace', 'aval_birthdate',
    'aval_gender', 'aval_marital_status', 'aval_marital_regime', 'aval_occupation',
    'aval_spouse_name', 'aval_spouse_nationality', 'aval_spouse_email',
  ];

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    for (var field in fields) {
      controllers[field] = TextEditingController(text: _getTextForController(field));
    }
  }

  String _getTextForController(String field) {
    final value = widget.client?.toJson()[field];
    if (value is double) {
      return value.toString(); // Convierte a String si es double
    }
    return value?.toString() ?? ''; // De lo contrario, solo lo convierte a String
  }

  @override
  void dispose() {
    for (var controller in controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  String _getLabel(String key) => fieldLabels[key] ?? key;

  Widget buildTextField(String label, String key) {
    return CustomTextFormField(
      controller: controllers[key]!,
      hintText: label,
      textCapitalization: TextCapitalization.sentences,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.client == null ? 'Crear Cliente' : 'Editar Cliente'),
        actions: [
          if(widget.client != null)
          IconButton(
            icon: const Icon(Icons.document_scanner),
            onPressed: () {
             Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DocumentUploadScreen()
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                'Datos del Cliente',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ...fields.where((f) => !f.startsWith('aval_')).map((f) => buildTextField(_getLabel(f), f)),

              const SizedBox(height: 20),
              const Text(
                'Datos del Aval',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              // Llenar los campos del Aval también
              ...fields.where((f) => f.startsWith('aval_')).map((f) => buildTextField(_getLabel(f), f)),

              const SizedBox(height: 20),
              CustomButtonWidget(
                text: widget.client == null ? 'Guardar Cliente' : 'Actualizar Cliente',
                texTcolor: Colors.white,
                isLoading: isLoading,
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });

                  final data = await HomeService().postClient(
                    ClientResponse(
                      name: controllers['name']?.text,
                      phone: controllers['phone']?.text,
                      email: controllers['email']?.text,
                      rfc: controllers['rfc']?.text,
                      curp: controllers['curp']?.text,
                      street: controllers['street']?.text,
                      colony: controllers['colony']?.text,
                      state: controllers['state']?.text,
                      municipality: controllers['municipality']?.text,
                      nationality: controllers['nationality']?.text,
                      postalCode: controllers['postal_code']?.text,
                      birthplace: controllers['birthplace']?.text,
                      birthdate: controllers['birthdate']?.text,
                      maritalStatus: controllers['marital_status']?.text,
                      gender: controllers['gender']?.text,
                      maritalRegime: controllers['marital_regime']?.text,
                      occupation: controllers['occupation']?.text,
                      spouseName: controllers['spouse_name']?.text,
                      spouseNationality: controllers['spouse_nationality']?.text,
                      spouseEmail: controllers['spouse_email']?.text,
                      pepPosition: controllers['pep_position']?.text,
                      pepPeriod: controllers['pep_period']?.text,
                      relatedPepName: controllers['related_pep_name']?.text,
                      relatedPepPosition: controllers['related_pep_position']?.text,
                      creditDestination: controllers['credit_destination']?.text,
                      resourceOrigin: controllers['resource_origin']?.text,
                      paymentFrequency: controllers['payment_frequency']?.text,
                      paymentCount: int.tryParse(controllers['payment_count']?.text ?? ''),
                      paymentType: controllers['payment_type']?.text,
                      paymentAmount: double.tryParse(controllers['payment_amount']?.text ?? ''),
                      status: controllers['status']?.text ?? 'pendiente',
                      monthlyIncome: double.tryParse(controllers['monthly_income']?.text ?? ''),
                      otherIncome: double.tryParse(controllers['other_income']?.text ?? ''),
                      aval: Aval(
                        name: controllers['aval_name']?.text ?? '',
                        phone: controllers['aval_phone']?.text,
                        email: controllers['aval_email']?.text,
                        rfc: controllers['aval_rfc']?.text,
                        curp: controllers['aval_curp']?.text,
                        street: controllers['aval_street']?.text,
                        colony: controllers['aval_colony']?.text,
                        state: controllers['aval_state']?.text,
                        municipality: controllers['aval_municipality']?.text,
                        nationality: controllers['aval_nationality']?.text,
                        postalCode: controllers['aval_postal_code']?.text,
                        birthplace: controllers['aval_birthplace']?.text,
                        birthdate: controllers['aval_birthdate']?.text,
                        gender: controllers['aval_gender']?.text,
                        maritalStatus: controllers['aval_marital_status']?.text,
                        maritalRegime: controllers['aval_marital_regime']?.text,
                        occupation: controllers['aval_occupation']?.text,
                        spouseName: controllers['aval_spouse_name']?.text,
                        spouseNationality: controllers['aval_spouse_nationality']?.text,
                        spouseEmail: controllers['aval_spouse_email']?.text,
                      ),
                    ),
                  );

                  setState(() {
                    isLoading = false;
                  });

                  if (data) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Cliente guardado exitosamente'),
                      ),
                    );
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Error al guardar el cliente'),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
