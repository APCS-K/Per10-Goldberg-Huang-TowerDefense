public class Node<T> {
    protected T data;
    protected Node<T> parent;
    protected ArrayList<Node<T>> childList;
    
    public Node(T t, Node<T> p) {
      data = t;
      parent = p;
      childList = new ArrayList<Node<T>>();
    }   
  }
