.qp.report:flip `function`params`start`finish`duration!();
.qp.orig:()!();

.qp.prj:{[f;p]
  st:.z.p;
  r:@[{(1b;$[1<count y;x . y;x(*:)y])}[.qp.orig f];p;{(0b;x)}];
  et:.z.p;
  .qp.report,:(f;p;st;et;et-st);
  $[r 0;r 1;'r 1]
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
