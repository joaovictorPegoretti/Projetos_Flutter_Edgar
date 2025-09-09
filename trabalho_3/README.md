# Trabalho 3 – RPG do Playnium - Interatividade e Estrutura de Estado

## Desenvolvedores

- [Eduardo Cansian Rodrigues](https://github.com/EduardoCansian)
- [João Victor Marcarini Pegoretti](https://github.com/joaovictorPegoretti)
- [Samuel Thompson Barbosa](https://github.com/samuel-tb)

---

## Descrição
Este projeto é um aplicativo **Flutter** desenvolvido para a disciplina de **Computação Móvel**.Ele faz parte da **Parte 3** da Avaliação Processual do 1º Bimestre, com o objetivo de transformar uma aplicação que exibe dados estáticos em um aplicativo dinâmico e interativo. A atenção principal foi voltada para o gerenciamento de estado.

---

## Estrutura do Projeto
- **[lib/main.dart](./lib/main.dart)** → Arquivo principal com a lógica e a interface da aplicação.
- **[windows/CMakeLists.txt](./windows/CMakeLists.txt)** → Configurações do projeto para a plataforma Windows.
- **[linux/CMakeLists.txt](./linux/CMakeLists.txt)** → Configurações do projeto para a plataforma Linux.
- **[android/build.gradle.kts](./android/build.gradle.kts)** → Configurações do projeto para a plataforma Android.
- **[.gitignore](.gitignore)** → Arquivo que gerencia os arquivos e diretórios que o Git deve ignorar, como `build/` e `.dart_tool/`.

---

## Funcionalidades Implementadas

- **Conversão do Widget**: O widget principal foi modificado de um `StatelessWidget` para um **`StatefulWidget`**, permitindo que o estado da aplicação seja alterado.
- **Adição de Interatividade**: Um botão interativo, como um **`FloatingActionButton`** ou **`ElevatedButton`**, foi incluído na interface.
- **Lógica de Estado**: Uma função foi implementada para o botão que, ao ser pressionada, realiza uma ação de modificação na lista de dados, como adicionar um novo item, remover o primeiro item ou alterar a ordem dos elementos.
- **Atualização da UI**: O método **`setState()`** foi utilizado para notificar o framework de que houve uma mudança no estado, garantindo que a tela seja redesenhada para refletir a alteração nos dados.
- **Refinamento Visual**: A exibição dos dados na tela foi aprimorada utilizando widgets como **`Card`** ou **`ListTile`** para cada item da lista.

---

## Lógica de Gerenciamento de Estado
O **`StatefulWidget`** é a base para o gerenciamento de estado neste projeto. Ele permite que o estado da aplicação seja mutável, ao contrário do `StatelessWidget`. A lógica funciona da seguinte forma: quando a ação do botão é acionada (e.g., um novo item é adicionado), os dados internos do estado são alterados, e a chamada ao método **`setState()`** informa ao Flutter que o estado mudou. O framework, então, reconstrói apenas os widgets que dependem desse estado, garantindo uma atualização reativa e eficiente da interface do usuário. Esta é a essência do gerenciamento de estado no Flutter.


### Captura de Tela


