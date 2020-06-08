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
        % tense2 sub [present,past].
        v_sem sub [tend, appear, promise, expect, request, sleep]
              intro [tense2:tense, subcat:list].     % This should not be empty!  Fill in features for this and
                            % the following subtypes:
            tend sub [] intro [agent_t:np, theme_t:inf_clause].
            appear sub [] intro [theme_a:inf_clause].
            promise sub [] intro [agent_p:np, theme_p:inf_clause, beneficiary_p:np].
            request sub [] intro [agent_r:np, theme_r:inf_clause, beneficiary_r:np].
            sleep sub [] intro [experiencer:np].
            expect sub [] intro [agent_exp:np, theme_exp:inf_clause].

	list sub [e_list,ne_list].
		ne_list intro [hd:bot,tl:list].

np_vp__s rule
    s ===>
    cat> (np, nsem:N, A),
    cat> (vp, vsem:(tense2:past,subcat:[A])).

det_n__np rule
    (np, nsem:N) ===>
    cat> det,
    cat> (n, nsem:N).

vp_inf__vp_tend rule
	(vp, vsem:(tense2:T, subcat:[A])) ===>
	cat> (v, vsem:(tend, tense2:T, subcat:[A, B])),
	cat> (inf_clause, vsem:(tense2:present, subcat:[A]), B).

%passing beneficiary for promise sentences
vp_inf_pro rule
(vp,vsem:(tense2:Tense,subcat:[A])) ===>
cat> (v,vsem:(tense2:Tense,subcat:[A,B,C])),
cat> (np,C,nsem:N_sem),
cat> (inf_clause, B,vsem:(tense2:present,subcat:[A])).

vp_inf_apr rule
(vp,vsem:(tense2:Tense,subcat:[A])) ===>
cat> (v,vsem:(tense2:Tense,subcat:[B])),
cat> (inf_clause, B,vsem:(tense2:present,subcat:[A])).

vp_v rule
(vp,vsem:(tense2:Tense,subcat:[A])) ===>
cat> (v,vsem:(tense2:Tense,subcat:[A])).

vp_np rule
(vp,vsem:(tense2:Tense,subcat:[A]))  ===>
cat> (v,vsem:(tense2:Tense,subcat:[A,B])),
cat> (inf_clause,B, vsem:(tense2:present,subcat:[A]).

%passing experiencer for expect sentences
v_inf_clause_exp rule
(inf_clause,vsem:(tense2:Tense)) ===>
cat> (np,nsem:N_sem,A),
cat> toinf,
cat> (vp,vsem:(tense2:present,subcat:[A])).

v_inf_clause rule
(inf_clause,vsem:(tense2:Tense,subcat:[A])) ===>
cat> toinf,
cat> (vp,vsem:(tense2:present,subcat:[A])).

%[A,B,C] is equal to [AGENT,THEME,BENEFICIARY]
% Lexicons
tend ---> (v, vsem:(tend, tense2:present,
    subcat:[(np, Agent), (inf_clause, Theme)],
    agent_t:Agent, theme_t:Theme)).

tended ---> (v, vsem:(tend, tense2:past,
    subcat:[(np, Agent), (inf_clause, Theme)],
    agent_t:Agent, theme_t:Theme)).

appear ---> (v, vsem:(appear, tense2:present,
    subcat:[(inf_clause, Theme)],
    theme_a:Theme)).

appeared ---> (v, vsem:(appear, tense2:past,
    subcat:[(inf_clause, Theme)],
    theme_a:Theme)).

promise ---> (v, vsem:(promise, tense2:present,
    subcat:[(np, Agent), (inf_clause, Theme), (np, Beneficiary)],
    agent_p:Agent, theme_p:Theme, beneficiary_p:Beneficiary)).

promised ---> (v, vsem:(promise, tense2:past,
    subcat:[(np, Agent), (inf_clause, Theme), (np, Beneficiary)],
    agent_p:Agent, theme_p:Theme, beneficiary_p:Beneficiary)).

request ---> (v, vsem:(request, tense2:present,
    subcat:[(np, Agent), (inf_clause, Theme), (np, Beneficiary)],
    agent_r:Agent, theme_r:Theme, beneficiary_r:Beneficiary)).

requested ---> (v, vsem:(request, tense2:past,
    subcat:[(np, Agent), (inf_clause, Theme), (np, Beneficiary)],
    agent_r:Agent, theme_r:Theme, beneficiary_r:Beneficiary)).

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
