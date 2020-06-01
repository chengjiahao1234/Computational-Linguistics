% Name: Jiahao Cheng, login_id: chengj60 student_id: 1003065737

bot sub [s, rule, lexicon].
	rule sub [vpsg, vppl, pp, npsg, nppl, np].
	lexicon sub [nprp, npl, vpl, vsg, det, nsg, p].
	
% Rules
s_1 rule
s ===>
cat> npsg,
cat> vpsg.

s_2 rule
s ===>
cat> nppl,
cat> vppl.

vpsg_1 rule
vpsg ===>
cat> vsg,
cat> np.

vppl_1 rule
vppl ===>
cat> cpl,
cat> np.

vpsg_2 rule
vpsg ===>
cat> vsg,
cat> np,
cat> pp.

vppl_2 rule
vppl ===>
cat> vpl,
cat> np,
cat> pp.

pp rule
pp ===>
cat> p,
cat> np.

npsg_1 rule
npsg ===>
cat> nprp.

npsg_2 rule
npsg ===>
cat> det,
cat> nsg.

nppl_1 rule
nppl ===>
cat> det,
cat> nsg.

nppl_2 rule
nppl ===>
cat> npl.

np_1 rule
np ===>
cat> npsg.

np_2 rule
np ===>
cat> nppl.

% Lexicon
Fred ---> nprp.
biscuits ---> npl.
feed ---> vpl.
feeds ---> vsg.
the ---> det.
dog ---> nsg.
puppies ---> npl.
with ---> p.
