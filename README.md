# utils
Utility scripts

## compressRatio.q
Simple script to compare all possible combinations of the 4 available compression algorithms (kdb+, gzip, snappy, lz4hc) for a single flat file (1 column).
Results will contain percentage decrease in size and the time to get column with t:1000 ran 3 times and the average taken.
Accepts 1 optional input parameter (-col) to define your column values, default is 1000000?10f

## qprof.q
Simple Q profiler script which will wrap all functions within the process and process run times into a report table. Can also unprofile once complete.
