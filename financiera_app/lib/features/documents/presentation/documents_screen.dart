import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:financiera_app/features/documents/presentation/providers/documents_provider.dart';

class DocumentUploadScreen extends StatefulWidget {
  final int clientId;
  const DocumentUploadScreen({super.key, required this.clientId});

  @override
  _DocumentUploadScreenState createState() => _DocumentUploadScreenState();
}

class _DocumentUploadScreenState extends State<DocumentUploadScreen> {
  @override
  void initState() {
    super.initState();

    // Usamos addPostFrameCallback para llamar a getDocuments después del build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<DocumentUploadProvider>(
        context,
        listen: false,
      );
      provider.getDocuments(widget.clientId); // Llama a la función de cargar documentos
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DocumentUploadProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Subir Documentos")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            if (provider.isLoading)
              const Center(child: CircularProgressIndicator())
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Seleccione el tipo de documento'),
                  const SizedBox(height: 20),
                  // Botones para elegir tipo de documento
                  _buildDocumentButton(
                    context,
                    1,
                    'Identificación oficial',
                    provider.passportImage,
                  ),
                  _buildDocumentButton(context, 2, 'CURP', provider.frontImage),
                  _buildDocumentButton(
                    context,
                    4,
                    'Comprobante de Domicilio',
                    provider.proofAddressImage,
                  ),
                  _buildDocumentButton(
                    context,
                    5,
                    'Acta de nacimiento',
                    provider.constanciaImage,
                  ),
                ],
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Llama a la función para subir los documentos
          await provider.uploadDocuments();
        },
        child: const Icon(Icons.upload),
      ),
    );
  }

  // Botón genérico para elegir archivo
  Widget _buildDocumentButton(
    BuildContext context,
    int type,
    String label,
    XFile? imageFile,
  ) {
    return GestureDetector(
      onTap: () => _showDocumentDialog(context, type),
      child: ListTile(
        title: Text(label),
        trailing:
            imageFile != null
                ? Image.file(File(imageFile.path), width: 50, height: 50)
                : const Icon(Icons.add_a_photo),
      ),
    );
  }

  // Mostrar un diálogo para seleccionar el tipo de archivo
  Future<void> _showDocumentDialog(BuildContext context, int type) async {
    final documentType = await showDialog<int>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Seleccionar Fuente'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Desde la cámara'),
                onTap: () {
                  Navigator.of(context).pop(1); // Usar cámara
                  context.read<DocumentUploadProvider>().pickImageFromCamera(
                    type,
                  );
                },
              ),
              ListTile(
                title: const Text('Desde la galería'),
                onTap: () {
                  Navigator.of(context).pop(2); // Usar galería
                  context.read<DocumentUploadProvider>().pickImageFromGallery(
                    type,
                  );
                },
              ),
              ListTile(
                title: const Text('Seleccionar archivo'),
                onTap: () {
                  Navigator.of(context).pop(3); // Seleccionar archivo
                  context.read<DocumentUploadProvider>().pickFile(type);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
