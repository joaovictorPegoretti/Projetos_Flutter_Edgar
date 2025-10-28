# Trabalho 4 – Camada de Dados e Persistência

Este projeto foi desenvolvido como parte da disciplina **Computação Móvel (8º Período - Multivix)**, sob orientação do professor **Edgard da Cunha Pontes**.  
O objetivo principal foi implementar a **camada de dados com persistência local** em Flutter, aplicando o **padrão Repository** para isolar o acesso ao banco de dados da interface do usuário.

---

## Objetivo

Migrar uma aplicação Flutter que antes utilizava listas em memória para uma solução com **persistência de dados local**, garantindo que as informações sejam salvas e recuperadas mesmo após o fechamento do aplicativo.  

O projeto foi implementado utilizando o banco **SQLite** através da biblioteca **`sqflite`**.

---

## Estrutura do Projeto

A aplicação foi dividida em camadas para facilitar a manutenção e a compreensão do código:

```
Trabalho 4/
├── lib/
│   ├── Banco/
│   │   └── Config.dart
│   ├── Dados/
│   │   ├── DadosGuilda.dart
|   |   └── DadosJogador.dart
│   ├── Modelos/
│   │   ├── Guilda.dart
│   │   └── Jogador.dart
│   ├── Telas/
│   |   ├── FormularioGuilda.dart
│   |   └── FormularioJogador.dart
|   ├── main.dart
├── pubspec.yaml
```

---

## Modelagem de Dados

O projeto trabalha com **dois conceitos principais**: `Categoria` e `Produto`.

### Classe `Categoria`
Representa o tipo de produto e contém:
- `id` (int)
- `nome` (String)
- `descricao` (String)

### Classe `Produto`
Representa o item comercial e contém:
- `id` (int)
- `nome` (String)
- `preco` (double)
- `quantidade` (int)
- `categoriaId` (int)

Ambas as classes incluem métodos de conversão entre **Map** e **Objeto Dart**, permitindo a integração com o banco SQLite.

---

## Persistência de Dados

A persistência foi implementada com a biblioteca **[sqflite](https://pub.dev/packages/sqflite)**, que oferece suporte a operações CRUD (Create, Read, Update e Delete) utilizando o banco **SQLite** local.

A classe `DatabaseHelper` é responsável por:
- Criar o banco de dados (`app_database.db`);
- Definir as tabelas `categorias` e `produtos`;
- Gerenciar a conexão com o SQLite.

```dart
final db = await openDatabase(
  'app_database.db',
  version: 1,
  onCreate: (db, version) {
    db.execute('CREATE TABLE categorias(id INTEGER PRIMARY KEY, nome TEXT, descricao TEXT)');
    db.execute('CREATE TABLE produtos(id INTEGER PRIMARY KEY, nome TEXT, preco REAL, quantidade INTEGER, categoriaId INTEGER)');
  },
);
```

---

## Camada de Repositórios

A lógica de persistência foi isolada em **repositórios**, garantindo que a camada de interface (UI) não acesse o banco diretamente.

### `CategoriaRepository`
Contém os métodos:
- `Future<void> inserirCategoria(Categoria categoria)`
- `Future<List<Categoria>> listarCategorias()`

### `ProdutoRepository`
Contém os métodos:
- `Future<void> inserirProduto(Produto produto)`
- `Future<List<Produto>> listarProdutos()`

Os métodos utilizam `async` e `await` para acesso assíncrono ao banco, evitando travamentos na interface do aplicativo.

---

## Execução do Projeto

### Pré-requisitos
- Flutter instalado e configurado.
- Dependências listadas no `pubspec.yaml` (instaladas via `flutter pub get`).

### Passos para executar
1. Clone o repositório:
   ```bash
   git clone https://github.com/joaovictorPegoretti/Projetos_Flutter_Edgar
   ```
2. Acesse a pasta do projeto:
   ```bash
   cd "Projetos_Flutter_Edgar/Trabalho 4"
   ```
3. Instale as dependências:
   ```bash
   flutter pub get
   ```
4. Execute o aplicativo:
   ```bash
   flutter run
   ```

---

## Funcionamento Geral

1. O aplicativo inicia carregando as categorias e produtos salvos no banco.  
2. O usuário pode **cadastrar novas categorias e produtos**.  
3. Os dados são **armazenados localmente no SQLite**.  
4. Ao reabrir o app, os registros persistem, comprovando o funcionamento da camada de persistência.

---

## Dependências Principais

```yaml
dependencies:
  flutter:
    sdk: flutter
  sqflite: ^2.0.0+4
  path: ^1.8.0
```

---

## Teste de Persistência

Durante os testes, foi verificado que:
- As inserções são salvas corretamente no banco local;
- A leitura retorna as listas de categorias e produtos completas;
- O uso de `async/await` garante operações não bloqueantes.

Trecho de teste simples via console:
```dart
void main() async {
  final repo = ProdutoRepository();
  await repo.inserirProduto(Produto(nome: "Notebook", preco: 4500.0, quantidade: 5, categoriaId: 1));
  final produtos = await repo.listarProdutos();
  produtos.forEach((p) => print(p.nome));
}
```

---

## Desenvolvedores

- [Eduardo Cansian Rodrigues](https://github.com/EduardoCansian)
- [João Victor Marcarini Pegoretti](https://github.com/joaovictorPegoretti)
- [Samuel Thompson Barbosa](https://github.com/samuel-tb)
