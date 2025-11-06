# Trabalho 5 – Gerenciamento de Estado e Funcionalidades

---

## 1. Gerenciamento de Estado

### Biblioteca Escolhida e Justificativa

A biblioteca de gerenciamento de estado escolhida para este projeto foi a **Provider**.

A escolha foi justificada pelos seguintes motivos:

* **Simplicidade e Integração:** O `Provider` é a abordagem recomendada pelo Google para gerenciamento de estado de forma simples e reativa, sendo totalmente integrado ao ecossistema Flutter.
* **Padrão `ChangeNotifier`:** Utilizamos o `ChangeNotifier` (ex: `JogadorProvider` e `GuildaProvider`), que oferece uma forma direta e eficiente de encapsular a lógica de negócios e notificar a UI sobre mudanças (via `notifyListeners()`), sem a complexidade (boilerplate) de outras bibliotecas como o BLoC.
* **Injeção de Dependência:** O `MultiProvider` (utilizado no `main.dart`) permite injetar os *providers* de forma limpa na árvore de widgets, tornando o estado acessível a todas as telas filhas que precisarem dele.

### Conexão entre Repositório e UI

A conexão entre a camada de dados (Repositório) e a interface (UI) foi implementada seguindo o fluxo abaixo:

1.  **Repositório (Camada de Dados):** As classes `Dadosjogador` e `Dadosguilda` atuam como Repositórios. Elas são as únicas que se comunicam com o banco de dados (`Banco/Config.dart`).
2.  **Provider (Notifier):** As classes `JogadorProvider` e `GuildaProvider` (`extends ChangeNotifier`) encapsulam a lógica. Elas possuem uma instância do Repositório (ex: `final Dadosjogador _jogadorRepository = Dadosjogador();`).
3.  **Fluxo de Dados:**
    * A **UI** (ex: `MenuScreen` ou `TelaListagemGuildas`) "escuta" o provider usando um `Consumer` ou `Provider.of(context)`.
    * Quando a UI precisa de dados (ex: no `initState`), ela chama um método no provider (ex: `provider.carregarJogadores()`).
    * O **Provider** marca seu estado como "carregando" (`_isLoading = true; notifyListeners();`), chama o método do **Repositório** (ex: `_jogadorRepository.listarTodos();`), recebe os dados, atualiza sua lista interna (`_jogadores = ...`), e chama `notifyListeners()` novamente.
    * O `Consumer` na UI recebe a notificação, vê que a lista foi atualizada e reconstrói apenas o `ListView` para exibir os dados.
4.  **Ações (Salvar/Deletar):**
    * A UI (ex: `FormularioJogadorScreen`) chama o provider (ex: `provider.salvarJogador(novoJogador)`).
    * O Provider chama o Repositório (ex: `_jogadorRepository.salvar(novoJogador)`).
    * Após salvar, o Provider chama seu próprio método `carregarJogadores()` para buscar a lista atualizada do banco, garantindo que a UI sempre reflita o estado real da persistência.

---

## 2. Navegação

### Rotas Criadas

O projeto não utiliza rotas nomeadas (ex: `'/edicao'`), mas sim a navegação direta entre telas usando `MaterialPageRoute`. As principais rotas de navegação são:

* `MenuScreen` (home): A tela principal que lista os `Jogadores`.
* `TelaListagemGuildas`: Acessada pelo ícone de "Escudo" na AppBar, lista as `Guildas`.
* `FormularioJogadorScreen`: Tela de formulário para criar ou editar um `Jogador`.
* `FormularioGuildaScreen`: Tela de formulário para criar ou editar uma `Guilda`.

### Passagem de Argumentos para Edição

A passagem de argumentos para a Tela de Edição é feita através do **construtor do widget**.

1.  Na tela de listagem (ex: `MenuScreen`), ao tocar em um item, o `onTap` captura o objeto completo daquele item (ex: `final jogador = jogadores[index]`).
2.  Este objeto é passado diretamente como argumento no construtor do `MaterialPageRoute`:
    ```dart
    Navigator.push(
      context,
      MaterialPageRoute(
        // O objeto 'jogador' é passado aqui
        builder: (context) => FormularioJogadorScreen(jogador: jogador),
      ),
    );
    ```
3.  Na `FormularioJogadorScreen`, o widget recebe o objeto:
    ```dart
    final Jogador? jogador;
    const FormularioJogadorScreen({super.key, this.jogador});
    ```
4.  No método `initState` do formulário, verificamos se `widget.jogador` não é nulo. Se não for (ou seja, é uma edição), usamos os dados desse objeto para preencher os `TextEditingControllers` do formulário.

---

## 3. Funcionalidades

Abaixo estão os GIFs que demonstram as funcionalidades de CRUD e gerenciamento de estado.

*(Nota: O código demonstra que a lista é carregada do Provider, os formulários recebem o objeto no construtor e a exclusão é feita via Dismissible, que chama o Provider).*

### 1. A Lista sendo carregada corretamente
*(Demonstração do `Consumer<JogadorProvider>` exibindo um `CircularProgressIndicator` enquanto `isLoading` é verdadeiro e, em seguida, exibindo o `ListView` quando os dados são carregados do banco).*

`[COLE AQUI SEU GIF/IMAGEM DA LISTA SENDO CARREGADA]`

### 2. A Tela de Edição sendo aberta com dados preenchidos
*(Demonstração do fluxo de clicar em um item `Jogador` na `MenuScreen`, o que chama `Navigator.push` passando o objeto `jogador` para o construtor do `FormularioJogadorScreen`, que por sua vez preenche os campos do formulário no `initState`).*

`[COLE AQUI SEU GIF/IMAGEM CLICANDO EM UM ITEM E ABRINDO O FORMULÁRIO PREENCHIDO]`

### 3. A funcionalidade de Exclusão em ação
*(Demonstração do widget `Dismissible` na `MenuScreen`. Ao arrastar um card para a esquerda, o `onDismissed` é acionado, chamando `_deletarJogador()`. Esta função chama `Provider.of<JogadorProvider>().deletarJogador(id)`, que remove do banco e atualiza a lista na UI).*

`[COLE AQUI SEU GIF/IMAGEM DA EXCLUSÃO DE UM ITEM]`

---

## Desenvolvedores

- [Eduardo Cansian Rodrigues](https://github.com/EduardoCansian)
- [João Victor Marcarini Pegoretti](https://github.com/joaovictorPegoretti)
- [Samuel Thompson Barbosa](https://github.com/samuel-tb)

---
