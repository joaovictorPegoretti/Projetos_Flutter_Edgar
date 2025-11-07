# Relatório da Parte 3: Qualidade de Software e Testes

---

## 1. Resultados dos Testes (flutter test)

Conforme solicitado, foi criada uma suíte de testes de unidade e de widget para validar a lógica de negócios e a interface do aplicativo.

A captura de tela abaixo comprova a execução bem-sucedida de todos os testes (`flutter test`), com todos passando "em verde".

![20251106-2322-40 8111034](https://github.com/user-attachments/assets/0a158886-7beb-4d6b-9575-cbc65c2f778b)

---

## 2. Descrição dos Testes Relevantes

De acordo com o requisito, detalhamos abaixo o teste de unidade mais complexo e o teste de widget mais relevante implementados.

### Teste de Unidade Mais Complexo: Atualização e Validação do Repositório (Update)

Este teste foi escolhido por ser mais complexo que um simples "salvar" ou "deletar", pois ele valida a integridade dos dados após uma modificação.

* **O que ele testa:** O teste valida o ciclo completo de "Update" no `Dadosjogador`. O fluxo é:
    1.  **Setup:** Um `Guilda` (pai) e um `Jogador` (filho) são salvos no banco de dados de teste em memória (conforme `Banco/Config.dart`).
    2.  **Act:** O objeto `Jogador` é modificado em memória (ex: `jogador.nivel = 99`). O método `repository.update(jogadorModificado)` é chamado.
    3.  **Assert:** O método `repository.listarTodos()` é chamado em seguida. O teste então verifica se a lista retornada contém o jogador com o `nivel 99`, provando que a alteração foi persistida corretamente no banco.

* **Por que ele é importante:** Este teste é crucial para a qualidade do software porque garante a **integridade dos dados**. Ele prova que uma edição feita pelo usuário no `FormularioJogadorScreen` não apenas é salva, mas sobrescreve *exatamente* o registro correto no banco, sem corromper outros dados e sem criar entradas duplicadas.

### Teste de Widget Mais Relevante: Interação com Formulário de Edição

Este teste valida a interação do usuário com o `FormularioJogadorScreen` ao editar um jogador existente.

* **O que ele testa:** O teste simula a abertura da tela de edição com dados pré-preenchidos e a interação do usuário.
    1.  **Setup:** "Bombamos" (`tester.pumpWidget`) o `FormularioJogadorScreen` dentro de um `MultiProvider` (para simular a app), passando um objeto `Jogador` mockado para o construtor (ex: `FormularioJogadorScreen(jogador: jogadorMock)`), que é a mesma lógica usada pela navegação do app.
    2.  **Act (Verificação Inicial):** Usando `find.text()`, o teste verifica se os `TextFormField` (Nome, Nível, etc.) foram preenchidos corretamente com os dados do `jogadorMock`.
    3.  **Act (Interação):** O teste simula a digitação do usuário em um campo (ex: `await tester.enterText(find.byType(TextFormField).first, 'Novo Nome');`).
    4.  **Assert:** O teste verifica se o valor do `TextFormField` foi de fato alterado para "Novo Nome".

* **Por que ele é importante:** Este teste é o mais relevante por validar a **conexão entre a navegação e o estado da UI**. Ele garante que a passagem de argumentos (o objeto `jogador` no construtor da tela) está funcionando e que o `initState` da tela de formulário está preenchendo os campos corretamente, o que é a base da funcionalidade de **Edição (Update)**.

---

## 3. Refatoração e Melhorias de "Clean Code"

O projeto foi revisado e diversas melhorias de "Clean Code" foram aplicadas:

* **Nomenclatura Clara e Consistente:** As variáveis, métodos e classes seguem um padrão consistente em português (ex: `carregarJogadores`, `_validadorCampoVazio`, `Dadosguilda`), facilitando a leitura e manutenção, conforme permitido.
* **Separação de Responsabilidades (SRP):** O código foi refatorado para manter uma separação estrita:
    * **Modelos** (`Modelos/`): Classes puras de dados (`Jogador`, `Guilda`).
    * **Repositórios** (`Dados/`): Classes (`Dadosjogador`) que lidam *exclusivamente* com o acesso ao banco (operações CRUD).
    * **Providers** (`Providers/`): Classes (`JogadorProvider`) que gerenciam o estado e a lógica de negócios, chamando os repositórios.
    * **Telas** (`Telas/`): Widgets que apenas reagem ao estado do Provider e capturam a entrada do usuário.
* **Uso de `const` para Otimização:** O modifier `const` foi aplicado em todos os widgets estáticos (ex: `const Icon(Icons.add)`, `const Text(...)`, `const SizedBox(...)`) para otimizar a performance de rebuild do Flutter, conforme a boa prática.
* **Remoção de Lógica das Telas:** Na Parte 2, as Telas (`FormularioJogadorScreen`) chamavam os Repositórios diretamente. Nesta fase, essa lógica foi movida para os `Providers`. O código antigo foi removido (e não apenas comentado), tornando os widgets de tela mais limpos e focados apenas na UI.
* **Validação Reutilizável:** Nos formulários, foram criados métodos específicos para validação (ex: `_validadorCampoVazio`, `_validadorCampoNumero`), evitando a repetição de lógica de `if/else` dentro da declaração dos `TextFormField`.
* **Gestão de Chaves Estrangeiras:** O banco foi configurado com `PRAGMA foreign_keys = ON` e `ON DELETE CASCADE` (`Banco/Config.dart`), garantindo a integridade referencial dos dados (ex: ao deletar uma Guilda, todos os seus Jogadores são automaticamente deletados pelo SQLite).

---

## Desenvolvedores

- [Eduardo Cansian Rodrigues](https://github.com/EduardoCansian)
- [João Victor Marcarini Pegoretti](https://github.com/joaovictorPegoretti)
- [Samuel Thompson Barbosa](https://github.com/samuel-tb)

---
