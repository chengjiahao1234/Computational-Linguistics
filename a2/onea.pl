% Name: Jiahao Cheng, login_id: chengj60, student_id: 1003065737

bot sub [s, phrase, lexical].
	% all rules
	phrase sub [vp_sg, vp_pl, pp, np_sg, np_pl, np].

	% all lexicons
	lexical sub [nprp, n_pl, v_pl, v_sg, det, n_sg, p].
	
% Rules
npsg_vpsg__s rule
	s ===>
	cat> np_sg,
	cat> vp_sg.

nppl_vppl__s rule
	s ===>
	cat> np_pl,
	cat> vp_pl.

vsg_np__vpsg rule
	vp_sg ===>
	cat> v_sg,
	cat> np.

vpl_np__vppl rule
	vp_pl ===>
	cat> v_pl,
	cat> np.

vsg_np_pp__vpsg rule
	vp_sg ===>
	cat> v_sg,
	cat> np,
	cat> pp.

vpl_np_pp__vppl rule
	vp_pl ===>
	cat> v_pl,
	cat> np,
	cat> pp.

p_np__pp rule
	pp ===>
	cat> p,
	cat> np.

nprp__npsg rule
	np_sg ===>
	cat> nprp.

det_nsg__npsg rule
	np_sg ===>
	cat> det,
	cat> n_sg.

det_npl__nppl rule
	np_pl ===>
	cat> det,
	cat> n_pl.

npl__nppl rule
	np_pl ===>
	cat> n_pl.

npsg__np rule
	np ===>
	cat> np_sg.

nppl__np rule
	np ===>
	cat> np_pl.

% Lexicon
biscuits ---> n_pl.

dog ---> n_sg.

feed ---> v_pl.

feeds ---> v_sg.

fred ---> nprp.

puppies ---> n_pl.

the ---> det.

with ---> p.
