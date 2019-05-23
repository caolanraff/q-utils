.qp.report:flip `function`params`start`finish`duration!();
.qp.orig:()!();

.qp.prj:{[f;p]
  st:.z.p;
  $[1<count p;.[.qp.orig f;p;{'x}];@[.qp.orig f;(*:)p;{'x}]];
  et:.z.p;
  .qp.report,:(f;p;st;et;et-st);
  };

.qp.func:{$[(`$1_($:)x)in key `;sv[`;]each x,/:where(type each(.:)x)=y;x]};

.qp.prof:{
  f:.qp.func[x;100];
  {.qp.orig[x]:(.:)x;
  tf:(')[.qp.prj[x];enlist];
  x set tf}each f;
  };

.qp.unprof:{
  f:.qp.func[x;105];
  {x set .qp.orig[x]}each f;
  };
