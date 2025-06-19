import 'package:financiera_app/core/widgets/custom_text_field.dart';
import 'package:financiera_app/features/home/presentation/add_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:financiera_app/features/home/presentation/providers/home_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final homeProvider = Provider.of<HomeProvider>(context);

    return ChangeNotifierProvider(
      create: (_) => HomeProvider()..loadClients(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Clientes')),
        body: Consumer<HomeProvider>(
          builder: (context, homeProvider, child) {
            return homeProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                  onRefresh: () {
                    // Recargar los clientes
                    return homeProvider.loadClients();
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
                              homeProvider.filterClients(query);
                            },
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: homeProvider.filteredClients.length,
                            itemBuilder: (context, index) {
                              final client =
                                  homeProvider.filteredClients[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) =>
                                              AddClient(client: client),
                                    ),
                                  );
                                },
                                child: Card(
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
                );
          },
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
      ),
    );
  }
}
