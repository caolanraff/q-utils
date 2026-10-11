.access.authTables:()!();
.access.authTables[`class]:`table1`table2;

.access.tables:{except[tables[];.access.authTables x]};

.access.funcs:()!();
.access.funcs[`class]:(set;upsert;!;`upd);

.access.noupd:enlist `class;

.access.lamChk:{
  :$[count l:{x where 100h=type each x}raze except[raze parse x;each];
    raze{vs["}";last vs["{";string x]]}each l;""];
  };

.access.tabChk:{[c;x]
  if[not c in key .access.authTables;:()];
  pt:(,//)parse each enlist[x],.access.lamChk[x];
  if[any raze pt~/:\:.access.tables c;'"No access to this table, see .access.authTables[`",string[c],"] for authorised list"];
  if[any raze pt~/:\:.access.funcs c;'"No access to this function"];
  };

.access.wrap:{[h;x]
  if[null c:first exec class from .auth.user where user=.z.u;'"No access, user not in .auth.user"];
  .access.tabChk[c;x];
  $[c in .access.noupd;reval(h;x);h x]
  };

.z.pg:.access.wrap[@[get;`.z.pg;{value}]];
.z.ps:.access.wrap[@[get;`.z.ps;{value}]];
