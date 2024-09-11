-- 301650
-- Lv.4 - 특정 세대의 대장균 찾기
/*
	3세대의 대장균의 ID(ID) 를 출력
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
     	(3, 1, 100, "2020/01/01", 4),
     	(4, 2, 16, "2020/01/01", 4),
     	(5, 2, 17, "2020/01/01", 6),
     	(6, 4, 101, "2021/01/01", 22),
     	(7, 3, 101, "2022/01/01", 23),
     	(8, 6, 1, "2022/01/01", 27);

-- Answer

WITH RECURSIVE Generation AS (
    -- 초기 조건: 첫 번째 세대 (PARENT_ID가 NULL인 개체)
    SELECT ID, PARENT_ID, 1 AS Gen
    FROM ECOLI_DATA
    WHERE PARENT_ID IS NULL

    UNION ALL

    -- 재귀적 조건: 다음 세대 찾기
    SELECT e.ID, e.PARENT_ID, g.Gen + 1 AS Gen
    FROM ECOLI_DATA e
    INNER JOIN Generation g ON e.PARENT_ID = g.ID
    WHERE g.Gen < 3
)

SELECT ID 
FROM Generation
where Gen = 3
order by ID;