
NB.var=:0:`(-:&1@*)@.(-:&''@$*. e.&1 4@(3!:0))
NB.for now, changed variable definition as in Udovicic
var=:(=&1@# *. +./@:e.&(;/'xyz'))

unify=: 4 : 0 NB.will require special case for non-boxed terms!
NB.TERM FORMATTING & HELPERS
 depthx=.L.x
 depthy=.L.y
 pomx=.2^<:depthx
 pomy=.2^<:depthy
 x=.(<x)(<0 0 0)}(depthx,pomx,4)$<_ NB.a
 y=.(<y)(<0 0 0)}(depthx,pomx,4)$<_ NB.b
 jx=.2&^i.depthx NB.broja
 jy=.2&^i.depthy NB.brojb
 kx=.depthx$_1 NB.broja1
 ky=.depthy$_1 NB.brojb1

NB.TERM RESTRUCTURING AS 3D ARRAYS
 x=.depthx jx formnivo kx x
 y=.depthy jy formnivo ky y
NB.other dimensions assignements
 x=.depthx oda jx x
 y=.depthy oda jy y

NB.UNIFICATION PROPER
NB.term merging

 y
)

formnivo =: 2 : 0 NB.formnivoa:x=depthx;u=broja;v=broja1;y=a
 for_j. }.i.x
  do.
   for_k. i.u{~<:j
    do.
     s=.y{::~(<:j),k,0
     if. (-.@-:&(<0)-.@*.-.@-:&1@L.) s
      do.
       for. i.2
        do.
         v=.(>:v{~j)j}v
         y=.(<<_1)(<j,(v{~j),0)}y
       end.
     end.
     if. 2<:L. s
      do.
       l=.(#~;@:(=&32@(3!:0) &.>)) s
       v=.(>:v{~j)j}v
       y=.({.l)(<j,(v{~j),0)}y
       l=.}.l
       v=.(>:v{~j)j}v
       if. l-.@-:'' do. y=.({.l)(<j,(v{~j),0)}y end.
       if. l-:'' do. y=.(<<_1)(<j,(v{~j),0)}y end.
     end.
   end. 
 end.
y
)

oda =: 2 : 0 NB.depthx oda jx x
 for_j. i.u
  do.
   for_k. i.j{v
    do.
     if. (<_1)-.@-:y{::~j,k,0 do. p=.var y{::~j,k,0 end.
     y=.(<<'t';j,k)(<j,k,1)}y NB.'t' is the "symbol quotation"
     y=.(<<0)(<j,k,2)}y
     if. p do. y=.(<<y{::~j,k,0)(<j,k,3)}y end.
     if. -.p do. y=.(<a:)(<j,k,3)}y end.
   end.
 end.
y
)

NB.(<'a')unify(<'b')
NB.('f';<<'a')unify('g';<<'b')
NB.('f';(<'x');<'g';<<'a')unify('f';('g';<<'y');<'g';<<'y')

