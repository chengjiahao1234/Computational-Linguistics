% Name: Jiahao Cheng, login_id: chengj60, student_id: 1003065737

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
        v_sem sub [tend, appear, promise, request, sleep]
              intro [tense:tense, subcat:list].
                % This should not be empty!  Fill in features for this and
                % the following subtypes:
            tend sub [] intro [agent:np, theme:inf_clause].
            appear sub [] intro [theme:inf_clause].
            promise sub [] intro [agent:np, theme:inf_clause, beneficiary:np].
            request sub [] intro [agent:np, theme:inf_clause, beneficiary:np].
            sleep sub [] intro [experiencer:np].
    
% list
list sub [e_list,ne_list].
    ne_list intro [hd:cat,tl:list].

% Rules
s rule
s ===>
cat> (Agent, np),
cat> (vp, vsem:(tense:past, subcat:[Agent])).

np rule
(np, nsem:N) ===>
cat> det,
cat> (n, nsem:N).

inf_clause_v rule
(inf_clause, vsem:(tense:present, subcat:[Agent])) ===>
cat> toinf,
cat> (vp, vsem:(tense:present, subcat:[Agent])).

inf_clause_vp rule
(inf_clause, vsem:(tense:present)) ===>
cat> (Experiencer, np, nsem:N),
cat> toinf,
cat> (vp, vsem:(tense:present, subcat:[Experiencer])).

vp_v rule
(vp, vsem:(tense:T, subcat:[Agent])) ===>
cat> (v, vsem:(tense:T, subcat:[Agent])).

vp_inf rule
(vp, vsem:(tense:T, subcat:[Agent])) ===>
cat> (v, vsem:(tense:T, subcat:[Theme, Agent])),
cat> (Theme, inf_clause, vsem:(tense:present, subcat:[Agent])).

vpnp_inf rule
(vp, vsem:(tense:T, subcat:[Agent])) ===>
cat> (v, vsem:(tense:T, subcat:[Theme, Beneficiary, Agent])),
cat> (Beneficiary, np, nsem:N),
cat> (Theme, inf_clause, vsem:(tense:present, subcat:[Agent])).

% Lexicons
tend ---> (v, vsem:(tend, tense:present, 
    subcat:[(inf_clause, Theme), (np, Agent)], 
    agent:Agent, theme:Theme)).

tended ---> (v, vsem:(tend, tense:past, 
    subcat:[(inf_clause, Theme), (np, Agent)],
    agent:Agent, theme:Theme)).

appear ---> (v, vsem:(appear, tense:present, 
    subcat:[(inf_clause, Theme)], theme:Theme)).

appeared ---> (v, vsem:(appear, tense:past, 
    subcat:[(inf_clause, Theme)], theme:Theme)).

promise ---> (v, vsem:(promise, tense:present, 
    subcat:[(inf_clause, Theme), (np, Beneficiary), (np, Agent)],
    theme:Theme, beneficiary:Beneficiary, agent:Agent)).

promised ---> (v, vsem:(promise, tense:past, 
    subcat:[(inf_clause, Theme), (np, Beneficiary), (np, Agent)],
    theme:Theme, beneficiary:Beneficiary, agent:Agent)).

request ---> (v, vsem:(request, tense:present, 
    subcat:[(inf_clause, Theme), (np, Beneficiary), (np, Agent)],
    theme:Theme, beneficiary:Beneficiary, agent:Agent)).

requested ---> (v, vsem:(request, tense:past, 
    subcat:[(inf_clause, Theme), (np, Beneficiary), (np, Agent)],
    theme:Theme, beneficiary:Beneficiary, agent:Agent)).

sleep ---> (v, vsem:(sleep, tense:present, 
    subcat:[(np, Experiencer)], experiencer:Experiencer)).

slept ---> (v, vsem:(sleep, tense:past, 
    subcat:[(np, Experiencer)], experiencer:Experiencer)).

the ---> det.

to ---> toinf.

student ---> (n, nsem:student).

teacher ---> (n, nsem:teacher).

