#!/usr/bin/awk -f

BEGIN {
    if (ARGC > 1) {             # set search string to the first argument
        arg = ARGV[1];          # extract.awk sql sql.md
        delete ARGV[1];         # to get related snippets in more languages
        patern = "^```" arg     # extract.awk '(python|sql)' sql.md
    }
}

{
    if ($0 ~ patern) {
        printLine = 1
#        print ""               # to separate snippets with a line, uncomment this
        }
    else if ($0 ~ /^```/){
        if (printLine == 1) {
            gsub(/^.*$/, "```")
            print #""           # this
        }
        printLine = 0
        }
    if (printLine) {
#        gsub(patern, "")       # to remove markdown code marks uncomment this line and quotes above
        print
    }
}

## Examples of what it does.

# $ ./extract.awk sql sql.md
# ```sql
# CREATE TABLE IF NOT EXISTS person (
#     person_id SERIAL PRIMARY KEY,
#     fname VARCHAR(50) UNIQUE NOT NULL,
#     lname VARCHAR(50) NOT NULL,
#     age INT,
#     date_of_join TIMESTAMP DEFAULT '2000-01-16 19:10:25-07',
#     is_real BOOL DEFAULT FALSE
#
# );
# ```
# ```sql
# SELECT p.person_id,
#         p.fname,
#         p.age,
#         CASE
#             WHEN p.age < 18 THEN 'below 18'  -- honota bude tento text
#             WHEN p.age >= 18 THEN '18 or more'
#         END AS "Age"  -- novy riadok bude sa volat Age
# FROM person AS p;
# ```

# ./extract.awk '(python|sql)' sql.md
# ```sql
# CREATE TABLE IF NOT EXISTS person (
#     person_id SERIAL PRIMARY KEY,
#     fname VARCHAR(50) UNIQUE NOT NULL,
#     lname VARCHAR(50) NOT NULL,
#     age INT,
#     date_of_join TIMESTAMP DEFAULT '2000-01-16 19:10:25-07',
#     is_real BOOL DEFAULT FALSE
#
# );
# ```
# ```python
#  import psycopg2
#
# connection = create_connection(
#     "sm_app", "postgres", "passwd", "127.0.0.1", "5432"
# )
# ```
# ```sql
# SELECT p.person_id,
#         p.fname,
#         p.age,
#         CASE
#             WHEN p.age < 18 THEN 'below 18'  -- honota bude tento text
#             WHEN p.age >= 18 THEN '18 or more'
#         END AS "Age"  -- novy riadok bude sa volat Age
# FROM person AS p;
# ```

