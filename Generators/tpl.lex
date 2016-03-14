import java_cup.runtime.Symbol;

%%

%class TplParseEngine
%public
%cup

Inteiro = [0-9]+
Real = [0-9]* (("." [0-9]+ (("e" | "E") "-"? [0-9]+)? ) | (("e" | "E") "-"? [0-9]+ ))  
Booleano = "true" | "false"
Identificador = [:jletter:][:jletterdigit:]*
Fim_linha = \r | \n | \r\n
Espaco_branco = {Fim_linha} | [ \t\f]
Comentario_linha = "#" [^\n]* \n
Comentario_a_la_c = "/*" ~"*/"
Comentario = {Comentario_linha} | {Comentario_a_la_c}

%%

<YYINITIAL> {

  {Comentario}      {  /* ignora os comentarios */  }

  "*" / ({Espaco_branco}* "[")  { return (new Symbol(sym.WHILE)); }
  "*" / ({Espaco_branco}* "->") { return (new Symbol(sym.ELSE)); }

  "+"   { return (new Symbol(sym.SOMA)); }
  "-"   { return (new Symbol(sym.SUB)); }
  "*"   { return (new Symbol(sym.MULT)); }
  "/"   { return (new Symbol(sym.DIV)); }
  "%"   { return (new Symbol(sym.MOD)); }
  "<"   { return (new Symbol(sym.MENOR)); }
  "<="  { return (new Symbol(sym.MENOR_I)); }
  "=="  { return (new Symbol(sym.IGUALIGUAL)); }
  "!="  { return (new Symbol(sym.DIF)); }
  ">"   { return (new Symbol(sym.MAIOR)); }
  ">="  { return (new Symbol(sym.MAIOR_I)); } 
  "("   { return (new Symbol(sym.PAR_E)); }
  ")"   { return (new Symbol(sym.PAR_D)); }
  "["   { return (new Symbol(sym.PARR_E)); }
  "]"   { return (new Symbol(sym.PARR_D)); }
  "{"   { return (new Symbol(sym.CHAV_E)); }
  "}"   { return (new Symbol(sym.CHAV_D)); }
  "|"   { return (new Symbol(sym.BARRA_V)); }
  ","   { return (new Symbol(sym.VIRG)); }
  "."   { return (new Symbol(sym.PONTO)); }
  ";"   { return (new Symbol(sym.P_VIRG)); }
  "="   { return (new Symbol(sym.IGUAL)); }
  "->"  { return (new Symbol(sym.IMPLICA)); } 
  ":"   { return (new Symbol(sym.DPONTOS)); }
  ":="  { return (new Symbol(sym.DPIGUAL)); }
  "@"   { return (new Symbol(sym.RECURS)); }

  "and" | "&&"   { return (new Symbol(sym.AND)); }
  "or"  | "||"   { return (new Symbol(sym.OR)); }  
  "not" | "~"    { return (new Symbol(sym.NOT)); }
  "int"          { return (new Symbol(sym.INT)); }
  "real"         { return (new Symbol(sym.REAL)); }
  "bool"         { return (new Symbol(sym.BOOL)); }
  "void"         { return (new Symbol(sym.VOID)); }
  "^"            { return (new Symbol(sym.RETURN)); }
  "return"       { return (new Symbol(sym.RETURN)); }
  "break"        { return (new Symbol(sym.BREAK)); }
  "cond"   | "?" { return (new Symbol(sym.COND)); }
  "map"          { return (new Symbol(sym.MAP)); }
  "class"        { return (new Symbol(sym.CLASS)); }
  "while"        { return (new Symbol(sym.WHILE)); }
  "else"         { return (new Symbol(sym.ELSE)); }
 
  {Inteiro}         { return (new Symbol(sym.INT_LIT, yytext())); }
  {Real}            { return (new Symbol(sym.REAL_LIT, yytext())); }
  {Booleano}        { return (new Symbol(sym.BOOL_LIT, yytext())); }
  {Identificador}   { return (new Symbol(sym.ID, yytext())); }

  {Espaco_branco}   {  /* ignora os espacos em branco */ }
}
