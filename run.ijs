load'general/unittest'
load 'jpm'

load'~Projects/mk_udovicic/docs.ijs'

test =: 3 : 0
 f =. 'var get occ ext uni equ fsh app apm dis con pul tak cis'
 pt =. jpath '~Projects/mk_udovicic/test.ijs'
 pp =. jpath '~Projects/mk_udovicic/microkanren.ijs'
 t =. 3 : ('unittest ''' , pt , '''')
 echo t ''
 echo 'Character count: ' , (2!:0) 'tr -d ''[:space:]'' < ' , pp , '| wc -c'
 start_jpm_ ''
 t ''
 echo 0 1 showtotal_jpm_ f
 1 1 showtotal_jpm_ f
)

test 0
exit 0
