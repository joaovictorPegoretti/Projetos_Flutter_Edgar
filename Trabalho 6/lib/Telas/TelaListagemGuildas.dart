// lib/Telas/TelaListagemGuildas.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Modelos/Guilda.dart';
import '../Providers/GuildaProvider.dart';
import 'FormularioGuilda.dart';

class TelaListagemGuildas extends StatelessWidget {
  const TelaListagemGuildas({super.key});

  // Função para navegar para o formulário (adicionar ou editar)
  void _abrirFormularioGuilda(BuildContext context, [Guilda? guilda]) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormularioGuildaScreen(guilda: guilda),
      ),
    );
  }

  // Função para deletar
  void _deletarGuilda(BuildContext context, Guilda guilda) async {
    try {
      await Provider.of<GuildaProvider>(
        context,
        listen: false,
      ).deletarGuilda(guilda.id!);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${guilda.nome} foi deletada com sucesso.'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao deletar ${guilda.nome}.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar Guildas'),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
      ),
      body: Consumer<GuildaProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final guildas = provider.guildas;

          if (guildas.isEmpty) {
            return const Center(
              child: Text("Nenhuma guilda encontrada. Adicione uma nova!"),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: guildas.length,
            itemBuilder: (context, index) {
              final guilda = guildas[index];

              return Dismissible(
                key: Key(guilda.id.toString()),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (direction) {
                  _deletarGuilda(context, guilda);
                },
                child: Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueGrey[100],
                      child: Text(guilda.tag), // Mostra a TAG da guilda
                    ),
                    title: Text(guilda.nome),
                    subtitle: Text(
                      "Líder: ${guilda.lider} | Servidor: ${guilda.servidor}",
                    ),
                    onTap: () {
                      _abrirFormularioGuilda(
                        context,
                        guilda,
                      ); // Abre para Edição
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _abrirFormularioGuilda(context); // Abre para Adicionar
        },
        tooltip: 'Adicionar nova guilda',
        backgroundColor: Colors.blueGrey,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
