import 'package:financiera_app/features/login/domain/user_model.dart';
import 'package:flutter/material.dart';


class Cliente {
  final String nombre;
  final String telefono;
  final String direccion;
  bool archivado;
  bool tieneDocumentos;

  Cliente({
    required this.nombre,
    required this.telefono,
    required this.direccion,
    this.archivado = false,
    this.tieneDocumentos = false,
  });
}

class HomeScreen extends StatefulWidget {
  final UserModel? user;
  const HomeScreen({ Key? key, this.user }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Cliente> clientes = [
    Cliente(
        nombre: 'Juan Pérez',
        telefono: '555-123-4567',
        direccion: 'Av. Reforma 123',
        tieneDocumentos: true),
    Cliente(
        nombre: 'María López',
        telefono: '555-987-6543',
        direccion: 'Calle Hidalgo 321'),
  ];

  void _agregarCliente() {
    setState(() {
      clientes.add(
        Cliente(
          nombre: 'Nuevo Cliente',
          telefono: '555-000-0000',
          direccion: 'Dirección genérica',
        ),
      );
    });
  }

  void _editarCliente(int index) {
    setState(() {
      clientes[index] = Cliente(
        nombre: '${clientes[index].nombre} (Editado)',
        telefono: clientes[index].telefono,
        direccion: clientes[index].direccion,
        tieneDocumentos: clientes[index].tieneDocumentos,
      );
    });
  }

  void _eliminarCliente(int index) {
    if (!clientes[index].tieneDocumentos) {
      setState(() {
        clientes.removeAt(index);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se puede eliminar: tiene documentos')),
      );
    }
  }

  void _archivarCliente(int index) {
    setState(() {
      clientes[index].archivado = true;
    });
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gestión de Clientes')),
      floatingActionButton: FloatingActionButton(
        onPressed: _agregarCliente,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: clientes.length,
        itemBuilder: (context, index) {
          final cliente = clientes[index];
          return Card(
            child: ListTile(
              title: Text(cliente.nombre),
              subtitle: Text(
                  'Tel: ${cliente.telefono}\nDir: ${cliente.direccion}'),
              trailing: PopupMenuButton<String>(
                onSelected: (value) {
                  switch (value) {
                    case 'Editar':
                      _editarCliente(index);
                      break;
                    case 'Eliminar':
                      _eliminarCliente(index);
                      break;
                    case 'Archivar':
                      _archivarCliente(index);
                      break;
                  }
                },
                itemBuilder: (_) => [
                  const PopupMenuItem(value: 'Editar', child: Text('Editar')),
                  const PopupMenuItem(value: 'Eliminar', child: Text('Eliminar')),
                  const PopupMenuItem(value: 'Archivar', child: Text('Archivar')),
                ],
              ),
              tileColor: cliente.archivado ? Colors.grey[300] : null,
            ),
          );
        },
      ),
    );
  }
}