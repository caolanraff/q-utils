.access.authTables:()!();
.access.authTables[`class]:`table1`table2;

.access.tables:()!();
.access.updAcess:{.access.tables[x]:except[tables[];.access.authTables[x]]} each key .access.authTables;

.access.funcs:()!();
.access.funcs[`class]:(set;upsert;!;`upd);

.access.noupd:enlist `class;

.access.lamChk:{
  :$[count l:{x where 100h=type each x}raze except[raze parse x;each];
    raze{vs["}";last vs["{";string x]]}each l;""];
  };

.access.tabChk:{[c;x]
  if[not c in key .access.tables;:()];
  pt:(,//)parse each enlist[x],.access.lamChk[x];
  if[any raze pt~/:\:.access.tables c;'"No access to this table, see .access.authTables[`",string[c],"] for authorised list"];
  if[any raze pt~/:\:.access.funcs c;'"No access to this function"];
  };

.z.pg:{
  c:first exec class from .auth.user where user=.z.u;
  .access.tabChk[c;x];
  $[c in .access.noupd;reval(x;y);x y];
  }[.z.pg;]
