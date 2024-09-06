package org.example;
import java.lang.reflect.Method;

public class Main {
    public static void main(String[] args) {
        try {
            String className = "PRG_340198";
            Class<?> cls = Class.forName(className);
            Object instance = cls.getDeclaredConstructor().newInstance();
            Method mainMethod = cls.getMethod("main",String[].class);
            String[] params = null; // new String[0]
            mainMethod.invoke(instance,(Object)params);
        }
        catch (Exception e){
            e.printStackTrace();
        }}
}