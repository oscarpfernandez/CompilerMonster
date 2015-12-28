package org.ofernandez.tpl.compilerparser;

import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.PrintWriter;

public class MainParser {
   public static void main(String args[]) {
      try {
         if (args.length != 2) {
            System.out.println("Usage: java MainParser [in_file] [out_file]");
            System.exit(0);
         } else {
            File f = new File(args[0]);
            if (!f.exists()) {
               System.out.println("File " + args[0] + " not found!");
               System.exit(0);
            } else {
               @SuppressWarnings("deprecation")
               parser p = new parser(new TplParseEngine(new FileReader(args[0])));
               Object result = p.parse().value;

               PrintWriter pw = new PrintWriter(new FileWriter(args[1]));
               pw.println(result + ".");
               pw.close();
            }
         }
      } catch (Exception e) {
         System.out.println("Erro = " + e.getMessage());
         e.printStackTrace();
      }
   }
}
