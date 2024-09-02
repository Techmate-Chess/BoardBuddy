package com.rufus.techmate.launcher;

import org.apache.catalina.LifecycleException;
import org.apache.catalina.startup.Tomcat;

public class Run {
  public static void main(String[] args) throws LifecycleException {
    Tomcat tomcat = new Tomcat();
    tomcat.setPort(8080);

    tomcat.addWebapp("/", new java.io.File("src/main/webapp").getAbsolutePath());

    tomcat.start();
    tomcat.getServer().await();
  }
}
