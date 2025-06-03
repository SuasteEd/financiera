import 'package:financiera_app/features/home/domain/home_service.dart';
import 'package:financiera_app/features/home/domain/models/response/client_response.dart';
import 'package:financiera_app/features/home/presentation/add_client.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  List<ClientResponse> clients = [];
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    setState(() => isLoading = true);
    clients = (await HomeService().getClients()) ?? [];
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

  @override
  Widget build(BuildContext context) {
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
                      Expanded(
                        child: ListView.builder(
                          reverse: true,
                          itemCount: clients.length,
                          itemBuilder: (context, index) {
                            final client = clients[index];
                            return Card(
                              child: ListTile(
                                title: Text(client.name ?? ''),
                                subtitle: Text(
                                  'CURP: ${client.curp ?? ''}\nEmail: ${client.email ?? ''}\nTeléfono: ${client.phone ?? ''}',
                                ),
                                trailing: Text(
                                  'Estado: ${client.status ?? ''}',
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
