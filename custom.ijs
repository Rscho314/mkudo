NB. custom unification algo

a=:('f';('g';(<'a';'b'));1)
b=:('f';('g';0);(<'c';'d';'e'))

node_count =: #@(<S:0)
depth_vector =: (#S:1)@{::
unificand_vector =: ,@|.@(2&,@-: $ i.)@:#

is_variable =: e.&1 4@(3!:0)
check_unification_pt =:(-:/)`]`]`]@.(#.@:(is_variable@>))
check_unification_pts =: *./@:check_unification_pt

all_ptr =: a (<S:1)@({::@[,{::@]) b

NB.WRONG: vars may appear in both unique & common subsets!
NB.those are the 'points of contact' of the terms
common_ptr =: (#~-.@~:) all_ptr
NB.list the 'points of contact'
unification_pts =: ({::&b &.> common_ptr) ,. {::&a &.> common_ptr
nonvars_unify =: check_unification_pts unification_pts
NB.those are the variables & subtrees
unique_ptr =: all_ptr -. common_ptr

NB.paths of the unified tree, depth-first pre-order ready
unified_ptr =: /:~ ~. all_ptr
NB.depth vector, will be used for subtree capture later on
depth_unified =: #@> unified_ptr


NB.(<S:1)@{:: a,b saturated unified tree paths
NB. {::&(a,b) &.> (<S:1)@{:: a,b get back nodes
NB. (/:~~.<S:1 a({::@[,{::@])b) shape of the unified tree
NB. 
