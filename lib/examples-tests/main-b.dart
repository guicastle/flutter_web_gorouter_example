import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp6());
}

// ---------------------------------------------------
// 1. Definição das Páginas de Conteúdo (StatelessWidgets)
//    Estas são as telas que serão exibidas ao lado do Drawer.
//    São StatelessWidget porque o GoRouter as reconstruirá quando a rota mudar.
// ---------------------------------------------------

class PedidosScreen extends StatelessWidget {
  const PedidosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Lista de Pedidos',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed:
                () => GoRouter.of(
                  context,
                ).go('/pedidos/12345'), // Navega para um pedido específico
            child: const Text('Ver Detalhes do Pedido 12345'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => GoRouter.of(context).go('/pedidos/67890'),
            child: const Text('Ver Detalhes do Pedido 67890'),
          ),
        ],
      ),
    );
  }
}

class PedidoDetailScreen extends StatelessWidget {
  final String pedidoId;
  const PedidoDetailScreen({super.key, required this.pedidoId});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Detalhes do Pedido: $pedidoId',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed:
                () => GoRouter.of(
                  context,
                ).go('/pedidos'), // Volta para a lista de pedidos
            child: const Text('Voltar para Pedidos'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed:
                () => GoRouter.of(
                  context,
                ).go('/pedidos/$pedidoId/itens'), // Navega para sub-sub-rota
            child: const Text('Ver Itens do Pedido'),
          ),
        ],
      ),
    );
  }
}

class PedidoItensScreen extends StatelessWidget {
  final String pedidoId;
  const PedidoItensScreen({super.key, required this.pedidoId});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Itens do Pedido: $pedidoId',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed:
                () => GoRouter.of(
                  context,
                ).go('/pedidos/$pedidoId'), // Volta para detalhes do pedido
            child: const Text('Voltar para Detalhes do Pedido'),
          ),
        ],
      ),
    );
  }
}

class ProdutosScreen extends StatelessWidget {
  const ProdutosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Lista de Produtos',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed:
                () => GoRouter.of(
                  context,
                ).go('/produtos/ABC001'), // Navega para um produto específico
            child: const Text('Ver Detalhes do Produto ABC001'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => GoRouter.of(context).go('/produtos/XYZ999'),
            child: const Text('Ver Detalhes do Produto XYZ999'),
          ),
        ],
      ),
    );
  }
}

class ProdutoDetailScreen extends StatelessWidget {
  final String produtoId;
  const ProdutoDetailScreen({super.key, required this.produtoId});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Detalhes do Produto: $produtoId',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed:
                () => GoRouter.of(
                  context,
                ).go('/produtos'), // Volta para a lista de produtos
            child: const Text('Voltar para Produtos'),
          ),
        ],
      ),
    );
  }
}

class ConfiguracoesScreen extends StatelessWidget {
  const ConfiguracoesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Conteúdo da Página de Configurações',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}

// ---------------------------------------------------
// 2. O Shell Principal (Layout Persistente com Drawer)
//    Este widget é o "pai" que contém o Drawer e a área onde o conteúdo
//    das rotas filhas será exibido. Ele é um StatefulWidget para gerenciar
//    o estado do item selecionado no Drawer.
// ---------------------------------------------------

class MainShell extends StatefulWidget {
  // O 'child' é o widget da rota atual que o GoRouter injeta aqui.
  final Widget child;
  const MainShell({super.key, required this.child});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  // Estado local para controlar qual item do Drawer está selecionado.
  int _selectedIndex = 0;

  @override
  void didUpdateWidget(covariant MainShell oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateDrawerSelection(); // atualiza o índice com base na rota
  }

  void _updateDrawerSelection() {
    final location = GoRouter.of(context).state.fullPath ?? "";

    int newIndex;
    if (location.startsWith('/pedidos')) {
      newIndex = 0;
    } else if (location.startsWith('/produtos')) {
      newIndex = 1;
    } else if (location.startsWith('/configuracoes')) {
      newIndex = 2;
    } else {
      newIndex = 0;
    }

    if (newIndex != _selectedIndex) {
      setState(() {
        _selectedIndex = newIndex;
      });
    }
  }

  // Método para atualizar o índice selecionado e navegar
  void _onItemTapped(BuildContext context, int index, String path) {
    setState(() {
      _selectedIndex = index;
    });
    GoRouter.of(context).go(path);
    // Fecha o Drawer apenas se for o Drawer móvel (para desktop, ele é fixo)
    if (MediaQuery.of(context).size.width < _breakpoint) {
      Navigator.pop(context);
    }
  }

  // Conteúdo do Drawer, reutilizável para ambos os layouts
  Widget _buildDrawerContent(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        const DrawerHeader(
          decoration: BoxDecoration(color: Colors.blue),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Menu Principal',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              SizedBox(height: 8),
              Text(
                'Navegue pelas seções',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
        ),
        ListTile(
          leading: const Icon(Icons.shopping_cart),
          title: const Text('Pedidos'),
          selected: _selectedIndex == 0,
          onTap: () => _onItemTapped(context, 0, '/pedidos'),
          selectedTileColor: Colors.blue.withValues(alpha: 0.1),
        ),
        ListTile(
          leading: const Icon(Icons.inventory),
          title: const Text('Produtos'),
          selected: _selectedIndex == 1,
          onTap: () => _onItemTapped(context, 1, '/produtos'),
          selectedTileColor: Colors.blue.withValues(alpha: 0.1),
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Configurações'),
          selected: _selectedIndex == 2,
          onTap: () => _onItemTapped(context, 2, '/configuracoes'),
          selectedTileColor: Colors.blue.withValues(alpha: 0.1),
        ),
      ],
    );
  }

  // Definindo um breakpoint para a responsividade
  static const double _breakpoint =
      900.0; // Largura em pixels para mudar o layout

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Verifica se a largura disponível é maior que o breakpoint
        if (constraints.maxWidth > _breakpoint) {
          // Layout para Desktop/Web (Drawer Fixo)
          return Scaffold(
            body: Row(
              children: [
                // Drawer fixo com largura definida
                SizedBox(
                  width: 250, // Largura do Drawer fixo
                  child: Drawer(
                    elevation:
                        0, // Remove a sombra para parecer parte do layout
                    child: _buildDrawerContent(context),
                  ),
                ),
                // Conteúdo da página ocupa o restante do espaço
                Expanded(child: widget.child),
              ],
            ),
          );
        } else {
          // Layout para Mobile (Drawer Tradicional)
          return Scaffold(
            appBar: AppBar(
              title: const Text('Minha sss Flutter Web'),
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
              // O ícone de hambúrguer é automaticamente adicionado aqui
            ),
            // O Drawer é atribuído à propriedade drawer do Scaffold
            drawer: Drawer(child: _buildDrawerContent(context)),
            body: widget.child,
          );
        }
      },
    );
  }
}

// ---------------------------------------------------
// 3. Configuração do GoRouter
//    Define as rotas da aplicação, incluindo o ShellRoute.
// ---------------------------------------------------

final routerNotifier = RouterNotifier();

final GoRouter _router = GoRouter(
  // A rota inicial quando a aplicação é carregada.
  initialLocation: '/pedidos',
  refreshListenable: routerNotifier,
  routes: [
    // O ShellRoute é a chave para o layout persistente.
    ShellRoute(
      // O 'builder' constrói o widget que será o shell (nosso MainShell).
      // O 'child' passado para o MainShell é o conteúdo da rota filha atual.
      builder: (context, state, child) {
        return MainShell(child: child);
      },
      // As rotas 'children' são as rotas que serão exibidas dentro do shell.
      routes: [
        GoRoute(
          path: '/pedidos',
          builder: (context, state) => const PedidosScreen(),
          routes: [
            // Sub-rota para detalhes do pedido: /pedidos/:pedidoId
            GoRoute(
              path: ':pedidoId', // ':pedidoId' é um parâmetro de rota
              builder: (context, state) {
                // Acessa o parâmetro 'pedidoId' do caminho
                final pedidoId = state.pathParameters['pedidoId']!;
                return PedidoDetailScreen(
                  key: ValueKey(pedidoId),
                  pedidoId: pedidoId,
                );
              },
              routes: [
                // Sub-sub-rota para itens do pedido: /pedidos/:pedidoId/itens
                GoRoute(
                  path: 'itens',
                  builder: (context, state) {
                    // O parâmetro 'pedidoId' ainda está disponível
                    final pedidoId = state.pathParameters['pedidoId']!;
                    return PedidoItensScreen(
                      key: ValueKey(state.fullPath),
                      pedidoId: pedidoId,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: '/produtos',
          builder: (context, state) => const ProdutosScreen(),
          routes: [
            // Sub-rota para detalhes do produto: /produtos/:produtoId
            GoRoute(
              path: ':produtoId', // ':produtoId' é um parâmetro de rota
              builder: (context, state) {
                // Acessa o parâmetro 'produtoId' do caminho
                final produtoId = state.pathParameters['produtoId']!;
                return ProdutoDetailScreen(
                  key: ValueKey(state.fullPath),
                  produtoId: produtoId,
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: '/configuracoes',
          builder: (context, state) => const ConfiguracoesScreen(),
        ),
      ],
    ),
  ],
  // Opcional: Configurar o tratamento de erros (página 404).
  errorBuilder:
      (context, state) => Scaffold(
        appBar: AppBar(title: const Text('Erro')),
        body: Center(
          child: Text(
            'Página não encontrada: ${state.uri}',
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
);

// ---------------------------------------------------
// 4. O Widget Principal da Aplicação (MaterialApp.router)
//    Usa o GoRouter para gerenciar o roteamento.
// ---------------------------------------------------

class MyApp6 extends StatelessWidget {
  const MyApp6({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false, // Remove o banner de debug
      title: 'Flutter sss com Drawer Persistente',
      routerConfig: _router, // Conecta o GoRouter à aplicação
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Inter', // Usando a fonte Inter conforme instruído
      ),
    );
  }
}

class RouterNotifier extends ChangeNotifier {
  // late final void Function(Duration) _observer;
  RouterNotifier() {
    // Sempre que houver mudança no histórico (inclusive botão "voltar"), notifica
    _locationStream = Uri.base.toString();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkUriChange();
    });
  }

  String _locationStream = '';
  void _checkUriChange() {
    if (_locationStream != Uri.base.toString()) {
      _locationStream = Uri.base.toString();
      notifyListeners(); // 🔔 notifica o GoRouter
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkUriChange());
  }
}
