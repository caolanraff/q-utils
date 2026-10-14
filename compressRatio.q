/ -col [provide randomised values for col (1mil floats by default)]
if[not count col:raze .Q.opt[.z.x]`col;col:"1000000?10f"];

// variable definitions
dir:hsym `$"compressRatio_",string .z.i;
src:` sv dir,`col;

cfg:()!();
cfg[`kdb]:(1;0);
cfg[`gzip]:(2;til 10);
cfg[`snappy]:(3;0);
cfg[`lz4hc]:(4;1+til 12);
//zstd (algorithm 5) was added in the kdb+ 4.1 release (2024.02.13)
if[(.z.K>=4.1)&.z.k>=2024.02.13;cfg[`zstd]:(5;-7+til 30)];

lbs:12+til 9;

res:flip`algorithm`uncompressed`compressed`msPerRead!();

// function definitions
getCR:{[a;r]
  n:`$string[a],"_","_"sv string r;
  f:` sv dir,n;
  -19!(src;f;r 0;r 1;r 2);
  c:-21!f;
  tm:avg{system"t:1000 get `",string x}each 3#f;
  res,:(n;c`uncompressedLength;c`compressedLength;tm%1000);
  hdel f;
  };

cleanup:{if[not ()~k:key x;hdel each ` sv/:x,/:k;hdel x]};

run:{
  src set value col;
  {getCR[x]each(lbs,\:cfg[x]0)cross cfg[x]1}each key cfg;
  update perDec:100*(uncompressed-compressed)%uncompressed from `res;
  delete from `res where perDec<0;
  };

// main
@[run;::;{cleanup dir;'x}];
cleanup dir;
