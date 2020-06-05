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
        ne_list intro [hd:bot,tl:list].

% Rules
s rule
(s, tense:T) ===>
cat> (Agent, np),
cat> (vp, v_sem:(tense:T, subcat:[Agent])).

np rule
np ===>
cat> det,
cat> n.

inf_clause_v rule
(inf_clause) ===>
cat> toinf,
cat> (vp, v_sem:(tense:present, subcat:[Experiencer])).

inf_clause_vp rule
(inf_clause, v_sem:(tense:T, subcat:[Agent])) ===>
cat> toinf,
cat> (vp, v_sem:(tense:present, subcat:[Agent])).

vp_v rule
(vp, v_sem:(tense:T, subcat:[Agent])) ===>
cat> (v, v_sem:(tense:T, subcat:[Agent])).

vp_inf rule
(vp, v_sem:(tense:T, subcat:[Agent])) ===>
cat> (v, v_sem:(tense:T, subcat:[Theme, Agent])),
cat> (Theme, inf_clause, v_sem:(tense:present, subcat:[Agent])).

vpnp_inf rule
(vp, v_sem:(tense:T, subcat:[Agent])) ===>
cat> (v, v_sem:(tense:T, subcat:[Theme, Beneficiary, Agent])),
cat> (Beneficiary, np),
cat> (Theme, inf_clause, v_sem:(tense:present, subcat:[AGENT])).

% Lexicons
tend ---> (v, v_sem:(tend, tense:present, subcat:[(inf_clause, Theme), (np, Agent)])).

tended ---> (v, v_sem:(tend, tense:past, subcat:[(inf_clause, Theme), (np, Agent)])).

appear ---> (v, v_sem:(appear, tense:present, subcat:[(inf_clause, Theme)])).

appeared ---> (v, v_sem:(appear, tense:past, subcat:[(inf_clause, Theme)])).

promise ---> (v, v_sem:(promise, tense:present, subcat:[(inf_clause, Theme), (np, Beneficiary), (np, Agent)])).

promised ---> (v, v_sem:(promise, tense:past, subcat:[(inf_clause, Theme), (np, Beneficiary), (np, Agent)])).

request ---> (v, v_sem:(request, tense:present, subcat:[(inf_clause, Theme), (np, Beneficiary), (np, Agent)])).

requested ---> (v, v_sem:(request, tense:past, subcat:[(inf_clause, Theme), (np, Beneficiary), (np, Agent)])).

sleep ---> (v, v_sem:(sleep, tense:present, subcat:[(np, Experiencer)])).

slept ---> (v, v_sem:(sleep, tense:past, subcat:[(np, Experiencer)])).

the ---> det.

to ---> toinf.

student ---> (n, n_sem:student).

teacher ---> (n, n_sem:teacher).

