public class Tree<T> {
  protected Node<T> root;
  
  public Tree(T t) {
    root = new Node(t, null);
    root.childList = new ArrayList<Node<T>>();  
  }
}
 
   
  

