-- 301651
-- Lv.5 - 멸종위기의 대장균 찾기

/*
	각 세대별 자식이 없는 개체의 수(COUNT)와 세대(GENERATION)를 출력
*/

use ps;

DROP TABLE IF EXISTS ECOLI_DATA;

CREATE TABLE IF NOT exists ECOLI_DATA
(	ID		INTEGER				NOT NULL,
	PARENT_ID	INTEGER	NULL,
	SIZE_OF_COLONY	INTEGER 			NOT NULL,
	DIFFERENTIATION_DATE DATE not NULL,
	GENOTYPE INTEGER not NULL,
	PRIMARY KEY (ID)
);

-- DATE는 / 대신 - 사용 권장. 
INSERT INTO	ECOLI_DATA(ID, PARENT_ID, SIZE_OF_COLONY, DIFFERENTIATION_DATE, GENOTYPE)
     VALUES (1, null, 10, "2019/01/01", 5),
     	(2, null, 2, "2019/01/01", 3),
     	(3, 2, 100, "2020/01/01", 4),
     	(4, 2, 16, "2020/01/01", 4),
     	(5, 2, 17, "2020/01/01", 6),
     	(6, 4, 101, "2021/01/01", 22),
     	(7, 4, 101, "2022/01/01", 23),
     	(8, 6, 1, "2022/01/01", 27);

-- Answer

WITH RECURSIVE Generation AS (
    SELECT ID, PARENT_ID, 1 AS Gen
    FROM ECOLI_DATA
    WHERE PARENT_ID IS NULL

    UNION ALL

    SELECT e.ID, e.PARENT_ID, g.Gen + 1 AS Gen
    FROM ECOLI_DATA e
    INNER JOIN Generation g ON e.PARENT_ID = g.ID
    where 1
) 
SELECT COUNT(ID) as COUNT, Gen as GENERATION
FROM Generation 
where ID not in (SELECT ifnull(PARENT_ID, "") FROM ECOLI_DATA)
group by Gen
order by Gen;

/*
select ID, Gen 
from Generation
where ID not in (SELECT ifnull(PARENT_ID, "") FROM ECOLI_DATA);

*/
