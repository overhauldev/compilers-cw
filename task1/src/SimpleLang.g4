grammar SimpleLang;

prog : dec+ EOF;

dec
    : typed_idfr LParen (vardec+=typed_idfr (Comma vardec+=typed_idfr)*)? RParen body // * allows zero or more, ? is zero or one. So what ive done here is allow one or more parameters and added a ? at the end to make the whole param list optional
;

typed_idfr
    : type Idfr
;

type
    : IntType | BoolType | UnitType
;

body
    : LBrace localdecs+=localdec* ene+=exp (Semicolon ene+=exp)* RBrace
    ;

localdec
    : typed_idfr Assign exp Semicolon // A declaration like: int a := 0;
    ;
block
    : LBrace ene+=exp (Semicolon ene+=exp)* RBrace
;

exp
    : Idfr Assign exp                                       #AssignExpr
    | LParen exp binop exp RParen                           #BinOpExpr
    | unop exp                                              #UnOpExpr
    | Idfr LParen (args+=exp (Comma args+=exp)*)? RParen    #InvokeExpr
    | block                                                 #BlockExpr
    | If exp Then block Else block                          #IfExpr
    | Print exp                                             #PrintExpr
    | Space                                                 #SpaceExpr
    | Idfr                                                  #IdExpr
    | IntLit                                                #IntExpr
    | BoolLit                                               #BoolExpr
    | NewLine                                               #NewLineExpr
    | Skip                                                  #SkipExpr
    | While exp Do block                                    #WhileExpr
    | Repeat block Until exp                                #RepeatExpr
;

binop
    : Eq              #EqBinop
    | Less            #LessBinop
    | LessEq          #LessEqBinop
    | Plus            #PlusBinop
    | Minus           #MinusBinop
    | Times           #TimesBinop
    | Greater         #GreaterBinop
    | GreaterEq       #GreaterEqBinop
    | Division        #DivisionBinop
    | And             #AndBinop
    | Or              #OrBinop
    | XOR             #XORBinop
;

unop
    : Minus           #MinusUnop
    | Not             #NotUnop
;

LParen : '(' ;
Comma : ',' ;
RParen : ')' ;
LBrace : '{' ;
Semicolon : ';' ;
RBrace : '}' ;

// BinOp
Eq : '==' ;
Less : '<' ;
LessEq : '<=' ;
Greater: '>' ;
GreaterEq: '>=';
Plus : '+' ;
Times : '*' ;
Minus : '-' ;
Division : '/' ;
And : '&' ;
Or : '|' ;
XOR : '^' ;
Assign : ':=' ;
// Unop
Not : '~' ;

// exp
Print : 'print' ;
Space : 'space' ;
NewLine : 'newline' ;
If : 'if' ;
Then : 'then' ;
Else : 'else' ;
Skip : 'skip' ;
While : 'while';
Do : 'do';
Repeat : 'repeat';
Until : 'until';

IntType : 'int' ;
BoolType : 'bool' ;
UnitType : 'unit' ;

BoolLit : 'true' | 'false' ;
IntLit : '0' | ('-'? [1-9][0-9]*) ;
Idfr : [a-z][A-Za-z0-9_]* ;
WS : [ \n\r\t]+ -> skip ;