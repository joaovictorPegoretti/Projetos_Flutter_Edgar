# Trabalho 2 – RPG do Playnium - Primeira Interface do Usuário

## Desenvolvedores
- [Eduardo Cansian Rodrigues](https://github.com/EduardoCansian)
- [João Victor Marcarini Pegoretti](https://github.com/joaovictorPegoretti)
- [Samuel Thompson Barbosa](https://github.com/samuel-tb)

---

## Descrição
Esta etapa dá continuidade ao projeto inicial. O objetivo é criar a primeira interface de usuário para o aplicativo, conectando a lógica de dados já implementada a uma estrutura visual simples. A aplicação de console da Parte 1 foi transformada em uma aplicação Flutter funcional que exibe os dados em uma tela.

---

## Estrutura do Projeto
- **[main.dart](./lib/main.dart):** Arquivo principal que foi reestruturado para o template padrão do Flutter (`runApp`, `MaterialApp`, etc.). Ele agora contém a lógica de exibição da interface.
- **[jogador.dart](./lib/Jogador.dart):** A classe Jogador e a lista de dados da Parte 1 foram mantidas e integradas à inicialização da aplicação.

---

## Lógica Implementada na UI
- **Reestruturação:** A lógica de geração de jogadores foi adaptada para ser utilizada dentro da aplicação Flutter.
- **Construção da UI:** Um `StatelessWidget` foi criado para exibir os dados da lista de jogadores.
- **Widgets de Layout:** A interface utiliza `Scaffold` e `AppBar`. A exibição da lista de jogadores é feita através do widget ListView.

---

## Captura de Tela
<img width="1913" height="978" alt="image" src="https://github.com/user-attachments/assets/455a315a-ac46-410b-9c6d-0a825ab17aa0" />

