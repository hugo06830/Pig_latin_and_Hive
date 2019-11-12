




records = LOAD '../yago_full_clean.tsv' USING PigStorage(' ') AS (subject:chara$

filterlivesin = FILTER records BY predicate MATCHES '<livesIn>';
filtername = FILTER records BY predicate MATCHES '<hasGivenName>';
grouplivesin = GROUP filterlivesin BY subject;
groupname = GROUP filtername BY subject;
count = FOREACH grouplivesin GENERATE group AS subject,COUNT(filterlivesin) AS $
filtercount = FILTER count BY count > 1;
fsub = FOREACH filtercount GENERATE subject as subject;
joined = JOIN fsub BY subject, groupname BY group;
result = FOREACH joined GENERATE fsub::subject as subject;
final = DISTINCT result;

STORE final INTO './problem2/output';