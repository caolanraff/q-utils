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

lbs:12+til 9;

res:flip`algorithm`uncompressed`compressed`msPerRead!();

// function definitions
//zstd (algorithm 5) needs kdb+ 4.1+, so only include it if this build can compress with it
zstdOk:{@[{-19!(x;y;17;5;1);hdel y;1b}[x];` sv dir,`zstdtest;0b]};

getCR:{[a;r]
  n:`$string[a],"_","_"sv string r;
  f:` sv dir,n;
  -19!(src;f;r 0;r 1;r 2);
  c:-21!f;
  tm:avg{system"t:1000 get `",string x}each 3#f;
  res,:(n;c`uncompressedLength;c`compressedLength;tm%1000);
  hdel f;
  };

main:{getCR[x]each crs[x]};

cleanup:{if[not ()~k:key x;hdel each ` sv/:x,/:k;hdel x]};

run:{
  src set value col;
  if[zstdOk src;@[`cfg;`zstd;:;(5;-7+til 30)]];
  crs::key[cfg]!{(lbs,\:cfg[x]0)cross cfg[x]1}'[key cfg];
  main each key crs;
  };

// main
@[run;::;{cleanup dir;'x}];
cleanup dir;
update perDec:100*(uncompressed-compressed)%uncompressed from `res;
delete from `res where perDec<0;
