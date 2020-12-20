var=:(=&1@# *. +./@:e.&(;/'xyz'))

unify=: 4 : 0 NB.will require special case for non-boxed terms!
NB.TERM FORMATTING & HELPERS
 depthx=.L.x
 depthy=.L.y
 pomx=.2^<:depthx
 pomy=.2^<:depthy
 x=.(<x)(<0 0 0)}(depthx,pomx,4)$a: NB.a
 y=.(<y)(<0 0 0)}(depthx,pomx,4)$a: NB.b
 jx=.2&^i.depthx NB.broja
 jy=.2&^i.depthy NB.brojb
 kx=.depthx$_1 NB.broja1
 ky=.depthy$_1 NB.brojb1

NB.TERM RESTRUCTURING AS 3D ARRAYS
 x=.depthx jx formnivo kx x
 y=.depthy jy formnivo ky y
NB.other dimensions assignements
 x=.depthx oda jx x;'x' NB.required to pass a "quotation"
 y=.depthy oda jy y;'y'

NB.UNIFICATION PROPER
 for_j. i.depthx
  do.
   for_k. i.j{jx
    do.
     try. 'x y'=.j k unifclosure x y catcht. 'failure' return. end.
   end.
 end.

NB.BUILDING THE SUBSTITUTION LIST
 sigma =. ''
 for_j. i.depthx
  do.
   for_k. i.j{jx
    do.
     sigma=.j k dodajel x sigma
   end.
 end.
 for_j. i.depthy
  do.
   for_k. i.j{jy
    do.
     sigma=.j k dodajel y sigma
   end.
 end.

echo x{~<2 2 0
echo x{~<0 0 0
echo y{~<1 0 0
echo x{~<1 1 0

sigma
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
 'arr sym'=.y NB.required as a form of quotation
 for_j. i.u
  do.
   for_k. i.j{v
    do.
     if. (<_1)-.@-:arr{::~j,k,0 do. p=.var arr{::~j,k,0 end.
     arr=.(<<sym;j,k)(<j,k,1)}arr
     arr=.(<<0)(<j,k,2)}arr
     if. p do. arr=.(<<arr{::~j,k,0)(<j,k,3)}arr end.
     if. -.p do. arr=.(<a:)(<j,k,3)}arr end.
   end.
 end.
arr
)

spajanje =: 2 : 0 NB.x is n1; u is b1; v is a; y is b
 if. var {.v{::~x,u,0
  do.
   y=.(>:L:0 v{~<x,u,2)(<x,u,2)}y
   y=.(<@/:~@~.(v{::~x,u,3),(y{::~x,u,3))(<x,u,3)}y NB.consing on empty list
   v=.(<'y';x,u)(<x,u,1)}v
 else.
   v=.(>:L:0 v{~<x,u,2)(<x,u,2)}v
   v=.(<@/:~@~.(v{::~x,u,3),(y{::~x,u,3))(<x,u,3)}v NB.consing on empty list
   y=.(<'x';x,u)(<x,u,1)}y
 end.
v;<y
)

unifclosure =: 2 : 0 NB.x is n; u is redbr;v is a; y is b
 s1=.v{::~x,u,0
 t1=.y{::~x,u,0
 if. (s1-.@-:<_1)*.(t1-.@-:<_1)*.(s1-.@-:t1)
  do.
   if. (0-:var{.s1)*.(0-:var{.t1)
    do.
     if. (2<:L.s1)*.(2<:L.t1)*.({.s1)-:({.t1)
      do.
       'v y'=.x u spajanje v y
     else. throw.
     end.
   end.
   if. -.(0-:var{.s1)*.(0-:var{.t1)
    do.
     'v y'=.x u spajanje v y
   end.
 end.
v;<y
)

dodajel =: 2 : 0 NB. x is i; u is j; v is a; y is sigma
 if. (<_1)-.@-:v{::~x,u,0
  do.
   l=.v{::~x,u,3
   p=.var{.v{::~x,u,0
   if. (p=0)*.l-.@-:,a:
    do.
     y=.y,(v{~<x,u,3),v{~<x,u,1
   end.
 end.
y
)

NB.(<'a')unify(<'b')
NB.('f';<<'a')unify('g';<<'b')
NB.('f';(<'x');<'g';<<'a')unify('f';('g';<<'y');<'g';<<'y')
NB.('f';<<'x')unify('f';<<'a')

