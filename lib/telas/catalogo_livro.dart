import 'package:flutter/material.dart';

void main() {
  runApp(const LivrariaApp());
}

class LivrariaApp extends StatelessWidget {
  const LivrariaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Livraria Central',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.red),
      home: const Telalogin(),
    );
  }
}

class Telalogin extends StatefulWidget {
  const Telalogin({super.key});

  @override
  State<Telalogin> createState() => _TelaloginState();
}

class _TelaloginState extends State<Telalogin> {
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  void _login() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const TelaHome()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: const Text('Bem-vindos à Livraria Central'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Text(
              'Livraria Central',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _usuarioController,
              decoration: const InputDecoration(labelText: 'Usuário'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _senhaController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Senha'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: _login, child: const Text("Entrar")),
          ],
        ),
      ),
    );
  }
}

class Livro {
  final String titulo;
  final String autor;
  final String descricao;
  final String genero;
  final String ano;
  final String avaliacao;

  Livro({
    required this.titulo,
    required this.autor,
    required this.descricao,
    required this.genero,
    required this.ano,
    required this.avaliacao,
  });
}

class TelaHome extends StatefulWidget {
  const TelaHome({super.key});

  @override
  State<TelaHome> createState() => _TelaHomeState();
}

class _TelaHomeState extends State<TelaHome> {
  final List<Livro> livros = [
    Livro(
      titulo: 'O Pequeno Príncipe',
      autor: 'Antoine de Saint-Exupéry',
      descricao: 'Uma história encantadora sobre amizade e amor.',
      genero: 'Ficção',
      ano: '1943',
      avaliacao: '5',
    ),
    Livro(
      titulo: '1984',
      autor: 'George Orwell',
      descricao: 'Romance distópico sobre controle e liberdade.',
      genero: 'Distopia',
      ano: '1949',
      avaliacao: '5',
    ),
  ];

  void _adicionarLivro() async {
    final novoLivro = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TelaAdicionarLivro()),
    );

    if (novoLivro != null && novoLivro is Livro) {
      setState(() {
        livros.add(novoLivro);
      });
    }
  }

  void _mostrarDetalhes(Livro livro) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TelaDetalhesLivro(livro: livro)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo de Livros'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Voltar para o Login',
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const Telalogin()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: livros.length,
        itemBuilder: (context, index) {
          final livro = livros[index];
          return Card(
            child: ListTile(
              title: Text(livro.titulo),
              subtitle: Text("Autor: ${livro.autor}"),
              leading: const Icon(Icons.book, color: Colors.red),
              onTap: () => _mostrarDetalhes(livro),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _adicionarLivro,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TelaAdicionarLivro extends StatefulWidget {
  const TelaAdicionarLivro({super.key});

  @override
  State<TelaAdicionarLivro> createState() => _TelaAdicionarLivroState();
}

class _TelaAdicionarLivroState extends State<TelaAdicionarLivro> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titulo = TextEditingController();
  final TextEditingController autor = TextEditingController();
  final TextEditingController descricao = TextEditingController();
  final TextEditingController genero = TextEditingController();
  final TextEditingController ano = TextEditingController();
  final TextEditingController avaliacao = TextEditingController();

  void _salvar() {
    if (_formKey.currentState!.validate()) {
      final livro = Livro(
        titulo: titulo.text,
        autor: autor.text,
        descricao: descricao.text,
        genero: genero.text,
        ano: ano.text,
        avaliacao: avaliacao.text,
      );
      Navigator.pop(context, livro);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar Livro')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: titulo,
                decoration: const InputDecoration(labelText: 'Título'),
                validator:
                    (value) => value!.isEmpty ? 'Informe o título' : null,
              ),
              TextFormField(
                controller: autor,
                decoration: const InputDecoration(labelText: 'Autor'),
                validator: (value) => value!.isEmpty ? 'Informe o autor' : null,
              ),
              TextFormField(
                controller: descricao,
                decoration: const InputDecoration(labelText: 'Descrição'),
              ),
              TextFormField(
                controller: genero,
                decoration: const InputDecoration(labelText: 'Gênero'),
              ),
              TextFormField(
                controller: ano,
                decoration: const InputDecoration(
                  labelText: 'Ano de Publicação',
                ),
              ),
              TextFormField(
                controller: avaliacao,
                decoration: const InputDecoration(labelText: 'Avaliação (1-5)'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _salvar, child: const Text('Salvar')),
            ],
          ),
        ),
      ),
    );
  }
}

class TelaDetalhesLivro extends StatelessWidget {
  final Livro livro;

  const TelaDetalhesLivro({super.key, required this.livro});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(livro.titulo)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Autor: ${livro.autor}', style: const TextStyle(fontSize: 18)),
            Text('Ano: ${livro.ano}', style: const TextStyle(fontSize: 18)),
            Text(
              'Gênero: ${livro.genero}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Avaliação: ${livro.avaliacao}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 12),
            Text(
              'Descrição:\n${livro.descricao}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
