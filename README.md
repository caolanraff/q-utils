# utils
Utility scripts

### compressRatio.q
Simple script to compare all possible combinations of the 4 available compression algorithms (kdb+, gzip, snappy, lz4hc) for a single flat file (1 column).
Results will contain percentage decrease in size and the time to get column with t:1000 ran 3 times and the average taken.
Accepts 1 optional input parameter (-col) to define your column values, default is 1000000?10f

### qprof.q
Simple Q profiler script which will wrap all functions within the process and process run times into a report table. Can also unprofile once complete.

### access.q
Access script to restrict users on a per table basis, per function basis or simply to not allow execution of any updates. 
Wraps both `.z.pg` (sync) and `.z.ps` (async). Users are mapped to a class via `.auth.user`, and users not in that table are rejected.

**Note:** table/function checks match symbols in the parse tree of the query, so they guard against accidental access only. Dynamically built references (e.g. ``value "table1"`` or ``value `$"tab","le1"``) are not caught, so do not rely on this as a security boundary. The no-update restriction uses `reval`, which is enforced by kdb+ itself.
