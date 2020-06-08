% Name: Jiahao Cheng, login_id: chengj60, student_id: 1003065737

bot sub [cat, num, proper].
	% all categories
	cat sub [has_feature, det, p, pp].
		% all categories that could have features
		has_feature sub [s, noun, verb] intro [num:num].
			% nouns
			noun sub [n, np] intro [is_pr:proper].

			% verbs
			verb sub [v, vp].

	% The feature indicating whether the word is singular or plural.
	num sub [sg, pl].

	% The feature indicating whether it is the proper noun.
	proper sub [pr, npr].
	
% Rules
np_vp__s rule
	(s, num:A) ===>
	cat> (np, num:A),
	cat> (vp, num:A).

v_np__vp rule
	(vp, num:A) ===>
	cat> (v, num:A),
	cat> np.

v_np_pp__vp rule
	(vp, num:A) ===>
	cat> (v, num:A),
	cat> np,
	cat> pp.

p_np__pp rule
	pp ===>
	cat> p,
	cat> np.

n__np rule
	(np, num:A, is_pr:P) ===>
	cat> (n, num:A, is_pr:P).

det_n__np rule
	(np, num:A, is_pr:P) ===>
	cat> det,
	cat> (n, num:A, is_pr:P).

% Lexicon
biscuits ---> (n, num:pl, is_pr:npr).

dog ---> (n, num:sg, is_pr:npr).

feed ---> (v, num:pl).

feeds ---> (v, num:sg).

fred ---> (np, num:sg, is_pr:pr).

puppies ---> (n, num:pl, is_pr:npr).

the ---> det.

with ---> p.
