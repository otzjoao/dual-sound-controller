# 🎧 Dual Sound Controller

<!-- TOC -->
<details>
<summary><strong>📋 Sumário</strong></summary>

- [Sobre o projeto](#-sobre-o-projeto)
- [Objetivos](#-objetivos)
- [Conceito](#-conceito)
- [BLE e áudio](#-ble-e-áudio)
- [Arquitetura](#️-arquitetura)
- [Interface atual](#-interface-atual)
  - [Tela inicial](#-tela-inicial)
- [Testes](#-testes)
- [Tecnologias](#️-tecnologias)
- [Ambiente de desenvolvimento](#-ambiente-de-desenvolvimento)
- [Como executar o projeto](#-como-executar-o-projeto)
- [Estrutura do projeto](#-estrutura-do-projeto)
- [Roadmap](#️-roadmap)
- [Controle de versão](#-controle-de-versão)
- [Contexto acadêmico](#-contexto-acadêmico)
- [Estado atual do projeto](#-estado-atual-do-projeto)
- [Próximo passo](#-próximo-passo)
- [Documentação](#-documentação)
- [Repositório](#-repositório)
- [Autor](#-autor)
- [Licença](#-licença)

</details>

---

Aplicativo mobile desenvolvido em **Flutter** com o objetivo de explorar o gerenciamento e controle de dispositivos de áudio Bluetooth/BLE a partir de uma única interface.

O projeto está sendo desenvolvido como estudo prático de **Flutter, Bluetooth Low Energy (BLE), arquitetura de aplicações mobile e integração com recursos nativos do Android/iOS**.

> ⚠️ **Status atual:** a interface inicial está implementada e testada. A comunicação Bluetooth/BLE e o controle efetivo de áudio ainda estão em desenvolvimento.

---

## 📌 Sobre o projeto

O Dual Sound Controller é um projeto acadêmico e experimental desenvolvido para estudar, na prática, conceitos de:

- Desenvolvimento mobile com Flutter
- Arquitetura de aplicações
- Comunicação Bluetooth/BLE
- Descoberta e gerenciamento de dispositivos
- Comunicação entre dispositivos
- Controle de características de dispositivos BLE
- Organização de código e separação de responsabilidades
- Testes automatizados
- Versionamento com Git e GitHub

A proposta final do projeto é permitir que o usuário visualize dispositivos compatíveis, estabeleça conexões e tenha uma interface centralizada para gerenciamento dos dispositivos de áudio.

---

## 🎯 Objetivos

### Objetivo geral

Desenvolver uma aplicação mobile capaz de gerenciar dispositivos de áudio através de uma interface unificada, explorando comunicação Bluetooth de baixa energia e os recursos disponíveis nas plataformas móveis.

### Objetivos específicos

- [ ] Criar uma interface mobile intuitiva
- [ ] Implementar descoberta de dispositivos Bluetooth/BLE
- [ ] Identificar dispositivos encontrados
- [ ] Permitir conexão e desconexão
- [ ] Organizar dispositivos conectados em uma interface central
- [ ] Investigar características e serviços BLE disponíveis
- [ ] Implementar controles compatíveis com os dispositivos
- [ ] Estudar possibilidades de sincronização de áudio
- [ ] Implementar testes automatizados
- [ ] Documentar a arquitetura e as decisões técnicas

---

## 🧠 Conceito

A ideia principal do Dual Sound é centralizar o gerenciamento de dispositivos de áudio em um único aplicativo.

A arquitetura planejada pode ser representada inicialmente da seguinte forma:

```text
                    ┌───────────────────┐
                    │   Dual Sound App  │
                    │      Flutter      │
                    └─────────┬─────────┘
                              │
                ┌─────────────┴─────────────┐
                │                           │
        ┌───────▼────────┐         ┌────────▼───────┐
        │ Bluetooth/BLE  │         │  Camada de     │
        │    Service     │         │     Áudio      │
        └───────┬────────┘         └────────┬───────┘
                │                           │
        ┌───────┴────────┐                  │
        │                │                  │
   ┌────▼─────┐    ┌─────▼────┐             │
   │ Dispositivo│    │Dispositivo│           │
   │    BLE #1 │    │   BLE #2 │             │
   └───────────┘    └──────────┘             │
```

A camada Bluetooth será responsável pela comunicação BLE, enquanto a camada de áudio será investigada separadamente devido às diferenças entre BLE, Bluetooth Classic e os mecanismos de saída de áudio das plataformas móveis.

---

## ⚠️ BLE e áudio

Um ponto importante do projeto é a diferença entre **Bluetooth Low Energy (BLE)** e os protocolos normalmente utilizados para transmissão de áudio Bluetooth.

O BLE pode ser utilizado para comunicação através de serviços e características GATT, porém isso não significa que uma aplicação Flutter possa simplesmente utilizar BLE para transmitir áudio para qualquer caixa de som Bluetooth convencional.

O pacote `flutter_blue_plus` pode ser utilizado para comunicação BLE, permitindo descobrir dispositivos, estabelecer conexões e trabalhar com serviços e características GATT.

Entretanto, isso **não significa que o aplicativo poderá enviar diretamente áudio para qualquer caixa Bluetooth através de BLE**.

O áudio Bluetooth convencional normalmente utiliza protocolos e perfis específicos, como A2DP, que possuem integração diferente com o sistema operacional.

Por isso, o projeto trata duas áreas de forma separada:

```text
Bluetooth/BLE
      │
      ├── Descoberta
      ├── Conexão
      ├── Serviços
      └── Características
      
Áudio
      │
      ├── Saída de áudio
      ├── Bluetooth Classic / A2DP
      ├── Sincronização
      └── Recursos específicos de cada plataforma
```

A investigação dessa segunda camada faz parte do desenvolvimento do projeto.

---

## 🏗️ Arquitetura

A estrutura do projeto foi organizada para separar interface, modelos e serviços.

```text
dual_sound_controller/
│
├── android/
├── ios/
├── lib/
│   ├── main.dart
│   │
│   ├── models/
│   │   └── bluetooth_device_model.dart
│   │
│   ├── screens/
│   │   └── home_screen.dart
│   │
│   ├── services/
│   │   └── bluetooth_service.dart
│   │
│   └── widgets/
│       ├── device_card.dart
│       ├── volume_control.dart
│       └── equalizer.dart
│
├── test/
│   └── widget_test.dart
│
├── docs/
│   └── images/
│       └── home-screen.png
│
├── pubspec.yaml
├── README.md
└── .gitignore
```

> Alguns arquivos e serviços da estrutura acima representam a arquitetura planejada para as próximas etapas e podem ainda não possuir implementação completa.

### `main.dart`

Responsável pela inicialização da aplicação e configuração principal do tema.

### `screens/`

Contém as telas da aplicação.

Atualmente:

```text
home_screen.dart
```

A `HomeScreen` apresenta os dispositivos e será posteriormente conectada à camada Bluetooth.

### `widgets/`

Contém componentes reutilizáveis da interface.

Exemplo:

```text
device_card.dart
volume_control.dart
equalizer.dart
```

A ideia é manter os componentes independentes para facilitar futuras alterações na interface.

### `models/`

Responsável pelos modelos utilizados para representar dados da aplicação.

Exemplo planejado:

```text
bluetooth_device_model.dart
```

A utilização de modelos evita que regras de negócio e dados do Bluetooth fiquem diretamente acoplados à interface.

### `services/`

Camada destinada às operações externas da aplicação.

O serviço Bluetooth será responsável por operações como:

```text
Buscar dispositivos
       ↓
Encontrar dispositivo
       ↓
Conectar
       ↓
Descobrir serviços
       ↓
Ler características
       ↓
Escrever características
       ↓
Desconectar
```

Essa camada deverá concentrar a comunicação com o Bluetooth/BLE, mantendo essa lógica separada da interface.

---

## 🎨 Interface atual

A primeira versão da interface já possui uma tela inicial com:

- Nome da aplicação
- Seção de dispositivos
- Estado de conexão
- Card de dispositivo
- Botão para busca de dispositivos

Representação simplificada:

```text
┌──────────────────────────────────┐
│           Dual Sound             │
├──────────────────────────────────┤
│                                  │
│  Seus dispositivos               │
│  Conecte e controle seus         │
│  dispositivos de áudio.          │
│                                  │
│  ┌────────────────────────────┐  │
│  │  🔵  Nenhum dispositivo   ○ │  │
│  │      conectado              │  │
│  │      Desconectado           │  │
│  └────────────────────────────┘  │
│                                  │
│  ┌────────────────────────────┐  │
│  │   🔎 Buscar dispositivos   │  │
│  └────────────────────────────┘  │
│                                  │
└──────────────────────────────────┘
```

### Tela inicial

![Tela inicial do Dual Sound](docs/images/home-screen.png){width=400}

> **Status:** esta captura representa a interface atual do projeto. A implementação da comunicação Bluetooth/BLE e das funcionalidades de áudio ainda faz parte das próximas etapas do desenvolvimento.

### Estrutura da interface

```text
HomeScreen
├── AppBar
│   └── Dual Sound
│
├── Seção "Seus dispositivos"
│
├── DeviceCard
│   ├── Nome do dispositivo
│   ├── Estado da conexão
│   └── Indicador visual
│
└── Botão "Buscar dispositivos"
```

A interface foi dividida em componentes para facilitar a evolução do projeto e evitar que toda a lógica fique concentrada em um único arquivo.

---

## 🧪 Testes

O projeto possui testes automatizados para verificar a renderização básica da tela inicial.

O projeto utiliza o sistema de testes do Flutter através do pacote `flutter_test`.

Atualmente existe um teste de widget responsável por verificar a renderização dos principais elementos da tela inicial.

Exemplos de elementos verificados:

```text
Dual Sound
Seus dispositivos
Nenhum dispositivo conectado
Buscar dispositivos
```

Para executar os testes:

```powershell
flutter test
```

Resultado esperado:

```text
00:15 +1: All tests passed!
```

Também é possível executar:

```powershell
flutter analyze
```

para verificar problemas de análise estática no código.

---

## 🛠️ Tecnologias

| Tecnologia          | Utilização                               |
| ------------------- | ---------------------------------------- |
| **Flutter**         | Desenvolvimento da aplicação mobile      |
| **Dart**            | Linguagem de programação                 |
| **Android**         | Plataforma de testes atual               |
| **Bluetooth / BLE** | Comunicação com dispositivos compatíveis |
| **Git**             | Controle de versão                       |
| **GitHub**          | Hospedagem do código e documentação      |
| **VS Code**         | Ambiente principal de desenvolvimento    |
| **Android Studio**  | SDK, emulador e ferramentas Android      |

### Flutter

Framework utilizado para desenvolvimento da aplicação mobile.

- Flutter 3.47.6
- Dart 3.13.5
- Material 3

### Bluetooth / BLE

A comunicação BLE será estudada utilizando:

- `flutter_blue_plus`

O pacote será responsável pela camada de comunicação BLE da aplicação, enquanto funcionalidades relacionadas ao áudio dependerão de recursos específicos da plataforma.

### Android

O desenvolvimento está sendo realizado inicialmente com foco no Android.

Ambiente utilizado:

- Android SDK 37.0.0
- Android Emulator
- Android API 35 para testes
- Windows 11

### iOS

A compatibilidade com iOS faz parte do planejamento do projeto.

O desenvolvimento e testes nativos para iOS dependerão de um ambiente macOS/Xcode ou de uma solução de build compatível.

---

## 💻 Ambiente de desenvolvimento

### Sistema operacional

```text
Windows 11
```

### Flutter

```text
Flutter 3.47.6
Dart 3.13.5
```

### Android

```text
Android SDK 37.0.0
Android API 35
```

### IDE

```text
Visual Studio Code
Android Studio
```

### Controle de versão

```text
Git
GitHub
```

---

## 🚀 Como executar o projeto

### Pré-requisitos

É necessário possuir:

- Flutter SDK
- Dart SDK
- Android SDK
- Android Studio ou ferramentas equivalentes
- Um dispositivo Android físico ou emulador
- Git

Verifique a instalação do Flutter:

```bash
flutter doctor
```

Clone o repositório:

```powershell
git clone https://github.com/otzjoao/dual-sound-controller.git
```

Entre na pasta:

```powershell
cd dual-sound-controller
```

Instale as dependências:

```powershell
flutter pub get
```

Verifique os dispositivos disponíveis:

```powershell
flutter devices
```

Execute no dispositivo desejado:

```powershell
flutter run
```

Ou especifique o dispositivo:

```powershell
flutter run -d emulator-5554
```

---

## 📂 Estrutura do projeto

```text
dual-sound-controller/
│
├── android/              # Código e configuração Android
├── ios/                  # Código e configuração iOS
├── linux/                # Configuração Linux
├── macos/                # Configuração macOS
├── web/                  # Configuração Web
├── windows/              # Configuração Windows
│
├── lib/
│   ├── main.dart
│   ├── models/
│   ├── screens/
│   ├── services/
│   └── widgets/
│
├── test/
│   └── widget_test.dart
│
├── .gitignore
├── analysis_options.yaml
├── pubspec.yaml
├── pubspec.lock
└── README.md
```

---

## 🗺️ Roadmap

### ✅ Etapa 1 — Configuração do ambiente

- [x] Instalação do Flutter
- [x] Configuração do Android SDK
- [x] Configuração do Android Emulator
- [x] Criação do projeto Flutter
- [x] Configuração do Git
- [x] Criação do repositório no GitHub

### ✅ Etapa 2 — Interface inicial

- [x] Criação do tema
- [x] Criação da `HomeScreen`
- [x] Criação do `DeviceCard`
- [x] Indicador de conexão
- [x] Botão de busca
- [x] Organização dos widgets
- [x] Teste automatizado da tela inicial
- [x] Screenshot da interface

### 🔄 Etapa 3 — Bluetooth/BLE

- [ ] Adicionar `flutter_blue_plus`
- [ ] Solicitar permissões Bluetooth
- [ ] Detectar dispositivos próximos
- [ ] Exibir dispositivos encontrados
- [ ] Conectar a um dispositivo
- [ ] Desconectar dispositivo
- [ ] Monitorar estado da conexão
- [ ] Descobrir serviços BLE
- [ ] Descobrir características BLE

### 🔄 Etapa 4 — Controle dos dispositivos

- [ ] Criar modelo de dispositivo
- [ ] Criar serviço Bluetooth
- [ ] Associar dispositivos encontrados à interface
- [ ] Implementar estado real de conexão
- [ ] Investigar características de controle disponíveis
- [ ] Implementar controle de volume quando suportado pelo dispositivo

### 🔄 Etapa 5 — Áudio

- [ ] Pesquisar integração com áudio nativo
- [ ] Investigar Bluetooth Classic/A2DP
- [ ] Estudar limitações do Android
- [ ] Estudar limitações do iOS
- [ ] Avaliar sincronização de reprodução
- [ ] Avaliar possibilidade de múltiplos dispositivos
- [ ] Definir arquitetura final da camada de áudio

### 🔄 Etapa 6 — Interface avançada

- [ ] Controle individual de volume
- [ ] Equalizador
- [ ] Estado detalhado dos dispositivos
- [ ] Tela de configurações
- [ ] Feedback de conexão
- [ ] Animações e melhorias de UX

---

## 🔐 Controle de versão

O projeto utiliza Git para controle de versão.

As alterações são organizadas em commits seguindo uma convenção semântica, por exemplo:

```text
feat: adiciona descoberta de dispositivos BLE
fix: corrige estado de conexão
refactor: reorganiza serviço Bluetooth
test: adiciona testes para DeviceCard
docs: atualiza documentação
```

O repositório oficial está disponível em:

**https://github.com/otzjoao/dual-sound-controller**

---

## 🎓 Contexto acadêmico

O Dual Sound Controller também funciona como projeto de estudo para aplicação prática dos conhecimentos adquiridos durante a graduação em **Engenharia de Software**.

Além da implementação, o projeto busca aplicar conceitos de:

- Engenharia de requisitos
- Arquitetura de software
- Desenvolvimento mobile
- Programação orientada a objetos
- Separação de responsabilidades
- Testes de software
- Controle de versão
- Documentação técnica
- Pesquisa e análise de tecnologias
- Integração entre software e recursos do sistema operacional

---

## 📌 Estado atual do projeto

**Versão atual:** protótipo inicial da interface.

O projeto atualmente possui:

```text
✅ Projeto Flutter configurado
✅ Interface inicial
✅ Tema escuro
✅ Componentização básica
✅ DeviceCard
✅ Teste automatizado
✅ Ambiente Android configurado
✅ Repositório GitHub
✅ Documentação inicial
✅ Screenshot da interface
```

Ainda não estão implementados:

```text
❌ Descoberta BLE real
❌ Conexão BLE real
❌ Comunicação com características GATT
❌ Controle real de volume
❌ Reprodução de áudio
❌ Sincronização de áudio
❌ Reprodução em múltiplos dispositivos
```

---

## 🔮 Próximo passo

O próximo marco de desenvolvimento será a implementação da camada Bluetooth/BLE.

A primeira funcionalidade prática será:

```text
Buscar dispositivos
        ↓
Solicitar permissões
        ↓
Iniciar scan BLE
        ↓
Receber dispositivos encontrados
        ↓
Exibir dispositivos na interface
        ↓
Selecionar dispositivo
        ↓
Estabelecer conexão
```

Somente depois dessa etapa será iniciada a investigação da camada de áudio.

---

## 📁 Documentação

Materiais complementares do projeto podem ser armazenados na pasta:

```text
docs/
```

Exemplo:

```text
docs/
├── images/
│   └── home-screen.png
└── ...
```

---

## 🔗 Repositório

GitHub:

**https://github.com/otzjoao/dual-sound-controller**

---

## 👨‍💻 Autor

**João Ortiz**

Projeto desenvolvido para estudos em Engenharia de Software.

---

## 📄 Licença

Projeto acadêmico e experimental.

A utilização, modificação e distribuição do código devem respeitar a finalidade definida pelo autor do projeto.