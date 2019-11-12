-- Problem 2 - Exercise 2 - Group 8 - 2019/2020

records = LOAD 'yago_full_clean.tsv' using PigStorage(' ') AS (subject:chararray, predicate:chararray, object:chararray);
filter_name = FILTER records BY predicate MATCHES '<hasGivenName>';
groups_name = GROUP filter_name BY subject;
filter_livesin = FILTER records BY predicate MATCHES '<livesIn>';
groups_livesin = GROUP filter_livesin BY subject;
count = FOREACH groups_livesin GENERATE (COUNT(filter_livesin)>1?group:null) AS subject;
filter_count = FILTER count BY subject MATCHES '.{1,}';
result = JOIN groups_name BY group, filter_count BY subject, groups_livesin BY group; 
STORE result INTO 'Exercise2/Problem2/output';
