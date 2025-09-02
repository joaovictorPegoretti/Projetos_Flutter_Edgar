# Trabalho 1 – RPG do Playnium

## Descrição
Este projeto foi desenvolvido em **Dart** como parte do Trabalho 1.  
O objetivo é simular um sistema de gerenciamento de jogadores em um RPG fictício chamado *Playnium*.  
O programa gera jogadores aleatórios e oferece um menu interativo no terminal, permitindo consultar informações e estatísticas sobre eles.

---

## Estrutura do Projeto
- **[Main.Dart](./Main.Dart)** → Arquivo principal com a lógica do programa e o menu interativo.
- **[Classe/Jogador.Dart](./Classe/Jogador.Dart)** → Classe `Jogador`, que define os atributos e métodos de cada jogador.

---

## Classe e Atributos

### [Classe: `Jogador`](./Classe/Jogador.Dart)
Representa um jogador do RPG, com os seguintes atributos:

- `nome` (*String*): Nome do jogador.  
- `nivel` (*int*): Nível atual do jogador.  
- `classe` (*String*): Classe escolhida (ex.: Guerreiro, Mago, Ninja).  
- `plataforma` (*String*): Plataforma utilizada (ex.: PlayStation, PC, Xbox).  
- `idade` (*int*): Idade do jogador.  

**Método principal:**
- `dadosJogador()`: Exibe as informações do jogador no console de forma formatada.

---

## Lógica Implementada
O funcionamento do programa segue os seguintes passos:

1. **Geração de jogadores:**  
   - São criados **7 jogadores aleatórios** a partir de listas pré-definidas de nomes, níveis, classes, plataformas e idades.

2. **Menu interativo:**  
   O usuário pode escolher entre as opções:
   - Listar todos os jogadores.
   - Mostrar o jogador com maior e menor nível.
   - Verificar nomes repetidos entre os jogadores.
   - Descobrir qual classe possui mais jogadores.
   - Identificar as plataformas mais utilizadas.
   - Classificar jogadores em adultos, adolescentes e crianças.
   - Encerrar o programa.

3. **Execução contínua:**  
   - Após cada ação, o sistema pergunta se o usuário deseja retornar ao menu.  
   - Caso a resposta seja "n", o programa finaliza com uma mensagem de agradecimento.

## Como Executar
O usuário ao abrir o Visual Studio Code, deve abrir o terminal e inserir o comando abaixo:

``` dart run main.dart ```

Após essa etapa, será mostrado o menu de interação. Nesse menu será informado as opções que você pode inserir para que seja feito as ações desejada.

Segue abaixo um GIF mostrando todo o passo a passo:

![Passo_a_Passo Trabalho 1](https://github.com/user-attachments/assets/d9ccee21-2873-48e1-b89a-aa7753311151)
