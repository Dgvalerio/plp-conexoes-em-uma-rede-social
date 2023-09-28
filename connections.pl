% Conexões em uma rede social

/* Entradas */

follow(joao, maria).
follow(joao, jorge).
follow(joao, marcos).
follow(maria, marta).
follow(maria, jorge).
follow(jorge, roberto).
follow(roberto, carlos).
follow(carlos, carla).
follow(marcos, tabita).
follow(julia, tabita).
follow(tabita, darlan).
follow(darlan, silvana).

% Contatos de nível 1 – aqueles que possuem conhecimento diretos: relação direta de amizade.
level1(Follower, Followed) :-
    follow(Follower, Followed).

/*
Consulte com:
? - findall(Followed, level1(joao, Followed), Follows).
*/

% Contatos de nível 2 – aqueles que possuem conhecimento indireto, com um nível de indireção: amigos de amigos.
level2(Follower, Followed) :-
    follow(Follower, Intermediary),
    follow(Intermediary, Followed),
    not(level1(Follower, Followed)).

/*
Consulte com:
? - findall(Followed, level2(joao, Followed), Follows).
*/

% Contatos de nível 3 – aqueles que possuem conhecimento indireto, com dois níveis de indireção: amigos de amigos de amigos.
level3(Follower, Followed) :-
    follow(Follower, Intermediary),
    level2(Intermediary, Followed),
    not(level1(Follower, Followed)),
    not(level2(Follower, Followed)).

/*
Consulte com:
? - findall(Followed, level3(joao, Followed), Follows).
*/

% Contatos distantes – aqueles que possuem conhecimento indireto de amizade, com mais de dois níveis de indireção.
allLevels(Follower, Followed):-
    follow(Follower, Followed).

allLevels(Follower, Followed):-
    follow(Follower, Intermediary),
    allLevels(Intermediary, Followed).

levelGreaterThan3(Follower, Followed) :-
    allLevels(Follower, Followed),
    not(level1(Follower, Followed)),
    not(level2(Follower, Followed)),
    not(level3(Follower, Followed)).

/*
Consulte com:
? - findall(Followed, levelGreaterThan3(joao, Followed), Follows).
*/
