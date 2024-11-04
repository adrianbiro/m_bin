--sqlite3 adrian_knihy_zmaz.sqlite
CREATE TABLE IF NOT EXISTS "documents"(
    "Name" TEXT,
    "Path" TEXT,
    "SHA256" TEXT,
    "Size_Bytes" TEXT,
    "Size_Human" TEXT
);
/*
 import data
 .mode csv 
 .import adrianknihy_zmaz.csv documents
 */
select SHA256,
    count(SHA256) as cnt
FROM documents
GROUP By SHA256
HAVING cnt > 1
ORDER BY cnt DESC;
/*
 0264aaf8b6e0714c1ebcb8ceba505a30919d8135f20e77e3035e698c2f8dab5e,2
 0226f13f1a5fe85816ba0f18f7e7f97bc45475a0904f1b32a33e404766d30b8d,2
 01fb4f8cb734f087603ae41ea4e360b3a5101c0187907271ecc2cc722547a911,2
 016119ca8c960f1b356971fe645a0ffed7bd47cdd351d9db4103f4e55bc41d8e,2
 014e7b2e959be0a67add794336159c7cd17b83149cd7c95e81f6626121444075,2
 0068adaa5a846da54d4705a6552d62e6cb58c300c0e9d3c44253605feb1d428a,2
 000479c76b2ddcfdb843f41dd33422e84c6a66bbb010a167a313d455afd4d8e6,2
 */
-----
select SHA256,
    count(SHA256) as cnt,
    sum(Size_Bytes) /(1024 * 1024) as Size_MiB
FROM documents
GROUP By SHA256
HAVING cnt > 1
ORDER BY Size_MiB,
    cnt DESC;
/*
 96295ca43a33b83404db690b952ab0b29aa1075eea5204d9599781abee29f2b7,2,455
 06620649c78ac0ccaa5b6fa346acd346e05e2934e81a42940ab3b331b274b092,2,795
 7b926bd0a76c1caf12ee75d5fa9031034845aae66b60bc37ecd9f3999f4da03d,2,1514
 0d598bd13ad94bb25c3ebbcfda44b473f159761ccba89a6ffb6e3723be1b0447,3,2401
 */
-----
select Name
from documents
WHERE SHA256 IN (
        select SHA256
        from (
                select SHA256,
                    count(SHA256) as cnt
                FROM documents
                GROUP By SHA256
                HAVING cnt > 1
                ORDER BY cnt DESC
            )
    );
-----
select *
from documents
WHERE SHA256 in (
        select SHA256
        from (
                select SHA256,
                    count(SHA256) as cnt,
                    sum(Size_Bytes) /(1024 * 1024) as Size_MiB
                FROM documents
                GROUP By SHA256
                HAVING cnt > 1
                ORDER BY Size_MiB DESC
                LIMIT 10
            )
    );
---
select sum(Size_Bytes) / (1024 * 1024)
from documents
WHERE SHA256 in (
        select SHA256
        from (
                select SHA256,
                    count(SHA256) as cnt,
                    sum(Size_Bytes) /(1024 * 1024) as Size_MiB
                FROM documents
                GROUP By SHA256
                HAVING cnt > 1
                ORDER BY Size_MiB DESC
                LIMIT 10
            )
    );
/*
 7258
 */
----------
select Name,
    Size_Human,
    Path
from documents
WHERE SHA256 in (
        select SHA256
        from (
                select SHA256,
                    count(SHA256) as cnt,
                    sum(Size_Bytes) /(1024 * 1024) as Size_MiB
                FROM documents
                GROUP By SHA256
                HAVING cnt > 1
                ORDER BY Size_MiB DESC
                LIMIT 10
            )
    )
ORDER BY Size_Human DESC;
--LIMIT 10;
/*
.output check_duplicities.csv
run query
.output stdout
*/
