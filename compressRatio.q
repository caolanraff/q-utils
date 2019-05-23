/ -col [provide randomised values for col (1mil floats by default)]
if[not count col:raze .Q.opt[.z.x]`col;col:"1000000?10f"];

// variable definitions
cfg:()!();
cfg[`kdb]:(1;0);
cfg[`gzip]:(2;til 10);
cfg[`snappy]:(3;0);
cfg[`lz4hc]:(4;1+til 12);

lbs:12+til 9;
crs:key[cfg]!{(lbs,\:cfg[x]0)cross cfg[x]1}'[key cfg];

res:flip`algorithm`uncompressed`compressed`time!();

// function definitions
getCR:{[a;r]
  tar:hsym `$string[a],"_","_"sv string r;
  -19!(`:col;tar;r 0;r 1;r 2);
  c:value -21!tar;
  tm:avg{[x;y]system"t:1000 get `",string x}[tar]'[3#`];
  res,:(tar;c 1;c 0;tm);
  system"rm ",1_string tar;
  };

main:{getCR[x]each crs[x]};

// main
`:col set value col;
main each key crs;
system"rm col";
update perDec:100*(uncompressed-compressed)%uncompressed from `res;
delete from `res where perDec<0;
