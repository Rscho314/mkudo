
var=:0:`(-:&1@*)@.(-:&''@$*. e.&1 4@(3!:0))

unify=: 4 : 0
NB.will require special case for non-boxed terms!
NB.Term formatting & helpers
 depthx=.L.x
 
 pomx=.2^<:depthx

 a=.(<x)(<0 0 0)}(depthx,pomx,4)$<_

 broja=.2&^i.depthx
 broja1=.depthx$_1

NB.Term restructuring as 3D array
 for_j.}.i.depthx
  do.
   for_k. i.broja{~<:j
    do.
     s2=.a{::~(<:j),k,0
     if.(-.@-:&(<0)-.@*.-.@-:&1@L.) s2
      do.
       for. i.2
        do.
         broja1=.(>:broja1{~j)j}broja1
         a=.(<<0)(<j,(broja1{~j),0)}a
       end.
     end.
     if. 2<:L.s2
      do.
       l=.(#~;@:(=&32@(3!:0) &.>)) s2
       broja1=.(>:broja1{~j)j}broja1
       a=.({.l)(<j,(broja1{~j),0)}a
       l=.}.l
       broja1=.(>:broja1{~j)j}broja1
       if. l-.@-:'' do. a=.({.l)(<j,(broja1{~j),0)}a end.
       if. l-:'' do. a=.(<<0)(<j,(broja1{~j),0)}a end.
     end.
   end. 
 end.
)

NB.(<'a')unify(<'b')
NB.('f';<<'a')unify('g';<<'b')
NB.('f';(<'x');<'g';<<'a')unify('f';('g';<<'y');<'g';<<'y')

