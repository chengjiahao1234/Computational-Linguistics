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
              intro [tense2:tense].
            tend sub [].
            appear sub [].
            promise sub [].
            request sub [].
            sleep sub [].

% Rules


% Lexicons
tend ---> (v, vsem:(tend, tense2:present)).

tended ---> (v, vsem:(tend, tense2:past)).

appear ---> (v, vsem:(appear, tense2:present)).

appeared ---> (v, vsem:(appear, tense2:past)).

promise ---> (v, vsem:(promise, tense2:present)).

promised ---> (v, vsem:(promise, tense2:past)).

request ---> (v, vsem:(request, tense2:present)).

requested ---> (v, vsem:(request, tense2:past)).

sleep ---> (v, vsem:(sleep, tense2:present)).

slept ---> (v, vsem:(sleep, tense2:past)).

the ---> det.

to ---> toinf.

student ---> (n, nsem:student).

teacher ---> (n, nsem:teacher).
