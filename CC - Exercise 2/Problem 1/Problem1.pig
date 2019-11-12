-- Problem 1 - Exercise 2 - Group 8 - 2019/2020

records = LOAD 'yago_full_clean.tsv' using PigStorage(' ') AS (subject:chararray, predicate:chararray, object:chararray);
groups = GROUP records BY predicate;
predicates = FOREACH groups GENERATE group AS predicate, COUNT(records) AS count;
sorted = ORDER predicates BY count DESC;
top = LIMIT sorted 3;
STORE top INTO 'Exercise2/Problem1/output';
