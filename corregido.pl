
% Base de Conocimiento 

% Proposiciones
prop(1, 'Es canido', p, 0.8).
prop(2, 'Es pequeno', p, 0.6).
prop(3, 'Es grande', p, 0.9).
prop(4, 'Es domestico', p, 0.9).
prop(5, 'Es fiel a su amo', p, 0.9).
prop(6, 'Es un perro', i, 0.9).
prop(7, 'Es un felido', p, 0.8).
prop(8, 'Caza ratones', p, 0.5).
prop(9, 'Es un gato', i, 0.9).
prop(10, 'q1', i, 0.9).
prop(11, 'q2', i, 0.8).
prop(12, 'q3', i, 0.7).
prop(13, 'o1', i, 0).
prop(14, 'o2', i, 0).
prop(15, 'o3', i, 0).

% Reglas
regla(1, y, [1, 2], 6, 0.90). % r1: Es canido ^ Es pequeno -> Es un perro (0.90)
regla(2, y, [3, 4], 6, 0.80). % r2: Es grande ^ Es domestico -> Es un perro (0.80)
regla(3, y, [5, 2], 6, 0.70). % r3: Es fiel a su amo ^ Es pequeno -> Es un perro (0.70)
regla(4, y, [10], 13, 0.90). % r4: q1 -> o1 (0.90)
regla(5, y, [11], 14, 0.80). % r5: q2 -> o2 (0.80)
regla(6, y, [12], 15, 0.70). % r6: q3 -> o3 (0.70)

% Clases
clase(1, 'Mamiferos', [1, 2 ,3 ,7]). % Clase de Mamiferos con identificadores de proposiciones asociadas
clase(2, 'Domesticos', [4,5, 6,8,9]). % Clase de Animales Domesticos con identificadores de proposiciones asociadas

% Motor de Inferencia (SIREG2)


% Funciones auxiliares 

% Obtiene el peso de una proposicion
obtener_peso_prop(Id, Peso):- prop(Id, _, _, Peso), !.

% Registra el peso de una proposicion
registrar_peso_prop(Id, Peso):- retract(prop_peso(Id, _)), !, assert(prop_peso(Id, Peso)).
registrar_peso_prop(Id, Peso):- assert(prop_peso(Id, Peso)).

% Obtiene el peso de una regla
obtener_peso_regla(Id, Peso):- regla(Id, _, _, _, Peso), !.

% Calcula el peso de una proposicion inferible
calcular_peso_inf(Id, Peso):-
    findall(Ir, regla(Ir, _, _, Id, _), Reglas),
    calcular_peso_reglas(Reglas, Peso).

% Calcula el peso de un conjunto de reglas
calcular_peso_reglas([], 0):- !.
calcular_peso_reglas([Id|Rest], Peso):-
    obtener_peso_regla(Id, PesoRegla),
    calcular_peso_reglas(Rest, PesoRest),
    Peso is PesoRegla * PesoRest.

% Actualiza el peso de una proposicion
actualizar_peso_prop(Id, NuevoPeso):-
    retract(prop_peso(Id, _)),
    assert(prop_peso(Id, NuevoPeso)).

% --- Funcion principal ---
iniciar():-
    write('Bienvenido a SIREG2'), nl,
    iniciar_consultas.

%  Funcion  para consultar las proposiciones 
iniciar_consultas:-
    write('Ingrese el ID de la proposicion a consultar (1-15): '),
    read(Id),
    obtener_peso(Id, Peso),
    nl,
    writef('Certeza de la proposici鏮 %t: %t\n', [Id, Peso]),
    iniciar_consultas.

%  Funcion para obtener el peso de una proposicion
obtener_peso(Id, Peso):-
    prop(Id, _, _, Peso), !. % Si la proposicion ya tiene un peso, devuelve ese peso
    obtener_peso_prop(Id, Peso), !. % Si la proposicion tiene un peso registrado, devuelve ese peso
    calcular_peso_inf(Id, Peso), !, % Si es una proposicion inferible, calcula su peso
    writef('Ingrese el grado de certeza de %t (entre -1 y 1): ', [Id]),
    read(NuevoPeso),
    registrar_peso_prop(Id, NuevoPeso),
    obtener_peso_prop(Id, Peso).



% Funciones de propagacion, calculo y clasificaciion

propagate :-
    findall(regla(R, _, ProposicionesEntrantes, ProposicionSaliente, _), regla(R, _, ProposicionesEntrantes, ProposicionSaliente, _), Reglas),
    maplist(calcular_valor_verdad, Reglas).

calcular_valor_verdad(regla(_, _, ProposicionesEntrantes, ProposicionSaliente, Peso)) :-
    findall(prop(_, _, ValorVerdad), member(Prop, ProposicionesEntrantes), ValoresVerdad),
    sum_list(ValoresVerdad, SumaValoresVerdad),
    ValorVerdadProposicionSaliente is 1 / (1 + exp(-Peso * SumaValoresVerdad)),
    actualizar_peso_prop(ProposicionSaliente, ValorVerdadProposicionSaliente).

clasificar :-
    findall(clase(Clase, _, Proposiciones), clase(Clase, _, Proposiciones), Clases),
    maplist(clasificar_proposiciones, Clases).

clasificar_proposiciones(clase(Clase, _, Proposiciones)) :-
    findall(prop(Prop, _, ValorVerdad, PesoProp), member(Prop, Proposiciones), Propiedades),
    sum_list([ValorVerdad * PesoProp : prop(_, _, ValorVerdad, PesoProp) <- Propiedades], SumaValoresVerdad),
    sum_list([PesoProp : prop(_, _, _, PesoProp) <- Propiedades], SumaPesos),
    ValorVerdadClase is SumaValoresVerdad / SumaPesos,
    writef('Clase: %t, Valor de verdad: %t\n', [Clase, ValorVerdadClase]).

% --- Consulta de ejemplo ---
es_canido(true).
es_pequeno(true).
propagate.
clasificar.











