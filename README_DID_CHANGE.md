# Conceito importante

### didChangeDependencies

É um método que o Flutter chama **quando alguma coisa que seu widget depende muda**. Por exemplo, se seu widget usa informações que vêm de um `InheritedWidget` e essas informações mudam, o Flutter executa `didChangeDependencies` para avisar seu widget que ele precisa reagir a essa mudança.

---

### InheritedWidget

Pense no `InheritedWidget` como **uma antena que transmite informações para vários widgets “filhos” na árvore do app**.

* Ele serve para compartilhar dados ou estado de forma eficiente para muitos widgets sem precisar passar manualmente por vários construtores.
* Quando a informação dentro dele muda, ele avisa automaticamente todos os widgets que “ouvem” essa antena para se atualizarem.

---

### Analogia rápida

* `InheritedWidget` é como uma rádio que transmite música (dados) para vários ouvintes (widgets).
* `didChangeDependencies` é o aviso que um ouvinte recebe quando a rádio troca a música, para ele mudar o que está fazendo e mostrar a nova música.

---

Assim, quando o GoRouter (que usa um `InheritedWidget`) muda a rota, seus widgets que dependem disso são avisados via `didChangeDependencies` e podem reagir, como atualizar o índice do Drawer.


