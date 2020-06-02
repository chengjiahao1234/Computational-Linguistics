% Name: Jiahao Cheng, login_id: chengj60 student_id: 1003065737

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
s rule
(s, num:A) ===>
cat> (np, num:A),
cat> (vp, num:A).

vp rule
(vp, num:A) ===>
cat> (v, num:A),
cat> np.

vp_pp rule
(vp, num:A) ===>
cat> (v, num:A),
cat> np,
cat> pp.

pp rule
pp ===>
cat> p,
cat> np.

np rule
(np, num:A, is_pr:P) ===>
cat> (n, num:A, is_pr:P).

np_det rule
(np, num:A, is_pr:P) ===>
cat> det,
cat> (n, num:A, is_pr:P).

% Lexicon
fred ---> (np, num:sg, is_pr:pr).

biscuits ---> (n, num:pl, is_pr:npr).

feed ---> (v, num:pl).

feeds ---> (v, num:sg).

the ---> det.

dog ---> (n, num:sg, is_pr:npr).

puppies ---> (n, num:pl, is_pr:npr).

with ---> p.
