# Paginação com Flutter Web com rotas na URL e tratamento com roolback do navegador, sem travar, seguindo as boas praticas


## **Conceitos avançados aplicados no repositorio**.

---

## 📂 Estrutura de Arquivos Sugerida

```
lib/
├── examples-tests # Testes feitos para criar projeto
├── main.dart
├── router/
│   ├── app_router.dart
│   └── router_notifier.dart
├── shell/
│   └── main_shell.dart
├── features/
│   ├── pedidos/
│   │   ├── pedidos_screen.dart
│   │   ├── pedido_detail_screen.dart
│   │   └── pedido_itens_screen.dart
│   ├── produtos/
│   │   ├── produtos_screen.dart
│   │   └── produto_detail_screen.dart
│   └── configuracoes/
│       └── configuracoes_screen.dart
```

---

## 📄 Arquivo: `main.dart`

### Responsabilidade:

Ponto de entrada da aplicação, inicializa o `MaterialApp.router` com o `GoRouter`.

### Código-chave:

```dart
runApp(const MyApp6());

class MyApp6 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      theme: ThemeData(...),
    );
  }
}
```

---

## 📄 Arquivo: `router/app_router.dart`

### Responsabilidade:

Define as rotas da aplicação com `GoRouter`, `ShellRoute`, rotas aninhadas, e associa o `RouterNotifier`.

### Conceitos aplicados:

* Navegação declarativa
* ShellRoute para layout persistente
* ValueKey para forçar rebuild de widgets com mesmo tipo
* refreshListenable (GoRouter reativo)

### Código-chave:

```dart
final GoRouter router = GoRouter(
  refreshListenable: RouterNotifier(),
  routes: [...],
);
```

---

## 📄 Arquivo: `router/router_notifier.dart`

### Responsabilidade:

Notifica o `GoRouter` quando o histórico do navegador muda (como o botão voltar).

### Conceitos:

* `ChangeNotifier` personalizado
* Leitura da `Uri.base` atual
* `WidgetsBinding.instance.addPostFrameCallback`

---

## 📄 Arquivo: `shell/main_shell.dart`

### Responsabilidade:

Componente visual persistente com Drawer lateral e controle de seleção com base na rota atual.

### Conceitos importantes:

* `ShellRoute` fornece o `child`
* `_selectedIndex` controla a UI do Drawer
* `didUpdateWidget` detecta mudança de rota
* `GoRouter.of(context).state.fullPath` para detectar rota atual

---

## 📄 Arquivos: `features/*/*.dart`

### Exemplo:

**`PedidosScreen`, `PedidoDetailScreen`, `PedidoItensScreen`**

### Responsabilidade:

Renderizam os conteúdos com base nas rotas. Stateless por design, pois são reconstruídos via GoRouter.

### Conceito:

* Parametrização da rota (`:pedidoId`)
* `ValueKey` baseada no `state.fullPath` para forçar rebuild

---

## 🔁 Fluxo de Dados e Navegação

```txt
Usuário clica em uma rota no Drawer
↓
_onItemTapped chama GoRouter.of(context).go(path)
↓
GoRouter atualiza rota atual
↓
ShellRoute mantém o layout (MainShell) e troca apenas o child
↓
MainShell detecta mudança de rota com didUpdateWidget
↓
Atualiza _selectedIndex do Drawer com base na fullPath
↓
RouterNotifier observa mudanças na URL (Uri.base) e notifica GoRouter
↓
Widgets são reconstruídos com base no novo estado da rota
```

---

## ✅ Boas Práticas Seguidas

| Prática                            | Aplicação no Código                            |
| ---------------------------------- | ---------------------------------------------- |
| Stateless nas páginas              | Todas as páginas são reconstruídas via rota    |
| Key única nas rotas parametrizadas | `ValueKey(state.fullPath)`                     |
| Layout persistente                 | `ShellRoute` com Drawer fixo                   |
| Navegação declarativa              | Uso do `go()`                                  |
| Rota sincronizada com URL          | `refreshListenable` com `RouterNotifier`       |
| Responsividade                     | `LayoutBuilder` no `MainShell`                 |
| Organização modular                | Separação clara por feature e responsabilidade |

---

## 💡 Flashcards (exemplos)

1. **O que faz o `refreshListenable` no GoRouter?**
   → Reage a notificações para reconstruir a UI mesmo sem mudança de rota no sistema de widgets.

2. **Qual a diferença entre `go()` e `push()` no GoRouter?**
   → `go()` substitui a rota atual, `push()` empilha uma nova.

3. **Por que usar `ValueKey(state.fullPath)` em rotas dinâmicas?**
   → Para forçar a reconstrução de widgets do mesmo tipo ao mudar parâmetros.

4. **Quando `didUpdateWidget` é chamado?**
   → Quando o widget pai reconstrói e passa novos dados para o widget filho.

5. **Como detectar rota atual em tempo de execução?**
   → Usando `GoRouter.of(context).state.fullPath`.

---

# 📘 Documentação Técnica: Estrutura Flutter com GoRouter, ShellRoute e Navegação Avançada

Esta documentação visa explicar o funcionamento da arquitetura construída com Flutter Web + GoRouter, incluindo práticas modernas como ShellRoute, sincronização de Drawer, rotas aninhadas e refresh automático via refreshListenable. Também aborda conceitos avançados com analogias e exemplos práticos.

---

## 📂 Estrutura Geral dos Arquivos

```
lib/
├── main.dart                     # Entrada principal
├── router/
│   ├── app_router.dart          # Configuração do GoRouter
│   └── router_notifier.dart     # Observador de mudanças na URL
├── shell/
│   └── main_shell.dart          # Layout persistente com Drawer
├── features/
│   ├── pedidos/
│   ├── produtos/
│   └── configuracoes/
```

---

## 🧭 Navegação com GoRouter

### Fluxo Geral

1. **Usuário clica em um item do Drawer**
2. `go('/rota')` atualiza a URL
3. O GoRouter localiza a rota correta e constrói a tela
4. O `ShellRoute` mantém o layout fixo (Drawer + Scaffold)
5. `didUpdateWidget` no Shell detecta a mudança de rota e atualiza o índice selecionado no Drawer
6. Se o usuário usa o botão "Voltar" do navegador, o `RouterNotifier` detecta e força um refresh

### Analogia:

> "O GoRouter é como um sistema de GPS com um mapa. O `ShellRoute` é o painel do carro (Drawer fixo), e cada tela é como uma cidade. Ao mudar de cidade, o painel continua no mesmo lugar, mas o mapa (conteúdo) muda."

---

## 🧱 ShellRoute e MainShell

### Por que usar `ShellRoute`?

Permite manter um layout fixo (ex: Drawer) enquanto muda apenas a parte do conteúdo.

### Detalhe importante:

Usamos `MainShell(child: child)` para garantir que o conteúdo da tela seja renderizado dentro do layout padrão.

---

## 🧠 Controle do Drawer via didUpdateWidget

`didUpdateWidget` é usado para detectar quando a rota muda e atualizar o estado do Drawer.

### Analogia:

> "É como um painel que atualiza o botão iluminado no elevador quando você muda de andar."

---

## 🔄 Atualização via refreshListenable

A classe `RouterNotifier` observa `Uri.base`. Quando ela muda (ex: clique em voltar), ela chama `notifyListeners()`, que força o GoRouter a atualizar a UI.

### Analogia:

> "O RouterNotifier é como um alarme que toca quando alguém mexe na porta de saída do prédio. O sistema (GoRouter) então confere se algo mudou."

---

## 📦 Rotas Parametrizadas e ValueKey

Usamos `ValueKey(state.fullPath)` para forçar rebuild quando navegamos entre rotas com mesmo tipo de widget, mas parâmetros diferentes.

### Exemplo:

```dart
GoRoute(
  path: ':pedidoId',
  builder: (context, state) {
    final pedidoId = state.pathParameters['pedidoId']!;
    return PedidoDetailScreen(
      key: ValueKey(pedidoId),
      pedidoId: pedidoId,
    );
  },
)
```

---


## 🧠 Conceitos Explicados com Analogias

### 1. `didChangeDependencies`

> "Imagine que você está ouvindo uma estação de rádio. Se a antena muda, você precisa sintonizar novamente. didChangeDependencies é chamado quando algo herdado de cima muda, como um InheritedWidget."

### 2. `InheritedWidget`

> "É como um sinal de Wi-Fi: um widget lá em cima no app fornece um valor, e widgets abaixo podem acessar esse valor sem precisar passá-lo manualmente."

### 3. `addPostFrameCallback`

> "É como dizer: 'Me avise quando a tela terminar de renderizar, então eu verifico se algo mudou'."

---

### 🧭 `GoRouter` é como um GPS com rotas múltiplas

Ele sabe qual "estrada" (página) mostrar, e você apenas informa o endereço (`/pedidos/123`).

### 🪟 `ShellRoute` é uma moldura com vidro trocável

A moldura (Drawer) fica fixa, e só o vidro (conteúdo da rota) é trocado.

### 🗺️ `refreshListenable` é como um vigia de mudanças

Se algo fora do Flutter muda a rota (como o botão voltar), ele "toca o sino" para avisar.

### 🪪 `ValueKey(state.fullPath)` é a identidade do widget

Serve para o Flutter entender que precisa reconstruir algo, mesmo que o tipo do widget seja o mesmo.

### 🧰 `didUpdateWidget` é um sensor de mudança

Chamado quando o Flutter atualiza um widget com novas propriedades — como uma troca de roupa mantendo o mesmo corpo.

### 🧬 `InheritedWidget` (curiosidade para lembrar)

É como o DNA do app: muda no topo e todos os filhos reagem. Ex: `Theme.of(context)` ou `MediaQuery`.

---

## ✅ Checklist de Boas Práticas Aplicadas

| Prática                             | Aplicado? |
| ----------------------------------- | --------- |
| Stateless nas telas?                | ✅ Sim     |
| ShellRoute para layout persistente? | ✅ Sim     |
| Drawer sincronizado com rota atual? | ✅ Sim     |
| Reatividade com refreshListenable?  | ✅ Sim     |
| Responsividade com LayoutBuilder?   | ✅ Sim     |
| Modularização por features?         | ✅ Sim     |
| ValueKey para rotas dinâmicas?      | ✅ Sim     |


---

## 🧩 Boas Práticas Adotadas

* 🔑 StatelessWidgets nas páginas
* 🧠 Drawer persistente com ShellRoute
* 💡 Rota sincronizada com URL via refreshListenable
* 🧼 Separação clara por responsabilidade (arquitetura modular)
* 🔁 Sincronização manual do Drawer via GoRouter.state.fullPath
* ✅ Tratamento de rota 404 com errorBuilder

---

## 📎 Conclusão

Com esse padrão, você tem uma base escalável, reativa e com separação clara de responsabilidades. Ideal para Flutter Web com layout fixo e navegação complexa. Ótimo para evolução futura, testes e manutenção.
