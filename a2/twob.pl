% Name: Jiahao Cheng, login_id: chengj60, student_id: 1003065737

:- ale_flag(subtypecover,_,off).
:- discontiguous sub/2,intro/2.

bot sub [mood, tense, sem, cat, pos, verbal, nominal, list].

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
              intro [tense2:tense, subcat:list].
                % This should not be empty!  Fill in features for this and
                % the following subtypes:
            tend sub [] intro [agent:np, theme:inf_clause].
            appear sub [] intro [theme:inf_clause].
            promise sub [] intro [agent:np, theme:inf_clause, beneficiary:np].
            request sub [] intro [agent:np, theme:inf_clause, beneficiary:np].
            sleep sub [] intro [experiencer:np].
    
    % list
    list sub [e_list,ne_list].
        ne_list intro [hd:bot,tl:list].

% Rules
s rule
    s ===>
    cat> (Agent, np),
    cat> (vp, vsem:(tense2:past, subcat:[Agent])).

np rule
    (np, nsem:N) ===>
    cat> det,
    cat> (n, nsem:N).

vp_sleep rule
    (vp, vsem:(tense2:T, subcat:[Agent])) ===>
    cat> (v, vsem:(tense2:past, subcat:[Agent])).

inf_clause_sleep rule
    (inf_clause, vsem:(tense2:present, subcat:[Agent])) ===>
    cat> toinf,
    cat> (vp, vsem:(tense2:present, subcat:[Agent])).

inf_clause_request rule
    (inf_clause, vsem:(tense2:present, subcat:[Experiencer])) ===>
    cat> (Experiencer, np),
    cat> toinf,
    cat> (vp, vsem:(tense2:present, subcat:[Experiencer])).

vp_inf_tend rule
    (vp, vsem:(tense2:T, subcat:[Agent])) ===>
    cat> (v, vsem:(tense2:T, subcat:[Theme, Agent])),
    cat> (Theme, inf_clause, vsem:(tense2:present, subcat:[Agent])).

vp_inf_appear rule
    (vp, vsem:(tense2:T, subcat:[Agent])) ===>
    cat> (v, vsem:(tense2:T, subcat:[Theme])),
    cat> (Theme, inf_clause, vsem:(tense2:present, subcat[Agent])).

vp_inf_promise rule
    (vp, vsem:(tense2:T, subcat:[Agent])) ===>
    cat> (v, vsem:(tense2:T, subcat:[Theme, Beneficiary, Agent])),
    cat> (Beneficiary, np),
    cat> (Theme, inf_clause, vsem:(tense2:present, subcat:[Agent])).

% Lexicons
tend ---> (v, vsem:(tend, tense2:present, 
    subcat:[(inf_clause, Theme), (np, Agent)], 
    agent:Agent, theme:Theme)).

tended ---> (v, vsem:(tend, tense2:past, 
    subcat:[(inf_clause, Theme), (np, Agent)],
    agent:Agent, theme:Theme)).

appear ---> (v, vsem:(appear, tense2:present, 
    subcat:[(inf_clause, Theme)], theme:Theme)).

appeared ---> (v, vsem:(appear, tense2:past, 
    subcat:[(inf_clause, Theme)], theme:Theme)).

promise ---> (v, vsem:(promise, tense2:present, 
    subcat:[(inf_clause, Theme), (np, Beneficiary), (np, Agent)],
    theme:Theme, beneficiary:Beneficiary, agent:Agent)).

promised ---> (v, vsem:(promise, tense2:past, 
    subcat:[(inf_clause, Theme), (np, Beneficiary), (np, Agent)],
    theme:Theme, beneficiary:Beneficiary, agent:Agent)).

request ---> (v, vsem:(request, tense2:present, 
    subcat:[(inf_clause, Theme), (np, Beneficiary), (np, Agent)],
    theme:Theme, beneficiary:Beneficiary, agent:Agent)).

requested ---> (v, vsem:(request, tense2:past, 
    subcat:[(inf_clause, Theme), (np, Beneficiary), (np, Agent)],
    theme:Theme, beneficiary:Beneficiary, agent:Agent)).

sleep ---> (v, vsem:(sleep, tense2:present, 
    subcat:[(np, Experiencer)], experiencer:Experiencer)).

slept ---> (v, vsem:(sleep, tense2:past, 
    subcat:[(np, Experiencer)], experiencer:Experiencer)).

the ---> det.

to ---> toinf.

student ---> (n, nsem:student).

teacher ---> (n, nsem:teacher).
