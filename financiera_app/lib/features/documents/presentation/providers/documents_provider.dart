import 'dart:io';
import 'package:financiera_app/features/documents/domain/documents_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
// Importa el servicio de documentos (ajusta la ruta según corresponda)

class DocumentUploadProvider extends ChangeNotifier {
  final DocService docService = DocService();
  // Documentos seleccionados
  XFile? frontImage;
  XFile? backImage;
  XFile? passportImage;
  XFile? proofAddressImage;
  XFile? constanciaImage;

  bool isLoading = false;

  // Función para actualizar un documento
  void updateDocument(int type, XFile image) {
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
    notifyListeners();
  }

  // Función para seleccionar una imagen desde la cámara
  Future<void> pickImageFromCamera(int type) async {
    final XFile? image = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 25,
    );
    if (image != null) {
      updateDocument(type, image);
    }
  }

  // Función para seleccionar una imagen desde la galería
  Future<void> pickImageFromGallery(int type) async {
    final XFile? image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 25,
    );
    if (image != null) {
      updateDocument(type, image);
    }
  }

  // Función para seleccionar un archivo desde el sistema de archivos
  Future<void> pickFile(int type) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
    );
    if (result != null) {
      File file = File(result.paths.first!);
      final XFile xFile = XFile(file.path);
      updateDocument(type, xFile);
    }
  }

  // Función para simular la subida de documentos
  Future<void> uploadDocuments() async {
    isLoading = true;
    notifyListeners();

    // Aquí iría la lógica para subir los documentos (simulación)
    await Future.delayed(const Duration(seconds: 2));

    // Al finalizar el proceso de subida
    isLoading = false;
    notifyListeners();
  }

  Future<void> getDocuments(int clientId) async {
    isLoading = true;
    notifyListeners();

    final reqDocs = await docService.getRequiredDocuments();
    final docs = await docService.getDocuments(clientId);

    
    // Al finalizar el proceso de obtención
    isLoading = false;
    notifyListeners();
  }
}
