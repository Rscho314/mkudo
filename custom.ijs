NB. custom unification algo

a=:'f';('g';(<'g';'b'));1
b=:'f';('g';0);<'c';'d';'e'
c=:'f';('g';(<'a';'b'));<'c';'d';'e'
d=:'f';0;1
e=:'f';('a';'b');<'c';'d';'e'

NB.=============MAIN===============
NB.------prerequisites-------------
pth_x =: {::a
pth_y =: {::b
ptr_x =: <S:1 pth_x
ptr_y =: <S:1 pth_y
nodes_x =: <S:0 a
nodes_y =: <S:0 b

NB.------check residue-------
all_ptr=:ptr_x,ptr_y
all_nodes=:nodes_x,nodes_y
node_keys =: i.~ all_nodes
ptr_keys =: i.~ all_ptr
residue_coverage =: (~: *. ~:&.|.)ptr_keys,.node_keys

NB.------main unification problem-------------
is_variable =: e.&1 4@(3!:0)
variable_sieve_x =: is_variable@> nodes_x
variable_sieve_y =: is_variable@> nodes_y

unification_coverage_x =:+./variable_sieve_y,ptr_y E.~"(_ 0) <S:1 {::&pth_y &.> variable_sieve_x # ptr_x
unification_coverage_y =:+./variable_sieve_x,ptr_x E.~"(_ 0) <S:1 {::&pth_x &.> variable_sieve_y # ptr_y
unification_coverage=:residue_coverage-:unification_coverage_y,unification_coverage_x

unification_pairs_x =:(variable_sieve_x # nodes_x),.{::&b &.> variable_sieve_x # ptr_x
unification_pairs_y =:(variable_sieve_y # nodes_y),.{::&a &.> variable_sieve_y # ptr_y

NB.---------occurs check---------------------------


NB.---------check unification for conflicts---------


NB.=============MEMO===============
0 : 0
-combining sorting + depth vector likely allows subtree isolation
-same node_key&same ptr_key-|trivially unifiable=>discard pair!
)

NB.ptr_sorter =: /: ptr_no_residue
NB.sorted_ptr =: ptr_sorter { ptr_no_residue
NB.sorted_nodes =: ptr_sorter { nodes_no_residue
NB.depth_vector =: #S:1 sorted_ptr
NB.subtree_selector =: +/\&.|.0,~ 2 > /\ depth_vector

NB.is_variable =: e.&1 4@(3!:0)
NB.depth =: (#S:1)@]
NB.sieve_ptr =: ~: all_ptr
NB.variable_nodes =: is_variable@> all_nodes
NB.common_ptr =: all_ptr #~  -. sieve_ptr
NB.unique_ptr =: sieve_ptr # all_ptr

NB.sorted_permutation_ptr =: /: all_ptr
NB.sorted_sieve_ptr =: sorted_permutation_ptr { sieve_ptr
NB.sorted_unique_ptr=:sorted_sieve_ptr#sorted_permutation_ptr{all_ptr
NB.sorted_nodes =: sorted_permutation_ptr { all_nodes
NB.sorted_unique_nodes =: sorted_sieve_ptr # sorted_nodes
NB.sorted_nodes_depth =: depth sorted_unique_ptr

NB.node_count =: #@(<S:0)

NB.unificand_vector =: ,@|.@(2&,@-: $ i.)@:#

NB.check_unification_pt =:(-:/)`]`]`]@.(#.@:(is_variable@>))
NB.check_unification_pts =: *./@:check_unification_pt


NB.unification_pts =: ({::&b &.> common_ptr) ,. {::&a &.> common_ptr
NB.nonvars_unify =: check_unification_pts unification_pts

NB.paths of the unified tree, depth-first pre-order ready
NB.unified_ptr =: /:~ ~. all_ptr
NB.depth vector, will be used for subtree capture later on
NB.depth_unified =: #@> unified_ptr


NB.(<S:1)@{:: a,b saturated unified tree paths
NB. {::&(a,b) &.> (<S:1)@{:: a,b get back nodes
NB. (/:~~.<S:1 a({::@[,{::@])b) shape of the unified tree
NB. 
