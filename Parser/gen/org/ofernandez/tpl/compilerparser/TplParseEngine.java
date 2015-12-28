package org.ofernandez.tpl.compilerparser;

/* The following code was generated by JFlex 1.6.1 */

import java_cup.runtime.Symbol;


/**
 * This class is a scanner generated by 
 * <a href="http://www.jflex.de/">JFlex</a> 1.6.1
 * from the specification file <tt>Generators/tpl.lex</tt>
 */
public class TplParseEngine implements java_cup.runtime.Scanner {

  /** This character denotes the end of file */
  public static final int YYEOF = -1;

  /** initial size of the lookahead buffer */
  private static final int ZZ_BUFFERSIZE = 16384;

  /** lexical states */
  public static final int YYINITIAL = 0;

  /**
   * ZZ_LEXSTATE[l] is the state in the DFA for the lexical state l
   * ZZ_LEXSTATE[l+1] is the state in the DFA for the lexical state l
   *                  at the beginning of a line
   * l is of the form l = 2*k, k a non negative integer
   */
  private static final int ZZ_LEXSTATE[] = { 
     0, 0
  };

  /** 
   * Translates characters to character classes
   */
  private static final String ZZ_CMAP_PACKED = 
    "\11\16\1\21\1\20\1\0\1\21\1\17\16\16\4\0\1\21\1\33"+
    "\1\0\1\22\1\15\1\30\1\50\1\0\1\34\1\35\1\24\1\27"+
    "\1\42\1\5\1\2\1\23\12\1\1\44\1\43\1\31\1\32\1\26"+
    "\1\61\1\45\4\15\1\4\25\15\1\25\1\0\1\36\1\56\1\15"+
    "\1\0\1\12\1\54\1\60\1\47\1\3\1\11\1\15\1\65\1\53"+
    "\1\15\1\57\1\13\1\62\1\46\1\51\1\63\1\15\1\7\1\14"+
    "\1\6\1\10\1\55\1\64\3\15\1\37\1\41\1\40\1\52\41\16"+
    "\2\0\4\15\4\0\1\15\2\0\1\16\7\0\1\15\4\0\1\15"+
    "\5\0\27\15\1\0\37\15\1\0\u01ca\15\4\0\14\15\16\0\5\15"+
    "\7\0\1\15\1\0\1\15\21\0\160\16\5\15\1\0\2\15\2\0"+
    "\4\15\10\0\1\15\1\0\3\15\1\0\1\15\1\0\24\15\1\0"+
    "\123\15\1\0\213\15\1\0\5\16\2\0\236\15\11\0\46\15\2\0"+
    "\1\15\7\0\47\15\7\0\1\15\1\0\55\16\1\0\1\16\1\0"+
    "\2\16\1\0\2\16\1\0\1\16\10\0\33\15\5\0\3\15\15\0"+
    "\5\16\6\0\1\15\4\0\13\16\5\0\53\15\37\16\4\0\2\15"+
    "\1\16\143\15\1\0\1\15\10\16\1\0\6\16\2\15\2\16\1\0"+
    "\4\16\2\15\12\16\3\15\2\0\1\15\17\0\1\16\1\15\1\16"+
    "\36\15\33\16\2\0\131\15\13\16\1\15\16\0\12\16\41\15\11\16"+
    "\2\15\4\0\1\15\5\0\26\15\4\16\1\15\11\16\1\15\3\16"+
    "\1\15\5\16\22\0\31\15\3\16\104\0\1\15\1\0\13\15\67\0"+
    "\33\16\1\0\4\16\66\15\3\16\1\15\22\16\1\15\7\16\12\15"+
    "\2\16\2\0\12\16\1\0\7\15\1\0\7\15\1\0\3\16\1\0"+
    "\10\15\2\0\2\15\2\0\26\15\1\0\7\15\1\0\1\15\3\0"+
    "\4\15\2\0\1\16\1\15\7\16\2\0\2\16\2\0\3\16\1\15"+
    "\10\0\1\16\4\0\2\15\1\0\3\15\2\16\2\0\12\16\4\15"+
    "\7\0\1\15\5\0\3\16\1\0\6\15\4\0\2\15\2\0\26\15"+
    "\1\0\7\15\1\0\2\15\1\0\2\15\1\0\2\15\2\0\1\16"+
    "\1\0\5\16\4\0\2\16\2\0\3\16\3\0\1\16\7\0\4\15"+
    "\1\0\1\15\7\0\14\16\3\15\1\16\13\0\3\16\1\0\11\15"+
    "\1\0\3\15\1\0\26\15\1\0\7\15\1\0\2\15\1\0\5\15"+
    "\2\0\1\16\1\15\10\16\1\0\3\16\1\0\3\16\2\0\1\15"+
    "\17\0\2\15\2\16\2\0\12\16\1\0\1\15\17\0\3\16\1\0"+
    "\10\15\2\0\2\15\2\0\26\15\1\0\7\15\1\0\2\15\1\0"+
    "\5\15\2\0\1\16\1\15\7\16\2\0\2\16\2\0\3\16\10\0"+
    "\2\16\4\0\2\15\1\0\3\15\2\16\2\0\12\16\1\0\1\15"+
    "\20\0\1\16\1\15\1\0\6\15\3\0\3\15\1\0\4\15\3\0"+
    "\2\15\1\0\1\15\1\0\2\15\3\0\2\15\3\0\3\15\3\0"+
    "\14\15\4\0\5\16\3\0\3\16\1\0\4\16\2\0\1\15\6\0"+
    "\1\16\16\0\12\16\11\0\1\15\7\0\3\16\1\0\10\15\1\0"+
    "\3\15\1\0\27\15\1\0\12\15\1\0\5\15\3\0\1\15\7\16"+
    "\1\0\3\16\1\0\4\16\7\0\2\16\1\0\2\15\6\0\2\15"+
    "\2\16\2\0\12\16\22\0\2\16\1\0\10\15\1\0\3\15\1\0"+
    "\27\15\1\0\12\15\1\0\5\15\2\0\1\16\1\15\7\16\1\0"+
    "\3\16\1\0\4\16\7\0\2\16\7\0\1\15\1\0\2\15\2\16"+
    "\2\0\12\16\1\0\2\15\17\0\2\16\1\0\10\15\1\0\3\15"+
    "\1\0\51\15\2\0\1\15\7\16\1\0\3\16\1\0\4\16\1\15"+
    "\10\0\1\16\10\0\2\15\2\16\2\0\12\16\12\0\6\15\2\0"+
    "\2\16\1\0\22\15\3\0\30\15\1\0\11\15\1\0\1\15\2\0"+
    "\7\15\3\0\1\16\4\0\6\16\1\0\1\16\1\0\10\16\22\0"+
    "\2\16\15\0\60\15\1\16\2\15\7\16\4\0\10\15\10\16\1\0"+
    "\12\16\47\0\2\15\1\0\1\15\2\0\2\15\1\0\1\15\2\0"+
    "\1\15\6\0\4\15\1\0\7\15\1\0\3\15\1\0\1\15\1\0"+
    "\1\15\2\0\2\15\1\0\4\15\1\16\2\15\6\16\1\0\2\16"+
    "\1\15\2\0\5\15\1\0\1\15\1\0\6\16\2\0\12\16\2\0"+
    "\4\15\40\0\1\15\27\0\2\16\6\0\12\16\13\0\1\16\1\0"+
    "\1\16\1\0\1\16\4\0\2\16\10\15\1\0\44\15\4\0\24\16"+
    "\1\0\2\16\5\15\13\16\1\0\44\16\11\0\1\16\71\0\53\15"+
    "\24\16\1\15\12\16\6\0\6\15\4\16\4\15\3\16\1\15\3\16"+
    "\2\15\7\16\3\15\4\16\15\15\14\16\1\15\17\16\2\0\46\15"+
    "\1\0\1\15\5\0\1\15\2\0\53\15\1\0\u014d\15\1\0\4\15"+
    "\2\0\7\15\1\0\1\15\1\0\4\15\2\0\51\15\1\0\4\15"+
    "\2\0\41\15\1\0\4\15\2\0\7\15\1\0\1\15\1\0\4\15"+
    "\2\0\17\15\1\0\71\15\1\0\4\15\2\0\103\15\2\0\3\16"+
    "\40\0\20\15\20\0\125\15\14\0\u026c\15\2\0\21\15\1\0\32\15"+
    "\5\0\113\15\3\0\3\15\17\0\15\15\1\0\4\15\3\16\13\0"+
    "\22\15\3\16\13\0\22\15\2\16\14\0\15\15\1\0\3\15\1\0"+
    "\2\16\14\0\64\15\40\16\3\0\1\15\3\0\2\15\1\16\2\0"+
    "\12\16\41\0\3\16\2\0\12\16\6\0\130\15\10\0\51\15\1\16"+
    "\1\15\5\0\106\15\12\0\35\15\3\0\14\16\4\0\14\16\12\0"+
    "\12\16\36\15\2\0\5\15\13\0\54\15\4\0\21\16\7\15\2\16"+
    "\6\0\12\16\46\0\27\15\5\16\4\0\65\15\12\16\1\0\35\16"+
    "\2\0\13\16\6\0\12\16\15\0\1\15\130\0\5\16\57\15\21\16"+
    "\7\15\4\0\12\16\21\0\11\16\14\0\3\16\36\15\15\16\2\15"+
    "\12\16\54\15\16\16\14\0\44\15\24\16\10\0\12\16\3\0\3\15"+
    "\12\16\44\15\122\0\3\16\1\0\25\16\4\15\1\16\4\15\3\16"+
    "\2\15\11\0\300\15\47\16\25\0\4\16\u0116\15\2\0\6\15\2\0"+
    "\46\15\2\0\6\15\2\0\10\15\1\0\1\15\1\0\1\15\1\0"+
    "\1\15\1\0\37\15\2\0\65\15\1\0\7\15\1\0\1\15\3\0"+
    "\3\15\1\0\7\15\3\0\4\15\2\0\6\15\4\0\15\15\5\0"+
    "\3\15\1\0\7\15\16\0\5\16\32\0\5\16\20\0\2\15\23\0"+
    "\1\15\13\0\5\16\5\0\6\16\1\0\1\15\15\0\1\15\20\0"+
    "\15\15\3\0\33\15\25\0\15\16\4\0\1\16\3\0\14\16\21\0"+
    "\1\15\4\0\1\15\2\0\12\15\1\0\1\15\3\0\5\15\6\0"+
    "\1\15\1\0\1\15\1\0\1\15\1\0\4\15\1\0\13\15\2\0"+
    "\4\15\5\0\5\15\4\0\1\15\21\0\51\15\u0a77\0\57\15\1\0"+
    "\57\15\1\0\205\15\6\0\4\15\3\16\2\15\14\0\46\15\1\0"+
    "\1\15\5\0\1\15\2\0\70\15\7\0\1\15\17\0\1\16\27\15"+
    "\11\0\7\15\1\0\7\15\1\0\7\15\1\0\7\15\1\0\7\15"+
    "\1\0\7\15\1\0\7\15\1\0\7\15\1\0\40\16\57\0\1\15"+
    "\u01d5\0\3\15\31\0\11\15\6\16\1\0\5\15\2\0\5\15\4\0"+
    "\126\15\2\0\2\16\2\0\3\15\1\0\132\15\1\0\4\15\5\0"+
    "\51\15\3\0\136\15\21\0\33\15\65\0\20\15\u0200\0\u19b6\15\112\0"+
    "\u51cd\15\63\0\u048d\15\103\0\56\15\2\0\u010d\15\3\0\20\15\12\16"+
    "\2\15\24\0\57\15\1\16\4\0\12\16\1\0\31\15\7\0\1\16"+
    "\120\15\2\16\45\0\11\15\2\0\147\15\2\0\4\15\1\0\4\15"+
    "\14\0\13\15\115\0\12\15\1\16\3\15\1\16\4\15\1\16\27\15"+
    "\5\16\20\0\1\15\7\0\64\15\14\0\2\16\62\15\21\16\13\0"+
    "\12\16\6\0\22\16\6\15\3\0\1\15\4\0\12\16\34\15\10\16"+
    "\2\0\27\15\15\16\14\0\35\15\3\0\4\16\57\15\16\16\16\0"+
    "\1\15\12\16\46\0\51\15\16\16\11\0\3\15\1\16\10\15\2\16"+
    "\2\0\12\16\6\0\27\15\3\0\1\15\1\16\4\0\60\15\1\16"+
    "\1\15\3\16\2\15\2\16\5\15\2\16\1\15\1\16\1\15\30\0"+
    "\3\15\2\0\13\15\5\16\2\0\3\15\2\16\12\0\6\15\2\0"+
    "\6\15\2\0\6\15\11\0\7\15\1\0\7\15\221\0\43\15\10\16"+
    "\1\0\2\16\2\0\12\16\6\0\u2ba4\15\14\0\27\15\4\0\61\15"+
    "\u2104\0\u016e\15\2\0\152\15\46\0\7\15\14\0\5\15\5\0\1\15"+
    "\1\16\12\15\1\0\15\15\1\0\5\15\1\0\1\15\1\0\2\15"+
    "\1\0\2\15\1\0\154\15\41\0\u016b\15\22\0\100\15\2\0\66\15"+
    "\50\0\15\15\3\0\20\16\20\0\7\16\14\0\2\15\30\0\3\15"+
    "\31\0\1\15\6\0\5\15\1\0\207\15\2\0\1\16\4\0\1\15"+
    "\13\0\12\16\7\0\32\15\4\0\1\15\1\0\32\15\13\0\131\15"+
    "\3\0\6\15\2\0\6\15\2\0\6\15\2\0\3\15\3\0\2\15"+
    "\3\0\2\15\22\0\3\16\4\0\14\15\1\0\32\15\1\0\23\15"+
    "\1\0\2\15\1\0\17\15\2\0\16\15\42\0\173\15\105\0\65\15"+
    "\210\0\1\16\202\0\35\15\3\0\61\15\57\0\37\15\21\0\33\15"+
    "\65\0\36\15\2\0\44\15\4\0\10\15\1\0\5\15\52\0\236\15"+
    "\2\0\12\16\u0356\0\6\15\2\0\1\15\1\0\54\15\1\0\2\15"+
    "\3\0\1\15\2\0\27\15\252\0\26\15\12\0\32\15\106\0\70\15"+
    "\6\0\2\15\100\0\1\15\3\16\1\0\2\16\5\0\4\16\4\15"+
    "\1\0\3\15\1\0\33\15\4\0\3\16\4\0\1\16\40\0\35\15"+
    "\203\0\66\15\12\0\26\15\12\0\23\15\215\0\111\15\u03b7\0\3\16"+
    "\65\15\17\16\37\0\12\16\20\0\3\16\55\15\13\16\2\0\1\16"+
    "\22\0\31\15\7\0\12\16\6\0\3\16\44\15\16\16\1\0\12\16"+
    "\100\0\3\16\60\15\16\16\4\15\13\0\12\16\u04a6\0\53\15\15\16"+
    "\10\0\12\16\u0936\0\u036f\15\221\0\143\15\u0b9d\0\u042f\15\u33d1\0\u0239\15"+
    "\u04c7\0\105\15\13\0\1\15\56\16\20\0\4\16\15\15\u4060\0\2\15"+
    "\u2163\0\5\16\3\0\26\16\2\0\7\16\36\0\4\16\224\0\3\16"+
    "\u01bb\0\125\15\1\0\107\15\1\0\2\15\2\0\1\15\2\0\2\15"+
    "\2\0\4\15\1\0\14\15\1\0\1\15\1\0\7\15\1\0\101\15"+
    "\1\0\4\15\2\0\10\15\1\0\7\15\1\0\34\15\1\0\4\15"+
    "\1\0\5\15\1\0\1\15\3\0\7\15\1\0\u0154\15\2\0\31\15"+
    "\1\0\31\15\1\0\37\15\1\0\31\15\1\0\37\15\1\0\31\15"+
    "\1\0\37\15\1\0\31\15\1\0\37\15\1\0\31\15\1\0\10\15"+
    "\2\0\62\16\u1600\0\4\15\1\0\33\15\1\0\2\15\1\0\1\15"+
    "\2\0\1\15\1\0\12\15\1\0\4\15\1\0\1\15\1\0\1\15"+
    "\6\0\1\15\4\0\1\15\1\0\1\15\1\0\1\15\1\0\3\15"+
    "\1\0\2\15\1\0\1\15\2\0\1\15\1\0\1\15\1\0\1\15"+
    "\1\0\1\15\1\0\1\15\1\0\2\15\1\0\1\15\2\0\4\15"+
    "\1\0\7\15\1\0\4\15\1\0\4\15\1\0\1\15\1\0\12\15"+
    "\1\0\21\15\5\0\3\15\1\0\5\15\1\0\21\15\u1144\0\ua6d7\15"+
    "\51\0\u1035\15\13\0\336\15\u3fe2\0\u021e\15\uffff\0\uffff\0\uffff\0\uffff\0\uffff\0\uffff\0\uffff\0\uffff\0\uffff\0\uffff\0\uffff\0\u05ee\0"+
    "\1\16\36\0\140\16\200\0\360\16\uffff\0\uffff\0\ufe12\0";

  /** 
   * Translates characters to character classes
   */
  private static final char [] ZZ_CMAP = zzUnpackCMap(ZZ_CMAP_PACKED);

  /** 
   * Translates DFA states to action switch labels.
   */
  private static final int [] ZZ_ACTION = zzUnpackAction();

  private static final String ZZ_ACTION_PACKED_0 =
    "\1\0\1\1\1\2\2\3\1\4\5\3\2\5\1\0"+
    "\1\6\1\7\1\10\1\11\1\12\1\13\1\14\1\15"+
    "\1\0\1\16\1\17\1\20\1\21\1\22\1\23\1\24"+
    "\1\25\1\26\1\27\1\3\1\0\1\3\1\30\3\3"+
    "\1\31\1\3\1\32\2\3\2\0\2\33\1\0\1\3"+
    "\1\34\4\3\1\35\3\0\1\36\1\37\1\40\1\41"+
    "\1\42\1\43\1\44\1\3\1\45\1\43\10\3\1\33"+
    "\5\3\1\45\1\0\1\46\1\30\1\47\5\3\1\50"+
    "\1\3\1\51\1\52\1\3\1\53\1\3\1\54\1\55"+
    "\1\3\1\32\2\3\1\56\1\57\1\60\1\31";

  private static int [] zzUnpackAction() {
    int [] result = new int[111];
    int offset = 0;
    offset = zzUnpackAction(ZZ_ACTION_PACKED_0, offset, result);
    return result;
  }

  private static int zzUnpackAction(String packed, int offset, int [] result) {
    int i = 0;       /* index in packed string  */
    int j = offset;  /* index in unpacked array */
    int l = packed.length();
    while (i < l) {
      int count = packed.charAt(i++);
      int value = packed.charAt(i++);
      do result[j++] = value; while (--count > 0);
    }
    return j;
  }


  /** 
   * Translates a state to a row index in the transition table
   */
  private static final int [] ZZ_ROWMAP = zzUnpackRowMap();

  private static final String ZZ_ROWMAP_PACKED_0 =
    "\0\0\0\66\0\154\0\242\0\330\0\u010e\0\u0144\0\u017a"+
    "\0\u01b0\0\u01e6\0\u021c\0\u0252\0\u0288\0\u02be\0\u02f4\0\u032a"+
    "\0\u0288\0\u0360\0\u0288\0\u0288\0\u0396\0\u03cc\0\u0402\0\u0288"+
    "\0\u0288\0\u0288\0\u0288\0\u0288\0\u0438\0\u0288\0\u0288\0\u046e"+
    "\0\u0288\0\u04a4\0\u04da\0\u0510\0\u0288\0\u0546\0\u057c\0\u05b2"+
    "\0\u0288\0\u05e8\0\u0288\0\u061e\0\u0654\0\154\0\u068a\0\u06c0"+
    "\0\u06f6\0\u072c\0\u0762\0\u0288\0\u0798\0\u07ce\0\u0804\0\u083a"+
    "\0\u0288\0\u0870\0\u08a6\0\u032a\0\u0288\0\u0288\0\u0288\0\u0288"+
    "\0\u0288\0\u0288\0\u0288\0\u08dc\0\u0288\0\u01b0\0\u0912\0\u0948"+
    "\0\u097e\0\u09b4\0\u09ea\0\u0a20\0\u0a56\0\u0a8c\0\u072c\0\u0ac2"+
    "\0\u0af8\0\u0b2e\0\u0b64\0\u0b9a\0\u01b0\0\u0bd0\0\u0288\0\u01b0"+
    "\0\u01b0\0\u0c06\0\u0c3c\0\u0c72\0\u0ca8\0\u0cde\0\u01b0\0\u0d14"+
    "\0\u01b0\0\u01b0\0\u0d4a\0\u01b0\0\u0d80\0\u01b0\0\u01b0\0\u0db6"+
    "\0\u01b0\0\u0dec\0\u0e22\0\u01b0\0\u01b0\0\u01b0\0\u01b0";

  private static int [] zzUnpackRowMap() {
    int [] result = new int[111];
    int offset = 0;
    offset = zzUnpackRowMap(ZZ_ROWMAP_PACKED_0, offset, result);
    return result;
  }

  private static int zzUnpackRowMap(String packed, int offset, int [] result) {
    int i = 0;  /* index in packed string  */
    int j = offset;  /* index in unpacked array */
    int l = packed.length();
    while (i < l) {
      int high = packed.charAt(i++) << 16;
      result[j++] = high | packed.charAt(i++);
    }
    return j;
  }

  /** 
   * The transition table of the DFA
   */
  private static final int [] ZZ_TRANS = zzUnpackTrans();

  private static final String ZZ_TRANS_PACKED_0 =
    "\1\0\1\2\1\3\1\4\1\5\1\6\1\7\1\10"+
    "\1\11\1\12\1\13\3\11\1\0\1\14\2\15\1\16"+
    "\1\17\1\20\1\21\1\22\1\23\1\24\1\25\1\26"+
    "\1\27\1\30\1\31\1\32\1\33\1\34\1\35\1\36"+
    "\1\37\1\40\1\41\1\42\1\11\1\43\1\44\1\45"+
    "\1\46\1\47\1\50\1\51\1\11\1\52\1\53\1\54"+
    "\1\11\1\55\1\11\1\0\1\2\1\56\2\57\62\0"+
    "\1\60\65\0\1\61\1\0\2\11\1\62\5\11\1\63"+
    "\3\11\27\0\2\11\1\0\1\11\1\0\3\11\1\0"+
    "\2\11\1\0\4\11\1\0\1\61\1\0\2\11\1\62"+
    "\11\11\27\0\2\11\1\0\1\11\1\0\3\11\1\0"+
    "\2\11\1\0\4\11\26\0\1\64\40\0\1\11\1\0"+
    "\2\11\1\0\1\11\1\65\7\11\27\0\2\11\1\0"+
    "\1\11\1\0\3\11\1\0\2\11\1\0\4\11\1\0"+
    "\1\11\1\0\1\66\1\11\1\0\11\11\27\0\2\11"+
    "\1\0\1\11\1\0\3\11\1\0\2\11\1\0\4\11"+
    "\1\0\1\11\1\0\2\11\1\0\11\11\27\0\2\11"+
    "\1\0\1\11\1\0\3\11\1\0\2\11\1\0\4\11"+
    "\1\0\1\11\1\0\2\11\1\0\4\11\1\67\4\11"+
    "\27\0\2\11\1\0\1\11\1\0\3\11\1\0\2\11"+
    "\1\0\4\11\1\0\1\11\1\0\2\11\1\0\11\11"+
    "\27\0\1\70\1\11\1\0\1\11\1\0\3\11\1\0"+
    "\2\11\1\0\4\11\20\0\1\15\133\0\20\16\1\71"+
    "\45\16\24\0\1\72\46\0\1\73\11\0\3\74\3\0"+
    "\1\75\72\0\1\76\65\0\1\77\65\0\1\100\65\0"+
    "\1\101\74\0\1\102\56\0\1\103\34\0\1\11\1\0"+
    "\2\11\1\0\11\11\27\0\2\11\1\0\1\104\1\0"+
    "\3\11\1\0\2\11\1\0\4\11\50\0\1\105\16\0"+
    "\1\11\1\0\2\11\1\0\1\11\1\106\7\11\27\0"+
    "\2\11\1\0\1\11\1\0\3\11\1\0\2\11\1\0"+
    "\4\11\1\0\1\11\1\0\2\11\1\0\11\11\27\0"+
    "\1\107\1\11\1\0\1\11\1\0\3\11\1\0\2\11"+
    "\1\0\4\11\1\0\1\11\1\0\2\11\1\0\1\11"+
    "\1\110\7\11\27\0\2\11\1\0\1\111\1\0\3\11"+
    "\1\0\2\11\1\0\4\11\1\0\1\11\1\0\2\11"+
    "\1\0\11\11\27\0\2\11\1\0\1\112\1\0\3\11"+
    "\1\0\2\11\1\0\4\11\1\0\1\11\1\0\2\11"+
    "\1\0\5\11\1\113\3\11\27\0\2\11\1\0\1\114"+
    "\1\0\3\11\1\0\2\11\1\0\4\11\1\0\1\11"+
    "\1\0\2\11\1\0\4\11\1\115\4\11\27\0\2\11"+
    "\1\0\1\11\1\0\3\11\1\0\2\11\1\0\4\11"+
    "\1\0\1\11\1\0\2\11\1\0\11\11\27\0\2\11"+
    "\1\0\1\11\1\0\3\11\1\0\2\11\1\0\3\11"+
    "\1\116\1\0\1\117\3\0\1\62\61\0\1\60\1\0"+
    "\2\57\62\0\1\61\1\0\2\11\1\0\11\11\27\0"+
    "\2\11\1\0\1\11\1\0\3\11\1\0\2\11\1\0"+
    "\4\11\1\0\1\117\65\0\1\11\1\0\2\11\1\0"+
    "\6\11\1\120\2\11\27\0\2\11\1\0\1\11\1\0"+
    "\3\11\1\0\2\11\1\0\4\11\1\0\1\11\1\0"+
    "\2\11\1\0\2\11\1\121\6\11\27\0\2\11\1\0"+
    "\1\11\1\0\3\11\1\0\2\11\1\0\4\11\1\0"+
    "\1\11\1\0\2\11\1\0\1\122\3\11\1\123\4\11"+
    "\27\0\2\11\1\0\1\11\1\0\3\11\1\0\2\11"+
    "\1\0\4\11\1\0\1\11\1\0\2\11\1\0\5\11"+
    "\1\124\3\11\27\0\2\11\1\0\1\11\1\0\3\11"+
    "\1\0\2\11\1\0\4\11\1\0\1\11\1\0\2\11"+
    "\1\0\11\11\27\0\1\11\1\125\1\0\1\11\1\0"+
    "\3\11\1\0\2\11\1\0\4\11\24\72\1\126\41\72"+
    "\26\0\1\127\40\0\1\11\1\0\2\11\1\0\1\130"+
    "\10\11\27\0\2\11\1\0\1\11\1\0\3\11\1\0"+
    "\2\11\1\0\4\11\1\0\1\11\1\0\2\11\1\0"+
    "\1\131\10\11\27\0\2\11\1\0\1\11\1\0\3\11"+
    "\1\0\2\11\1\0\4\11\1\0\1\11\1\0\1\132"+
    "\1\11\1\0\11\11\27\0\2\11\1\0\1\11\1\0"+
    "\3\11\1\0\2\11\1\0\4\11\1\0\1\11\1\0"+
    "\2\11\1\0\11\11\27\0\2\11\1\0\1\133\1\0"+
    "\3\11\1\0\2\11\1\0\4\11\1\0\1\11\1\0"+
    "\2\11\1\0\11\11\27\0\2\11\1\0\1\11\1\0"+
    "\1\134\2\11\1\0\2\11\1\0\4\11\1\0\1\11"+
    "\1\0\2\11\1\0\4\11\1\135\4\11\27\0\2\11"+
    "\1\0\1\11\1\0\3\11\1\0\2\11\1\0\4\11"+
    "\1\0\1\11\1\0\2\11\1\0\11\11\27\0\1\136"+
    "\1\11\1\0\1\11\1\0\3\11\1\0\2\11\1\0"+
    "\4\11\1\0\1\11\1\0\2\11\1\0\11\11\27\0"+
    "\2\11\1\0\1\11\1\0\3\11\1\0\2\11\1\0"+
    "\1\11\1\137\2\11\1\0\1\11\1\0\2\11\1\0"+
    "\11\11\27\0\2\11\1\0\1\11\1\0\1\140\2\11"+
    "\1\0\2\11\1\0\4\11\1\0\1\11\1\0\1\141"+
    "\1\11\1\0\11\11\27\0\2\11\1\0\1\11\1\0"+
    "\3\11\1\0\2\11\1\0\4\11\1\0\1\11\1\0"+
    "\1\142\1\11\1\0\11\11\27\0\2\11\1\0\1\11"+
    "\1\0\3\11\1\0\2\11\1\0\4\11\1\0\1\11"+
    "\1\0\2\11\1\0\2\11\1\143\6\11\27\0\2\11"+
    "\1\0\1\11\1\0\3\11\1\0\2\11\1\0\4\11"+
    "\1\0\1\11\1\0\2\11\1\0\5\11\1\144\3\11"+
    "\27\0\2\11\1\0\1\11\1\0\3\11\1\0\2\11"+
    "\1\0\4\11\1\0\1\11\1\0\2\11\1\0\6\11"+
    "\1\121\2\11\27\0\2\11\1\0\1\11\1\0\3\11"+
    "\1\0\2\11\1\0\4\11\23\72\1\71\1\126\41\72"+
    "\1\0\1\11\1\0\2\11\1\0\4\11\1\145\4\11"+
    "\27\0\2\11\1\0\1\11\1\0\3\11\1\0\2\11"+
    "\1\0\4\11\1\0\1\11\1\0\2\11\1\0\5\11"+
    "\1\146\3\11\27\0\2\11\1\0\1\11\1\0\3\11"+
    "\1\0\2\11\1\0\4\11\1\0\1\11\1\0\2\11"+
    "\1\0\11\11\27\0\1\11\1\147\1\0\1\11\1\0"+
    "\3\11\1\0\2\11\1\0\4\11\1\0\1\11\1\0"+
    "\2\11\1\0\6\11\1\150\2\11\27\0\2\11\1\0"+
    "\1\11\1\0\3\11\1\0\2\11\1\0\4\11\1\0"+
    "\1\11\1\0\2\11\1\0\11\11\27\0\1\11\1\151"+
    "\1\0\1\11\1\0\3\11\1\0\2\11\1\0\4\11"+
    "\1\0\1\11\1\0\2\11\1\0\5\11\1\152\3\11"+
    "\27\0\2\11\1\0\1\11\1\0\3\11\1\0\2\11"+
    "\1\0\4\11\1\0\1\11\1\0\2\11\1\0\1\11"+
    "\1\153\7\11\27\0\2\11\1\0\1\11\1\0\3\11"+
    "\1\0\2\11\1\0\4\11\1\0\1\11\1\0\2\11"+
    "\1\0\11\11\27\0\2\11\1\0\1\11\1\0\3\11"+
    "\1\0\1\154\1\11\1\0\4\11\1\0\1\11\1\0"+
    "\2\11\1\0\6\11\1\155\2\11\27\0\2\11\1\0"+
    "\1\11\1\0\3\11\1\0\2\11\1\0\4\11\1\0"+
    "\1\11\1\0\1\156\1\11\1\0\11\11\27\0\2\11"+
    "\1\0\1\11\1\0\3\11\1\0\2\11\1\0\4\11"+
    "\1\0\1\11\1\0\2\11\1\0\11\11\27\0\1\157"+
    "\1\11\1\0\1\11\1\0\3\11\1\0\2\11\1\0"+
    "\4\11";

  private static int [] zzUnpackTrans() {
    int [] result = new int[3672];
    int offset = 0;
    offset = zzUnpackTrans(ZZ_TRANS_PACKED_0, offset, result);
    return result;
  }

  private static int zzUnpackTrans(String packed, int offset, int [] result) {
    int i = 0;       /* index in packed string  */
    int j = offset;  /* index in unpacked array */
    int l = packed.length();
    while (i < l) {
      int count = packed.charAt(i++);
      int value = packed.charAt(i++);
      value--;
      do result[j++] = value; while (--count > 0);
    }
    return j;
  }


  /* error codes */
  private static final int ZZ_UNKNOWN_ERROR = 0;
  private static final int ZZ_NO_MATCH = 1;
  private static final int ZZ_PUSHBACK_2BIG = 2;

  /* error messages for the codes above */
  private static final String ZZ_ERROR_MSG[] = {
    "Unknown internal scanner error",
    "Error: could not match input",
    "Error: pushback value was too large"
  };

  /**
   * ZZ_ATTRIBUTE[aState] contains the attributes of state <code>aState</code>
   */
  private static final int [] ZZ_ATTRIBUTE = zzUnpackAttribute();

  private static final String ZZ_ATTRIBUTE_PACKED_0 =
    "\1\0\13\1\1\11\1\0\2\1\1\11\1\1\2\11"+
    "\2\1\1\0\5\11\1\1\2\11\1\1\1\11\1\1"+
    "\1\0\1\1\1\11\3\1\1\11\1\1\1\11\2\1"+
    "\2\0\2\1\1\0\1\1\1\11\4\1\1\11\3\0"+
    "\7\11\1\1\1\11\20\1\1\0\1\11\30\1";

  private static int [] zzUnpackAttribute() {
    int [] result = new int[111];
    int offset = 0;
    offset = zzUnpackAttribute(ZZ_ATTRIBUTE_PACKED_0, offset, result);
    return result;
  }

  private static int zzUnpackAttribute(String packed, int offset, int [] result) {
    int i = 0;       /* index in packed string  */
    int j = offset;  /* index in unpacked array */
    int l = packed.length();
    while (i < l) {
      int count = packed.charAt(i++);
      int value = packed.charAt(i++);
      do result[j++] = value; while (--count > 0);
    }
    return j;
  }

  /** the input device */
  private java.io.Reader zzReader;

  /** the current state of the DFA */
  private int zzState;

  /** the current lexical state */
  private int zzLexicalState = YYINITIAL;

  /** this buffer contains the current text to be matched and is
      the source of the yytext() string */
  private char zzBuffer[] = new char[ZZ_BUFFERSIZE];

  /** the textposition at the last accepting state */
  private int zzMarkedPos;

  /** the current text position in the buffer */
  private int zzCurrentPos;

  /** startRead marks the beginning of the yytext() string in the buffer */
  private int zzStartRead;

  /** endRead marks the last character in the buffer, that has been read
      from input */
  private int zzEndRead;

  /** number of newlines encountered up to the start of the matched text */
  private int yyline;

  /** the number of characters up to the start of the matched text */
  private int yychar;

  /**
   * the number of characters from the last newline up to the start of the 
   * matched text
   */
  private int yycolumn;

  /** 
   * zzAtBOL == true <=> the scanner is currently at the beginning of a line
   */
  private boolean zzAtBOL = true;

  /** zzAtEOF == true <=> the scanner is at the EOF */
  private boolean zzAtEOF;

  /** denotes if the user-EOF-code has already been executed */
  private boolean zzEOFDone;
  
  /** 
   * The number of occupied positions in zzBuffer beyond zzEndRead.
   * When a lead/high surrogate has been read from the input stream
   * into the final zzBuffer position, this will have a value of 1;
   * otherwise, it will have a value of 0.
   */
  private int zzFinalHighSurrogate = 0;


  /**
   * Creates a new scanner
   *
   * @param   in  the java.io.Reader to read input from.
   */
  public TplParseEngine(java.io.Reader in) {
    this.zzReader = in;
  }


  /** 
   * Unpacks the compressed character translation table.
   *
   * @param packed   the packed character translation table
   * @return         the unpacked character translation table
   */
  private static char [] zzUnpackCMap(String packed) {
    char [] map = new char[0x110000];
    int i = 0;  /* index in packed string  */
    int j = 0;  /* index in unpacked array */
    while (i < 2852) {
      int  count = packed.charAt(i++);
      char value = packed.charAt(i++);
      do map[j++] = value; while (--count > 0);
    }
    return map;
  }


  /**
   * Refills the input buffer.
   *
   * @return      <code>false</code>, iff there was new input.
   * 
   * @exception   java.io.IOException  if any I/O-Error occurs
   */
  private boolean zzRefill() throws java.io.IOException {

    /* first: make room (if you can) */
    if (zzStartRead > 0) {
      zzEndRead += zzFinalHighSurrogate;
      zzFinalHighSurrogate = 0;
      System.arraycopy(zzBuffer, zzStartRead,
                       zzBuffer, 0,
                       zzEndRead-zzStartRead);

      /* translate stored positions */
      zzEndRead-= zzStartRead;
      zzCurrentPos-= zzStartRead;
      zzMarkedPos-= zzStartRead;
      zzStartRead = 0;
    }

    /* is the buffer big enough? */
    if (zzCurrentPos >= zzBuffer.length - zzFinalHighSurrogate) {
      /* if not: blow it up */
      char newBuffer[] = new char[zzBuffer.length*2];
      System.arraycopy(zzBuffer, 0, newBuffer, 0, zzBuffer.length);
      zzBuffer = newBuffer;
      zzEndRead += zzFinalHighSurrogate;
      zzFinalHighSurrogate = 0;
    }

    /* fill the buffer with new input */
    int requested = zzBuffer.length - zzEndRead;
    int numRead = zzReader.read(zzBuffer, zzEndRead, requested);

    /* not supposed to occur according to specification of java.io.Reader */
    if (numRead == 0) {
      throw new java.io.IOException("Reader returned 0 characters. See JFlex examples for workaround.");
    }
    if (numRead > 0) {
      zzEndRead += numRead;
      /* If numRead == requested, we might have requested to few chars to
         encode a full Unicode character. We assume that a Reader would
         otherwise never return half characters. */
      if (numRead == requested) {
        if (Character.isHighSurrogate(zzBuffer[zzEndRead - 1])) {
          --zzEndRead;
          zzFinalHighSurrogate = 1;
        }
      }
      /* potentially more input available */
      return false;
    }

    /* numRead < 0 ==> end of stream */
    return true;
  }

    
  /**
   * Closes the input stream.
   */
  public final void yyclose() throws java.io.IOException {
    zzAtEOF = true;            /* indicate end of file */
    zzEndRead = zzStartRead;  /* invalidate buffer    */

    if (zzReader != null)
      zzReader.close();
  }


  /**
   * Resets the scanner to read from a new input stream.
   * Does not close the old reader.
   *
   * All internal variables are reset, the old input stream 
   * <b>cannot</b> be reused (internal buffer is discarded and lost).
   * Lexical state is set to <tt>ZZ_INITIAL</tt>.
   *
   * Internal scan buffer is resized down to its initial length, if it has grown.
   *
   * @param reader   the new input stream 
   */
  public final void yyreset(java.io.Reader reader) {
    zzReader = reader;
    zzAtBOL  = true;
    zzAtEOF  = false;
    zzEOFDone = false;
    zzEndRead = zzStartRead = 0;
    zzCurrentPos = zzMarkedPos = 0;
    zzFinalHighSurrogate = 0;
    yyline = yychar = yycolumn = 0;
    zzLexicalState = YYINITIAL;
    if (zzBuffer.length > ZZ_BUFFERSIZE)
      zzBuffer = new char[ZZ_BUFFERSIZE];
  }


  /**
   * Returns the current lexical state.
   */
  public final int yystate() {
    return zzLexicalState;
  }


  /**
   * Enters a new lexical state
   *
   * @param newState the new lexical state
   */
  public final void yybegin(int newState) {
    zzLexicalState = newState;
  }


  /**
   * Returns the text matched by the current regular expression.
   */
  public final String yytext() {
    return new String( zzBuffer, zzStartRead, zzMarkedPos-zzStartRead );
  }


  /**
   * Returns the character at position <tt>pos</tt> from the 
   * matched text. 
   * 
   * It is equivalent to yytext().charAt(pos), but faster
   *
   * @param pos the position of the character to fetch. 
   *            A value from 0 to yylength()-1.
   *
   * @return the character at position pos
   */
  public final char yycharat(int pos) {
    return zzBuffer[zzStartRead+pos];
  }


  /**
   * Returns the length of the matched text region.
   */
  public final int yylength() {
    return zzMarkedPos-zzStartRead;
  }


  /**
   * Reports an error that occured while scanning.
   *
   * In a wellformed scanner (no or only correct usage of 
   * yypushback(int) and a match-all fallback rule) this method 
   * will only be called with things that "Can't Possibly Happen".
   * If this method is called, something is seriously wrong
   * (e.g. a JFlex bug producing a faulty scanner etc.).
   *
   * Usual syntax/scanner level error handling should be done
   * in error fallback rules.
   *
   * @param   errorCode  the code of the errormessage to display
   */
  private void zzScanError(int errorCode) {
    String message;
    try {
      message = ZZ_ERROR_MSG[errorCode];
    }
    catch (ArrayIndexOutOfBoundsException e) {
      message = ZZ_ERROR_MSG[ZZ_UNKNOWN_ERROR];
    }

    throw new Error(message);
  } 


  /**
   * Pushes the specified amount of characters back into the input stream.
   *
   * They will be read again by then next call of the scanning method
   *
   * @param number  the number of characters to be read again.
   *                This number must not be greater than yylength()!
   */
  public void yypushback(int number)  {
    if ( number > yylength() )
      zzScanError(ZZ_PUSHBACK_2BIG);

    zzMarkedPos -= number;
  }


  /**
   * Contains user EOF-code, which will be executed exactly once,
   * when the end of file is reached
   */
  private void zzDoEOF() throws java.io.IOException {
    if (!zzEOFDone) {
      zzEOFDone = true;
      yyclose();
    }
  }


  /**
   * Resumes scanning until the next regular expression is matched,
   * the end of input is encountered or an I/O-Error occurs.
   *
   * @return      the next token
   * @exception   java.io.IOException  if any I/O-Error occurs
   */
  public java_cup.runtime.Symbol next_token() throws java.io.IOException {
    int zzInput;
    int zzAction;

    // cached fields:
    int zzCurrentPosL;
    int zzMarkedPosL;
    int zzEndReadL = zzEndRead;
    char [] zzBufferL = zzBuffer;
    char [] zzCMapL = ZZ_CMAP;

    int [] zzTransL = ZZ_TRANS;
    int [] zzRowMapL = ZZ_ROWMAP;
    int [] zzAttrL = ZZ_ATTRIBUTE;

    while (true) {
      zzMarkedPosL = zzMarkedPos;

      zzAction = -1;

      zzCurrentPosL = zzCurrentPos = zzStartRead = zzMarkedPosL;
  
      zzState = ZZ_LEXSTATE[zzLexicalState];

      // set up zzAction for empty match case:
      int zzAttributes = zzAttrL[zzState];
      if ( (zzAttributes & 1) == 1 ) {
        zzAction = zzState;
      }


      zzForAction: {
        while (true) {
    
          if (zzCurrentPosL < zzEndReadL) {
            zzInput = Character.codePointAt(zzBufferL, zzCurrentPosL, zzEndReadL);
            zzCurrentPosL += Character.charCount(zzInput);
          }
          else if (zzAtEOF) {
            zzInput = YYEOF;
            break zzForAction;
          }
          else {
            // store back cached positions
            zzCurrentPos  = zzCurrentPosL;
            zzMarkedPos   = zzMarkedPosL;
            boolean eof = zzRefill();
            // get translated positions and possibly new buffer
            zzCurrentPosL  = zzCurrentPos;
            zzMarkedPosL   = zzMarkedPos;
            zzBufferL      = zzBuffer;
            zzEndReadL     = zzEndRead;
            if (eof) {
              zzInput = YYEOF;
              break zzForAction;
            }
            else {
              zzInput = Character.codePointAt(zzBufferL, zzCurrentPosL, zzEndReadL);
              zzCurrentPosL += Character.charCount(zzInput);
            }
          }
          int zzNext = zzTransL[ zzRowMapL[zzState] + zzCMapL[zzInput] ];
          if (zzNext == -1) break zzForAction;
          zzState = zzNext;

          zzAttributes = zzAttrL[zzState];
          if ( (zzAttributes & 1) == 1 ) {
            zzAction = zzState;
            zzMarkedPosL = zzCurrentPosL;
            if ( (zzAttributes & 8) == 8 ) break zzForAction;
          }

        }
      }

      // store back cached position
      zzMarkedPos = zzMarkedPosL;

      if (zzInput == YYEOF && zzStartRead == zzCurrentPos) {
        zzAtEOF = true;
            zzDoEOF();
          { return new java_cup.runtime.Symbol(sym.EOF); }
      }
      else {
        switch (zzAction < 0 ? zzAction : ZZ_ACTION[zzAction]) {
          case 1: 
            { return (new Symbol(sym.INT_LIT, yytext()));
            }
          case 49: break;
          case 2: 
            { return (new Symbol(sym.PONTO));
            }
          case 50: break;
          case 3: 
            { return (new Symbol(sym.ID, yytext()));
            }
          case 51: break;
          case 4: 
            { return (new Symbol(sym.SUB));
            }
          case 52: break;
          case 5: 
            { /* ignora os espacos em branco */
            }
          case 53: break;
          case 6: 
            { return (new Symbol(sym.DIV));
            }
          case 54: break;
          case 7: 
            { return (new Symbol(sym.MULT));
            }
          case 55: break;
          case 8: 
            { return (new Symbol(sym.PARR_E));
            }
          case 56: break;
          case 9: 
            { return (new Symbol(sym.MAIOR));
            }
          case 57: break;
          case 10: 
            { return (new Symbol(sym.SOMA));
            }
          case 58: break;
          case 11: 
            { return (new Symbol(sym.MOD));
            }
          case 59: break;
          case 12: 
            { return (new Symbol(sym.MENOR));
            }
          case 60: break;
          case 13: 
            { return (new Symbol(sym.IGUAL));
            }
          case 61: break;
          case 14: 
            { return (new Symbol(sym.PAR_E));
            }
          case 62: break;
          case 15: 
            { return (new Symbol(sym.PAR_D));
            }
          case 63: break;
          case 16: 
            { return (new Symbol(sym.PARR_D));
            }
          case 64: break;
          case 17: 
            { return (new Symbol(sym.CHAV_E));
            }
          case 65: break;
          case 18: 
            { return (new Symbol(sym.CHAV_D));
            }
          case 66: break;
          case 19: 
            { return (new Symbol(sym.BARRA_V));
            }
          case 67: break;
          case 20: 
            { return (new Symbol(sym.VIRG));
            }
          case 68: break;
          case 21: 
            { return (new Symbol(sym.P_VIRG));
            }
          case 69: break;
          case 22: 
            { return (new Symbol(sym.DPONTOS));
            }
          case 70: break;
          case 23: 
            { return (new Symbol(sym.RECURS));
            }
          case 71: break;
          case 24: 
            { return (new Symbol(sym.NOT));
            }
          case 72: break;
          case 25: 
            { return (new Symbol(sym.RETURN));
            }
          case 73: break;
          case 26: 
            { return (new Symbol(sym.COND));
            }
          case 74: break;
          case 27: 
            { return (new Symbol(sym.REAL_LIT, yytext()));
            }
          case 75: break;
          case 28: 
            { return (new Symbol(sym.IMPLICA));
            }
          case 76: break;
          case 29: 
            { /* ignora os comentarios */
            }
          case 77: break;
          case 30: 
            // lookahead expression with fixed base length
            zzMarkedPos = Character.offsetByCodePoints
                (zzBufferL, zzStartRead, zzEndRead - zzStartRead, zzStartRead, 1);
            { return (new Symbol(sym.WHILE));
            }
          case 78: break;
          case 31: 
            { return (new Symbol(sym.MAIOR_I));
            }
          case 79: break;
          case 32: 
            { return (new Symbol(sym.MENOR_I));
            }
          case 80: break;
          case 33: 
            { return (new Symbol(sym.IGUALIGUAL));
            }
          case 81: break;
          case 34: 
            { return (new Symbol(sym.DIF));
            }
          case 82: break;
          case 35: 
            { return (new Symbol(sym.OR));
            }
          case 83: break;
          case 36: 
            { return (new Symbol(sym.DPIGUAL));
            }
          case 84: break;
          case 37: 
            { return (new Symbol(sym.AND));
            }
          case 85: break;
          case 38: 
            // lookahead expression with fixed base length
            zzMarkedPos = Character.offsetByCodePoints
                (zzBufferL, zzStartRead, zzEndRead - zzStartRead, zzStartRead, 1);
            { return (new Symbol(sym.ELSE));
            }
          case 86: break;
          case 39: 
            { return (new Symbol(sym.INT));
            }
          case 87: break;
          case 40: 
            { return (new Symbol(sym.MAP));
            }
          case 88: break;
          case 41: 
            { return (new Symbol(sym.ELSE));
            }
          case 89: break;
          case 42: 
            { return (new Symbol(sym.BOOL_LIT, yytext()));
            }
          case 90: break;
          case 43: 
            { return (new Symbol(sym.REAL));
            }
          case 91: break;
          case 44: 
            { return (new Symbol(sym.BOOL));
            }
          case 92: break;
          case 45: 
            { return (new Symbol(sym.VOID));
            }
          case 93: break;
          case 46: 
            { return (new Symbol(sym.BREAK));
            }
          case 94: break;
          case 47: 
            { return (new Symbol(sym.CLASS));
            }
          case 95: break;
          case 48: 
            { return (new Symbol(sym.WHILE));
            }
          case 96: break;
          default:
            zzScanError(ZZ_NO_MATCH);
        }
      }
    }
  }


}
