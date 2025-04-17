import 'package:flutter/material.dart'; // Importa a biblioteca de widgets do Flutter.

void main() {
  runApp(TodoApp()); // Inicia o app chamando o widget TodoApp.
}

// Widget principal que define o MaterialApp
class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TodoScreen(), // Define a tela principal como TodoScreen.
    );
  }
}

// Tela principal com estado (pois o conteúdo muda com interações)
class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState(); // Cria o estado da tela.
}

// Estado da tela principal onde estão as tarefas e a lógica de filtro
class _TodoScreenState extends State<TodoScreen> {
  // Lista de tarefas, cada uma com um título e se está concluída ou não
  List<Map<String, dynamic>> tasks = [
    {'title': 'Tarefa 1', 'done': false},
    {'title': 'Tarefa 2', 'done': true},
    {'title': 'Tarefa 3', 'done': false},
    {'title': 'Tarefa 4', 'done': true},
    {'title': 'Tarefa 5', 'done': false},
    {'title': 'Tarefa 6', 'done': true},
  ];

  // Variável para controlar o filtro selecionado
  String filter = "todas";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar (barra superior do app)
      appBar: AppBar(
        title: Text('Lista de Tarefas'), // Título da AppBar
        actions: [Icon(Icons.notifications)], // Ícone de notificação no canto direito
      ),

      // Drawer: menu lateral com filtros de tarefas
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero, // Remove qualquer espaçamento interno padrão
          children: <Widget>[
            // Cabeçalho do menu lateral
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue), // Cor de fundo azul
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24), // Estilo do texto
              ),
            ),
            // Item para ver todas as tarefas
            ListTile(
              title: Text('Todas as Tarefas'),
              onTap: () {
                setState(() {
                  filter = "todas"; // Altera filtro para "todas"
                });
                Navigator.pop(context); // Fecha o Drawer
              },
            ),
            // Item para ver somente tarefas pendentes
            ListTile(
              title: Text('Tarefas pendentes'),
              onTap: () {
                setState(() {
                  filter = "pendentes"; // Altera filtro para "pendentes"
                });
                Navigator.pop(context);
              },
            ),
            // Item para ver somente tarefas concluídas
            ListTile(
              title: Text('Tarefas concluídas'),
              onTap: () {
                setState(() {
                  filter = "concluidas"; // Altera filtro para "concluídas"
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

      // Corpo principal da tela
      body: Column(
        children: [
          // Título da seção de tarefas
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Todas as Tarefas',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),

          // Lista de tarefas visível na tela
          Expanded(
            child: ListView(
              children: tasks
                  .where((task) {
                    // Aplica o filtro conforme a seleção
                    if (filter == "pendentes") return !task['done'];
                    if (filter == "concluidas") return task['done'];
                    return true;
                  })
                  .map((task) => ListTile(
                        // Mostra o título da tarefa ou uma mensagem padrão se estiver vazio
                        title: Text(task['title']?.toString().isNotEmpty == true
                            ? task['title']
                            : 'Tarefa sem título'),
                        // Checkbox que marca/desmarca a tarefa
                        trailing: Checkbox(
                          value: task['done'], // Define se está marcada
                          onChanged: (bool? value) {
                            setState(() {
                              task['done'] = value; // Atualiza o status da tarefa
                            });
                          },
                        ),
                      ))
                  .toList(), // Transforma os itens em uma lista de widgets
            ),
          ),

          // Botão para navegar para a tela de infográfico
          Padding(
            padding: EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Navega para a tela InfograficoScreen ao clicar
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InfograficoScreen()),
                );
              },
              child: Text('Infográfico'), // Texto do botão
            ),
          ),
        ],
      ),
    );
  }
}

// Tela do infográfico com cards em formato de grade
class InfograficoScreen extends StatelessWidget {
  // Lista com os textos que serão exibidos em cada card
  final List<String> textosInfografico = [
    'Tarefas concluídas do mês: 30',
    'Tarefas pendentes do mês: 15',
    'Todas as tarefas do mês: 20',
    'Média de tarefas por dia: 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Corpo da tela com espaçamento
      body: Padding(
        padding: const EdgeInsets.all(12.0), // Espaço ao redor do grid
        child: GridView.count(
          crossAxisCount: 2, // Número de colunas no grid (2 por linha)
          crossAxisSpacing: 10, // Espaço entre colunas
          mainAxisSpacing: 10, // Espaço entre linhas

          // Geração automática dos cards com base na lista de textos
          children: List.generate(textosInfografico.length, (index) {
            return Card(
              color: Colors.blueAccent, // Cor de fundo do card
              child: Center(
                // Texto centralizado dentro do card
                child: Text(
                  textosInfografico[index], // Pega o texto da lista
                  textAlign: TextAlign.center, // Centraliza o texto
                  style: TextStyle(color: Colors.white, fontSize: 18), // Estilo do texto
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
