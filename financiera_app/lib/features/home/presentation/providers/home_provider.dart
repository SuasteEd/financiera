import 'package:flutter/material.dart';
import 'package:financiera_app/features/home/domain/home_service.dart';
import 'package:financiera_app/features/home/domain/models/response/client_response.dart';

class HomeProvider extends ChangeNotifier {
  bool isLoading = false;
  List<ClientResponse> clients = [];
  List<ClientResponse> filteredClients = [];

  // Método para cargar los clientes
  Future<void> loadClients() async {
    isLoading = true;
    notifyListeners();

    clients = await HomeService().getClients() ?? [];
    filteredClients = clients;

    isLoading = false;
    notifyListeners();
  }

  // Método para filtrar los clientes
  void filterClients(String query) {
    if (query.isEmpty) {
      filteredClients = clients;
    } else {
      filteredClients = clients.where((client) {
        return client.name?.toLowerCase().contains(query.toLowerCase()) ?? false;
      }).toList();
    }
    notifyListeners();
  }
}
