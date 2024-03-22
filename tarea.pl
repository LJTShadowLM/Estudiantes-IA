sintoma(diarrea).
sintoma(vomito).
sintoma(deshidratacion).
sintoma(calambres).
colera(X,Y,Z,C):- diarrea(X),vomito(Y),deshidratacion(Z),calambres(C).
colera(X,Y,no,no):- diarrea(X),vomito(Y).
diarrea(si).
vomito(si).
deshidratacion(si).
calambres(si).


