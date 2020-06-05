% Name: Jiahao Cheng, login_id: chengj60, student_id: 1003065737

bot sub [s, rule, lexicon].
	% all rules
	rule sub [vpsg, vppl, pp, npsg, nppl, np].

	% all lexicons
	lexicon sub [nprp, npl, vpl, vsg, det, nsg, p].
	
% Rules
s_sg rule
s ===>
cat> npsg,
cat> vpsg.

s_pl rule
s ===>
cat> nppl,
cat> vppl.

vpsg rule
vpsg ===>
cat> vsg,
cat> np.

vppl rule
vppl ===>
cat> vpl,
cat> np.

vpsg_pp rule
vpsg ===>
cat> vsg,
cat> np,
cat> pp.

vppl_pp rule
vppl ===>
cat> vpl,
cat> np,
cat> pp.

pp rule
pp ===>
cat> p,
cat> np.

npsg_pro rule
npsg ===>
cat> nprp.

npsg_det rule
npsg ===>
cat> det,
cat> nsg.

nppl_det rule
nppl ===>
cat> det,
cat> npl.

nppl rule
nppl ===>
cat> npl.

np_sg rule
np ===>
cat> npsg.

np_pl rule
np ===>
cat> nppl.

% Lexicon
fred ---> nprp.

biscuits ---> npl.

feed ---> vpl.

feeds ---> vsg.

the ---> det.

dog ---> nsg.

puppies ---> npl.

with ---> p.
