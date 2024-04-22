pieza(falda).
pieza(top).
pieza(cinturon).
pieza(botones).

estado(falda).
estado(top).
estado(cinturon).
estado(botones).
estado(bueno).
estado(mal_estado).

irreparable(F,T,C,B):- estado(F), estado(T),estado(C), estado(B), F = mal_estado , T = mal_estado ,C = bueno, B = bueno.
irreparable(F,T,C,B):- estado(F), estado(T),estado(C), estado(B), F = mal_estado , T = mal_estado ,C = mal_estado, B = bueno.
irreparable(F,T,C,B):- estado(F), estado(T),estado(C), estado(B), F = mal_estado , T = mal_estado ,C = bueno, B = mal_estado .
irreparable(F,T,C,B):- estado(F), estado(T),estado(C), estado(B), F = mal_estado , T = mal_estado ,C = mal_estado, B = mal_estado .



