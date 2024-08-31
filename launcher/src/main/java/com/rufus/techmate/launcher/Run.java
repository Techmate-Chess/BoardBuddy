package com.rufus.techmate.launcher;

public class Run {
    public static void main(String[] args) {
TomcatLoadTimeWeaver tomcat = new Tomcat();

        tomcat.setPort(8080);

        tomcat.addWebapp("/", new java.io.File("src/main/webapp").getAbsolutePath());

        tomcat.start();
        tomcat.getServer().await();
    }
}
