\c 30 200
tidy:{ssr/[;("\"~~";"~~\"");("";"")] $[","=first x;1_x;x]};
strBrk:{y,(";" sv x),z};

//replace k representation with equivalent q keyword
kreplace:{[x] $[`=qval:.q?x;x;"~~",string[qval],"~~"]};
funcK:{$[0=t:type x;.z.s each x;t<100h;x;kreplace x]};

//replace eg ,`FD`ABC`DEF with "enlist`FD`ABC`DEF"
ereplace:{"~~enlist",(.Q.s1 first x),"~~"};
ereptest:{((0=type x) & (1=count x) & (11=type first x)) | ((11=type x)&(1=count x))};
funcEn:{$[ereptest x;ereplace x;0=type x;.z.s each x;x]};

basic:{tidy .Q.s1 funcK funcEn x};

addbraks:{"(",x,")"};

//where clause needs to be a list of where clauses, so if only one whereclause need to enlist.
stringify:{$[(0=type x) & 1=count x;"enlist ";""],basic x};

//if a dictionary apply to both, keys and values
ab:{$[(0=count x) | -1=type x;.Q.s1 x;99=type x;(addbraks stringify key x),"!",stringify value x;stringify x]};

inner:{[x]
  idxs:2 3 4 5 6 inter ainds:til count x;
  x:@[x;idxs;'[ab;eval]];
  if[6 in idxs;x[6]:ssr/[;("hopen";"hclose");("iasc";"idesc")] x[6]];
  //for select statements within select statements
  x[1]:$[-11=type x 1;x 1;[idxs,:1;.z.s x 1]];
  x:@[x;ainds except idxs;string];
  x[0],strBrk[1_x;"[";"]"]
  };

buildFuncSelect:{[x] inner parse x};
/show "Function is buildSelect";
