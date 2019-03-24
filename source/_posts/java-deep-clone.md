---
post_url: java-deep-clone
title: Java 深拷贝 Cloneable
date: 2018-09-07 11:35:05
tags: java
---
```java
import java.util.ArrayList;
 
public class Person implements Cloneable {
 
    private String name;
    private ArrayList<Integer> books;
 
    public Person(String name, ArrayList<Integer> books) {
        this.name = name;
        this.books = books;
    }
 
    public ArrayList<Integer> getBooks() {
        return books;
    }
 
    public void setBooks(ArrayList<Integer> books) {
        this.books = books;
    }
 
    @Override
    protected Object clone() throws CloneNotSupportedException {
        Object obj = super.clone();
        ((Person) obj).setBooks((ArrayList<Integer>) books.clone());
        return obj;
    }
 
    public static void main(String[] args) {
        try {
            ArrayList<Integer> books = new ArrayList<>();
            books.add(1);
            books.add(2);
            Person p1 = new Person("张三", books);
            Person p2 = (Person) p1.clone();
            p2.setBooks(null);
            System.out.println("p1=" + p1.getBooks());
            System.out.println("p2=" + p2.getBooks());
        }
        catch (CloneNotSupportedException e) {
            e.printStackTrace();
        }
    }
 
}
```
```
p1=[1, 2]
p2=null
```