import 'package:financiera_app/core/widgets/custom_text_field.dart';
import 'package:financiera_app/features/home/domain/home_service.dart';
import 'package:financiera_app/features/home/domain/models/response/client_response.dart';
import 'package:financiera_app/features/home/presentation/add_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  List<ClientResponse> clients = [];
  List<ClientResponse> filteredClients = [];
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    setState(() => isLoading = true);
    clients = (await HomeService().getClients()) ?? [];
    filteredClients = clients;
    setState(() => isLoading = false);
    if (clients.isNotEmpty) {
      // Aquí puedes manejar la lista de clientes obtenida
      print('Clientes obtenidos: ${clients.length}');
    } else {
      print('Error al obtener los clientes');
    }
    await HomeService().getClients();
    setState(() {
      isLoading = false;
    });
  }

  void _filterClients(String query) {
    if (query.isEmpty) {
      filteredClients = clients;
    } else {
      filteredClients =
          clients.where((client) {
            return client.name?.toLowerCase().contains(query.toLowerCase()) ??
                false;
          }).toList();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('Clientes')),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                onRefresh: () {
                  init();
                  return Future.value();
                },
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: CustomTextFormField(
                          fillColor: Colors.white,
                          hintText: 'Buscar cliente',
                          haveHelperText: false,
                          prefixIcon: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Icon(CupertinoIcons.search),
                          ),
                          onChanged: (query) {
                            _filterClients(query);
                          },
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: filteredClients.length,
                          itemBuilder: (context, index) {
                            final client = filteredClients[index];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddClient(
                                      client: client,
                                    ),
                                  ),
                                );
                                // Aquí puedes manejar la acción al tocar un cliente
                                print('Cliente seleccionado: ${client.name}');
                              },
                              child: Card(
                                //Agregar botón
                                child: ListTile(
                                  title: Text(client.name ?? ''),
                                  subtitle: Text(
                                    'CURP: ${client.curp ?? ''}\nEmail: ${client.email ?? ''}\nTeléfono: ${client.phone ?? ''}',
                                  ),
                                  trailing: Text(
                                    'Estado: ${client.status ?? ''}',
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddClient()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
