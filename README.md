# utils
Utility scripts

### compressRatio.q
Simple script to compare all possible combinations of the available compression algorithms (kdb+, gzip, snappy, lz4hc, and zstd on kdb+ 4.1+) and logical block sizes for a single flat file (1 column).
Results (`res`) contain the compressed/uncompressed sizes, percentage decrease in size (`perDec`) and the average time in ms to `get` the column (`msPerRead`, from `\t:1000` ran 3 times).
Combinations where compression made the file larger are removed from the results.
Accepts 1 optional input parameter (-col) to define your column values, default is 1000000?10f.
Temporary files are written to a `compressRatio_<pid>` directory, which is removed when the script finishes or fails.
Note: this takes a while at the default size, since each combination is read 3000 times (around 1 minute for 10000 floats, longer with zstd).

### qprof.q
Simple Q profiler script which will wrap all functions within the process and process run times into a report table. Can also unprofile once complete.

### buildFuncSelect.q
Converts a qSQL query string into its equivalent functional form, as a string:
```q
q)buildFuncSelect "select a,b by c from t where a in 1 2"
"?[t;enlist (in;`a;1 2);(enlist `c)!enlist `c;(`a`b)!`a`b]"
```
Works for select, exec, update and delete, including nested selects and `select[n]` / `select[>col]`.

### access.q
Access script to restrict users on a per table basis, per function basis or simply to not allow execution of any updates. 
Wraps both `.z.pg` (sync) and `.z.ps` (async). Users are mapped to a class via `.auth.user`, and users not in that table are rejected.

**Note:** table/function checks match symbols in the parse tree of the query, so they guard against accidental access only. Dynamically built references (e.g. ``value "table1"`` or ``value `$"tab","le1"``) are not caught, so do not rely on this as a security boundary. The no-update restriction uses `reval`, which is enforced by kdb+ itself.
