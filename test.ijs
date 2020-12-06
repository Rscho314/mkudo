load'~Projects/mk_udovicic/microkanren.ijs'

ini =: ''
t1 =: 'f';0;<'g';<<'a'
t2 =: 'f';('g';<<1);<('g';<<1)
t3 =: 'f';('f';('f';(2;1));'a');(<'g';<<0)
t4 =: 'f';('f';('f';('g';<<'a');'b');0);2
t5 =: 'f';t3;'b'
t6 =: 'f';t4;1
t7 =: 'f';('f';('f';('g';('g';<<'a');'b');0);2);1

fives =: 3 : 0
 ((5.0) equ (<:#y)) dis (3 : '<''3 : ''''fives ('' , ((5!:5) <''y'') , '')'''' ''') y
)
sixes =: 3 : 0
 ((6.0) equ (<:#y)) dis (3 : '<''sixes ('' , ((5!:5) <''y'') , '')''') y
)

fives_and_sixes =: 3 : 'fives dis sixes y'

peano =: 3 : 0
 (3 :'''z'' equ (<:#y) y') dis ((3 :'(2-~#y) equ (''s'';<:@#y) y') con (3 : '<''peano ('',((5!:5)<''y''),'')''') fsh) y
)

test_varunivar =: 3 : 'assert. (1;1) -: (1 uni 0) ext 2 fsh ini'

test_udovicic1 =: 3 : 'assert. ((<(<''g''),<<1),<''a'') -: (t1 uni t2) ext 2 fsh ini'
test_udovicic2 =: 3 : 'assert. ((<''a''),(<''b''),<(<''g''),<<0) -: (t3 uni t4) ext 3 fsh ini'
test_udovicic3 =: 3 : 'assert. ((<''a''),(<''b''),<(<''g''),<<0) -: (t5 uni t6) ext 3 fsh ini'
test_udovicic4 =: 3 : 'assert. ini -: (t5 uni t7) ext 3 fsh ini'

test_no_residual =: 3 : 'assert. (,<''a'') -: (0 uni ''a'') ext 1 fsh ini'
test_occurs_check =: 3 : 'assert. ini -: (0 uni ''f'';0) ext 1 fsh ini'
test_indirect_occurs_check =: 3 : 'assert. ini -: ((''f'';<(0;<<1)) uni ''f'';1) ext 2 fsh ini'
test_rank_polymorphic_unification =: 3 : 'assert. (''ab'';''cd'') -: (0 1 uni"(0 1) ''ab'',:''cd'') ext 2 fsh ini'

test_udovicic_on_terms =: 3 : 'assert. ini -: (t3 uni (''f'';(''f'';(''f'';(''g'';<<''c'');''b'');0);2)) ext 3 fsh ini'

test_trivial_disjunction =: 3 : 'assert. ((<''z'';1),<''sz'';1) -: (''z'' equ 0) dis (''sz'' equ 0) 2 fsh ini'
