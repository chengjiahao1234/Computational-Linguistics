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
            tend sub [] intro [agent:np, theme:inf_clause].
            appear sub [] intro [theme:inf_clause].
            promise sub [] intro [agent:np, theme:inf_clause, beneficiary:np].
            request sub [] intro [agent:np, theme:inf_clause, beneficiary:np].
            sleep sub [] intro [experiencer:np].
    
    % list
    list sub [e_list,ne_list].
        ne_list intro [hd:bot,tl:list].

% Rules
np_vp__s rule
    (s, tense:T) ===>
    cat> (np, nsem:N, Agent),
    cat> (vp, vsem:(tense2:T, subcat:[Agent|_])).

det_n__np rule
    (np, nsem:N) ===>
    cat> det,
    cat> (n, nsem:N).

to_v__inf_sleep rule
    (inf_clause, vsem:(tense2:present, subcat:[Experiencer])) ===>
    cat> toinf,
    cat> (v, vsem:(sleep, tense2:present, subcat:[Experiencer])).

to_vp__inf rule
    (inf_clause, vsem:(tense2:present, subcat:Rest)) ===>
    cat> toinf,
    cat> (vp, vsem:(tense2:present, subcat:Rest)).

v_inf__vp_tend rule
    (vp, vsem:(tense2:T, subcat:[Agent])) ===>
    cat> (v, vsem:(tend, tense2:T, subcat:[Theme|Agent])),
    cat> (inf_clause, vsem:(tense2:present, subcat:[Experiencer]), Theme).

v_inf__vp_appear rule
    (vp, vsem:(tense2:T, subcat:[Experiencer])) ===>
    cat> (v, vsem:(appear, tense2:T, subcat:[Theme])),
    cat> (inf_clause, vsem:(tense2:present, subcat:[Experiencer]), Theme).

v_inf__vp_promise rule
    (vp, vsem:(tense2:T, subcat:[Experiencer|Rest])) ===>
    cat> (v, vsem:(promise, tense2:T, subcat:[Theme|[Beneficiary|Rest]])),
    cat> (np, nsem:N, Beneficiary),
    cat> (inf_clause, vsem:(tense2:present, subcat:[Experiencer]), Theme).

v_inf__vp_request rule
    (vp, vsem:(tense2:T, subcat:[Agent])) ===>
    cat> (v, vsem:(request, tense2:T, subcat:[Theme|[Beneficiary|Agent]])),
    cat> (np, nsem:N, Beneficiary, Experiencer),
    cat> (inf_clause, vsem:(tense2:present, subcat:[Experiencer]), Theme).

% Lexicons
tend ---> (v, vsem:(tend, tense2:present,
    subcat:[(np, Agent), (inf_clause, Theme)],
    agent:Agent, theme:Theme)).

tended ---> (v, vsem:(tend, tense2:past,
    subcat:[(np, Agent), (inf_clause, Theme)],
    agent:Agent, theme:Theme)).

appear ---> (v, vsem:(appear, tense2:present,
    subcat:[(inf_clause, Theme)],
    theme:Theme)).

appeared ---> (v, vsem:(appear, tense2:past,
    subcat:[(inf_clause, Theme)],
    theme:Theme)).

promise ---> (v, vsem:(promise, tense2:present,
    subcat:[(np, Agent), (inf_clause, Theme), (np, Beneficiary)],
    agent:Agent, theme:Theme, beneficiary:Beneficiary)).

promised ---> (v, vsem:(promise, tense2:past,
    subcat:[(np, Agent), (inf_clause, Theme), (np, Beneficiary)],
    agent:Agent, theme:Theme, beneficiary:Beneficiary)).

request ---> (v, vsem:(request, tense2:present,
    subcat:[(np, Agent), (inf_clause, Theme), (np, Beneficiary)],
    agent:Agent, theme:Theme, beneficiary:Beneficiary)).

requested ---> (v, vsem:(request, tense2:past,
    subcat:[(np, Agent), (inf_clause, Theme), (np, Beneficiary)],
    agent:Agent, theme:Theme, beneficiary:Beneficiary)).

sleep ---> (v, vsem:(sleep, tense2:present,
    subcat:[(np, Experiencer)],
    experiencer:Experiencer)).

slept ---> (v, vsem:(sleep, tense2:past,
    subcat:[(np, Experiencer)],
    experiencer:Experiencer)).

the ---> det.

to ---> toinf.

student ---> (n, nsem:student).

teacher ---> (n, nsem:teacher).
