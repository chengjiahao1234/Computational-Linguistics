:- ale_flag(subtypecover,_,off).
:- discontiguous sub/2,intro/2.

bot sub [mood, tense, sem, cat, pos, verbal, nominal].

    % parts of speech
        pos sub [n, p, v, det, toinf].
            n sub [].
            p sub [].
            v sub [].
            det sub [].
            toinf sub [].   % infinitival to
    % phrasal categories
    cat sub [vproj, np].
        vproj sub [inf_clause, s, vp] intro [mood:mood].
            inf_clause intro [mood:infinitive].
            s intro [mood:indicative].
            vp intro [mood:indicative].
        np sub [].

        verbal sub [v, vproj] intro [vsem:v_sem].
        nominal sub [n, np] intro [nsem:n_sem].

    % mood and tense for verbs
    tense sub [past, present].
        past sub [].
        present sub [].
    mood sub [indicative, infinitive].
        indicative intro [tense:tense].
        infinitive sub [].

    % semantics for verbs and nouns
    sem sub [v_sem, n_sem].

        % semantics for nouns
        n_sem sub [student, teacher].
            student sub [].
            teacher sub [].

        % semantics for verbs
        % vtense sub [present,past].
        v_sem sub [tend, appear, promise, expect, request, sleep]
              intro [vtense:tense, subcat:list].     % This should not be empty!  Fill in features for this and
                            % the following subtypes:
            tend sub [] intro [agent_try:np, theme_try:inf_clause].
            promise sub [] intro [agent_pro:np, theme_pro:inf_clause, beneficiary_pro:np].
            request sub [] intro [agent_req:np, theme_req:inf_clause, beneficiary_req:np].
            appear sub [] intro [theme_apr:inf_clause].
            expect sub [] intro [agent_exp:np, theme_exp:inf_clause].
            sleep sub [] intro [experiencer:np].

list sub [e_list,ne_list].
  ne_list intro [hd:cat,tl:list].
s rule
s ===>
cat> (np,AGENT),
cat> (vp, vsem:(vtense:past,subcat:[AGENT])).

np_det_n rule
(np,nsem:N_sem) ===>
cat> det,
cat> (n,nsem:N_sem).

vp_inf rule
(vp,vsem:(vtense:Tense,subcat:[AGENT])) ===>
cat> (v,vsem:(vtense:Tense,subcat:[AGENT,THEME])),
cat> (inf_clause, THEME,vsem:(vtense:present,subcat:[AGENT])).

%passing beneficiary for promise sentences
vp_inf_pro rule
(vp,vsem:(vtense:Tense,subcat:[AGENT])) ===>
cat> (v,vsem:(vtense:Tense,subcat:[AGENT,THEME,BENEFICIARY])),
cat> (np,BENEFICIARY,nsem:N_sem),
cat> (inf_clause, THEME,vsem:(vtense:present,subcat:[AGENT])).

vp_inf_apr rule
(vp,vsem:(vtense:Tense,subcat:[AGENT])) ===>
cat> (v,vsem:(vtense:Tense,subcat:[THEME])),
cat> (inf_clause, THEME,vsem:(vtense:present,subcat:[AGENT])).

vp_v rule
(vp,vsem:(vtense:Tense,subcat:[AGENT])) ===>
cat> (v,vsem:(vtense:Tense,subcat:[AGENT])).

vp_np rule
(vp,vsem:(vtense:Tense,subcat:[AGENT]))  ===>
cat> (v,vsem:(vtense:Tense,subcat:[AGENT,THEME])),
cat> (inf_clause,THEME, vsem:(vtense:present,subcat:[AGENT]).

%passing experiencer for expect sentences
v_inf_clause_exp rule
(inf_clause,vsem:(vtense:Tense)) ===>
cat> (np,nsem:N_sem,EXP),
cat> toinf,
cat> (vp,vsem:(vtense:present,subcat:[EXP])).

v_inf_clause rule
(inf_clause,vsem:(vtense:Tense,subcat:[AGENT])) ===>
cat> toinf,
cat> (vp,vsem:(vtense:present,subcat:[AGENT])).

%[A,B,C] is equal to [AGENT,THEME,BENEFICIARY]
appear ---> (v,vsem:(vtense:present,subcat:[B],theme_apr:B)).

appeared ---> (v,vsem:(vtense:past,subcat:[B],theme_apr:B)).

expect ---> (v,vsem:(vtense:present,subcat:[A, B],agent_exp:A,theme_exp:B)).

expected ---> (v,vsem:(vtense:past,subcat:[A, B],agent_exp:A,theme_exp:B)).

promise ---> (v,vsem:(vtense:present,subcat:[A, B, C],agent_pro:A,theme_pro:B,beneficiary_pro:C)).

promised ---> (v,vsem:(vtense:past,subcat:[A, B, C],agent_pro:A,theme_pro:B,beneficiary_pro:C)).

request ---> (v,vsem:(vtense:present,subcat:[A, B, C],agent_req:A,theme_req:B,beneficiary_req:C)).

requested ---> (v,vsem:(vtense:past,subcat:[A, B, C],agent_req:A,theme_req:B,beneficiary_req:C)).

sleep ---> (v,vsem:(vtense:present, subcat:[A],experiencer:A)).

slept ---> (v,vsem:(vtense:past, subcat:[A],experiencer:A)).

student ---> (n,nsem:student).

teacher ---> (n,nsem:teacher).

the ---> det.

to ---> toinf.

tend ---> (v,vsem:(vtense:present,subcat:[A, B],agent_try:A,theme_try:B)).

tended ---> (v,vsem:(vtense:past,subcat:[A, B],agent_try:A,theme_try:B)).
