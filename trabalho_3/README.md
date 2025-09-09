# Trabalho 3 – Computação Móvel

## Desenvolvedores
*Este projeto foi desenvolvido por:*
- [Eduardo Cansian Rodrigues](https://github.com/EduardoCansian)
- [João Victor Marcarini Pegoretti](https://github.com/joaovictorPegoretti)
- [Samuel Thompson Barbosa](https://github.com/samuel-tb)

---

## Descrição
[cite_start]Este projeto é um aplicativo **Flutter** desenvolvido para a disciplina de **Computação Móvel**[cite: 22]. [cite_start]Ele faz parte da **Parte 3** da Avaliação Processual do 1º Bimestre, com o objetivo de transformar uma aplicação que exibe dados estáticos em um aplicativo dinâmico e interativo[cite: 38, 41]. [cite_start]A atenção principal foi voltada para o gerenciamento de estado[cite: 39].

---

## Estrutura do Projeto
- **`lib/main.dart`** → Arquivo principal com a lógica e a interface da aplicação.
- [cite_start]**`windows/CMakeLists.txt`** → Configurações do projeto para a plataforma Windows[cite: 93].
- [cite_start]**`linux/CMakeLists.txt`** → Configurações do projeto para a plataforma Linux[cite: 1, 10].
- [cite_start]**`android/build.gradle.kts`** → Configurações do projeto para a plataforma Android[cite: 92].
- **`.gitignore`** → Arquivo que gerencia os arquivos e diretórios que o Git deve ignorar, como `build/` e `.dart_tool/`.

---

## Funcionalidades Implementadas
[cite_start]O funcionamento da aplicação segue a evolução dos requisitos do trabalho[cite: 36, 40]:

1.  [cite_start]**Conversão do Widget**: O widget principal foi modificado de um `StatelessWidget` para um **`StatefulWidget`**[cite: 48], permitindo que o estado da aplicação seja alterado.
2.  [cite_start]**Adição de Interatividade**: Um botão interativo, como um **`FloatingActionButton`** ou **`ElevatedButton`**, foi incluído na interface[cite: 49].
3.  [cite_start]**Lógica de Estado**: Uma função foi implementada para o botão que, ao ser pressionada, realiza uma ação de modificação na lista de dados, como adicionar um novo item, remover o primeiro item ou alterar a ordem dos elementos[cite: 50, 51].
4.  [cite_start]**Atualização da UI**: O método **`setState()`** foi utilizado para notificar o framework de que houve uma mudança no estado, garantindo que a tela seja redesenhada para refletir a alteração nos dados[cite: 52].
5.  [cite_start]**Refinamento Visual**: A exibição dos dados na tela foi aprimorada utilizando widgets como **`Card`** ou **`ListTile`** para cada item da lista[cite: 53].

---

## Lógica de Gerenciamento de Estado
O **`StatefulWidget`** é a base para o gerenciamento de estado neste projeto. Ele permite que o estado da aplicação seja mutável, ao contrário do `StatelessWidget`. A lógica funciona da seguinte forma: quando a ação do botão é acionada (e.g., um novo item é adicionado), os dados internos do estado são alterados, e a chamada ao método **`setState()`** informa ao Flutter que o estado mudou. O framework, então, reconstrói apenas os widgets que dependem desse estado, garantindo uma atualização reativa e eficiente da interface do usuário. [cite_start]Esta é a essência do gerenciamento de estado no Flutter[cite: 75, 79].

---

## Como Executar
Para rodar a aplicação, siga os passos abaixo:

1.  Clone este repositório para sua máquina local.
2.  Abra o projeto no seu editor de código (ex: Visual Studio Code).
3.  Abra o terminal e verifique se o ambiente Flutter está configurado corretamente.
4.  Execute o comando `flutter run` para iniciar a aplicação em um emulador ou dispositivo físico.

---

### Captura de Tela

[cite_start]*(Adicione aqui uma nova captura de tela do aplicativo em execução, mostrando o botão e a interface refinada, conforme solicitado no trabalho.)* [cite: 66, 67]
