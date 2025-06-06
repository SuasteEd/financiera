import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class DocumentUploadScreen extends StatefulWidget {
  const DocumentUploadScreen({super.key});

  @override
  _DocumentUploadScreenState createState() => _DocumentUploadScreenState();
}

class _DocumentUploadScreenState extends State<DocumentUploadScreen> {
  XFile? frontImage;
  XFile? backImage;
  XFile? passportImage;
  XFile? proofAddressImage;
  XFile? constanciaImage;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Subir Documentos")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            if (isLoading)
              const Center(child: CircularProgressIndicator())
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Seleccione el tipo de documento'),
                  const SizedBox(height: 20),
                  // Botones para elegir tipo de documento
                  _buildDocumentButton(1, 'Identificación oficial', passportImage),
                  _buildDocumentButton(2, 'CURP', frontImage),
                  // _buildDocumentButton(3, 'INE Reverso', backImage),
                  _buildDocumentButton(4, 'Comprobante de Domicilio', proofAddressImage),
                  _buildDocumentButton(5, 'Acta de nacimiento', constanciaImage),
                ],
              ),
          ],
        ),
      ),
    );
  }

  // Botón genérico para elegir archivo
  Widget _buildDocumentButton(int type, String label, XFile? imageFile) {
    return GestureDetector(
      onTap: () => _showDocumentDialog(type),
      child: ListTile(
        title: Text(label),
        trailing: imageFile != null
            ? Image.file(File(imageFile.path), width: 50, height: 50)
            : const Icon(Icons.add_a_photo),
      ),
    );
  }

  // Mostrar un diálogo para seleccionar el tipo de archivo
  Future<void> _showDocumentDialog(int type) async {
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
                onTap: () => _pickImageFromCamera(type),
              ),
              ListTile(
                title: const Text('Desde la galería'),
                onTap: () => _pickImageFromGallery(type),
              ),
              ListTile(
                title: const Text('Seleccionar archivo'),
                onTap: () => _pickFile(type),
              ),
            ],
          ),
        );
      },
    );

    if (documentType != null) {
      setState(() {
        // Actualiza los archivos según el tipo de documento
        switch (documentType) {
          case 1:
            passportImage = documentType as XFile?;
            break;
          case 2:
            frontImage = documentType as XFile?;
            break;
          case 3:
            backImage = documentType as XFile?;
            break;
          case 4:
            proofAddressImage = documentType as XFile?;
            break;
          case 5:
            constanciaImage = documentType as XFile?;
            break;
        }
      });
    }
  }

  // Seleccionar archivo desde la cámara
  Future<void> _pickImageFromCamera(int type) async {
    final XFile? image = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 25);
    if (image != null) {
      _updateDocument(type, image);
    }
  }

  // Seleccionar archivo desde la galería
  Future<void> _pickImageFromGallery(int type) async {
    final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 25);
    if (image != null) {
      _updateDocument(type, image);
    }
  }

  // Seleccionar archivo desde el sistema de archivos
  Future<void> _pickFile(int type) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result != null) {
      File file = File(result.paths.first!);
      final XFile xFile = XFile(file.path);
      _updateDocument(type, xFile);
    }
  }

  // Actualizar el archivo en el controlador correspondiente según el tipo de documento
  void _updateDocument(int type, XFile image) {
    setState(() {
      switch (type) {
        case 1:
          passportImage = image;
          break;
        case 2:
          frontImage = image;
          break;
        case 3:
          backImage = image;
          break;
        case 4:
          proofAddressImage = image;
          break;
        case 5:
          constanciaImage = image;
          break;
      }
    });
  }

  // Lógica para subir los archivos seleccionados
  Future<void> _uploadDocuments() async {
    setState(() {
      isLoading = true;
    });

    // Aquí iría la lógica para subir los archivos
    // Ejemplo: DocController().uploadDocument()

    // Al finalizar el proceso de subida
    setState(() {
      isLoading = false;
    });
  }
}
