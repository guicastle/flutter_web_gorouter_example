import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
