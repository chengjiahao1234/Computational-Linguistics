% Name: Jiahao Cheng, login_id: chengj60 student_id: 1003065737

bot sub [cat, num, proper].
	cat sub [s, has_feature, det, pp].
		has_feature sub [noun, v, vp] intro [num:num].
			noun sub [np, n] intro [is_pr:proper].
				n intro [is_pr:npr]
	num sub [sg, pl].
	proper sub [pr, npr].
	
% Rules
s rule
s ===>
cat> (np, num:A, is_pr:proper),
cat> (vp, num:A).

vp_1 rule
(vp, num:A) ===>
cat> (v, num:A),
cat> np.

vp_2 rule
(vp, num:A) ===>
cat> (v, num:A),
cat> np),
cat> pp.

pp rule
pp ===>
cat> p,
cat> np.

np_1 rule
(np, num:A, is_pr:P) ===>
cat> (n, num:A, is_pr:P).

np_2 rule
(np, num:A) ===>
cat> det,
cat> (n, num:A).

% Lexicon
Fred ---> (np, num:sg, is_pr:pr).
biscuits ---> (n, num:pl).
feed ---> (v, num:pl).
feeds ---> (v, num:sg).
the ---> det.
dog ---> (n, num:sg).
puppies ---> (n, num:pl).
with ---> p.

