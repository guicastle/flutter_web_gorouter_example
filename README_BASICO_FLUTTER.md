**Organização de chamadas de métodos no Dart e Flutter**, abordando:

1. 📌 **Maneiras de chamar métodos no Dart**
2. 📦 **Padrões comuns entre UI → Controller → Service**
3. ✅ **Boas práticas em projetos Flutter**

---

## 1. 📌 Maneiras de Chamar Métodos em Dart

### a) **Método de instância (via objeto)**

```dart
class Pessoa {
  void dizerOla() {
    print('Olá!');
  }
}

void main() {
  Pessoa p = Pessoa();     // instância
  p.dizerOla();            // chamada via instância
}
```

---

### b) **Método estático (sem precisar instanciar)**

```dart
class Util {
  static void imprimir(String msg) {
    print(msg);
  }
}

void main() {
  Util.imprimir('Olá mundo!');  // chamada sem instância
}
```

---

### c) **Função de nível superior (fora de qualquer classe)**

```dart
void saudacao() {
  print('Bem-vindo!');
}

void main() {
  saudacao();  // chamada direta
}
```

---

### d) **Método com arrow function (=>)**

```dart
void imprimir(String texto) => print(texto);

void main() {
  imprimir('Mensagem rápida');
}
```

---

### e) **Função anônima / lambda**

```dart
void main() {
  var lista = [1, 2, 3];
  lista.forEach((numero) {
    print('Número: $numero');
  });
}
```

---

### f) **Método como referência (tear-off)**

```dart
void imprimir(String msg) => print(msg);

void main() {
  final funcao = imprimir; // referência à função
  funcao('Executando via tear-off');
}
```

---

## 2. 🧭 Como a UI chama o Controller e o Controller chama o Service

Vamos usar uma estrutura comum:

* **View/UI** → tela Flutter
* **Controller** → lógica de apresentação / coordenação
* **Service** → lógica de negócio (API, banco, etc.)

---

### 🧱 Exemplo prático simplificado

#### `user_service.dart`

```dart
class UserService {
  String buscarUsuario() {
    return 'João da Silva';
  }
}
```

#### `user_controller.dart`

```dart
import 'user_service.dart';

class UserController {
  final UserService _service;

  UserController(this._service);

  String obterNomeUsuario() {
    return _service.buscarUsuario();
  }
}
```

#### `main.dart` (UI)

```dart
import 'package:flutter/material.dart';
import 'user_controller.dart';
import 'user_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final UserController controller = UserController(UserService());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Controller e Service')),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              final nome = controller.obterNomeUsuario(); // UI → Controller → Service
              print('Usuário: $nome');
            },
            child: Text('Buscar Usuário'),
          ),
        ),
      ),
    );
  }
}
```

---

### ✅ Chamadas nesse fluxo:

1. **UI** chama:
   `controller.obterNomeUsuario()`

2. **Controller** chama:
   `_service.buscarUsuario()`

3. **Service** executa a lógica e retorna o dado.

---

## 3. 📐 Boas Práticas (MVC/MVVM/BLoC/etc.)

* **Separe camadas**: Evite lógica de negócios dentro de Widgets.
* Use injeção de dependência (ex: [get\_it](https://pub.dev/packages/get_it)) para instanciar Controllers e Services.
* Use **estado reativo** se necessário: `Provider`, `Riverpod`, `BLoC`, `GetX`, etc.
* Crie **interfaces** para testes e desacoplamento.

---

### Exemplo com GetIt para injeção

```dart
final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<UserService>(UserService());
  getIt.registerFactory(() => UserController(getIt<UserService>()));
}

void main() {
  setup();
  runApp(MyApp());
}
```

---

## Recapitulando

| Forma de chamada     | Como funciona         | Exemplo                |
| -------------------- | --------------------- | ---------------------- |
| Via instância        | Objeto + método       | `obj.metodo()`         |
| Estático             | Classe direta         | `Classe.metodo()`      |
| Nível superior       | Função fora de classe | `funcao()`             |
| Tear-off             | Referência da função  | `var f = funcao; f();` |
| Anônima              | Inline                | `(x) => print(x)`      |
| UI → Controller      | Via ação do widget    | `controller.metodo()`  |
| Controller → Service | Lógica interna        | `_service.metodo()`    |

---
