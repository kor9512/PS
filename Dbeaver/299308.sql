-- 299308
-- Lv.2 - 분기별 분화된 대장균의 개체 수 구하기
/*
	1. 분기별 분하된 대장균의 개체의 총 수를 출력하라. ECOLI_COUNT
	2. 각 분기에는 Q를 붙여라
	3. 분기에 대해 오름차순 정렬하라
	4. 분화가 되지 않는 분기는 없다.
*/
use ps;

DROP TABLE IF EXISTS ECOLI_DATA;

CREATE TABLE IF NOT exists ECOLI_DATA
(	ID						INTEGER		NOT NULL,
	PARENT_ID				INTEGER		NULL,
	SIZE_OF_COLONY			INTEGER		NOT NULL,
	DIFFERENTIATION_DATE	DATE		NOT NULL,
	GENOTYPE				INTEGER		not null,
	PRIMARY KEY (ID)
);

INSERT INTO	ECOLI_DATA(ID, PARENT_ID, SIZE_OF_COLONY, DIFFERENTIATION_DATE, GENOTYPE)
     VALUES (1	,NULL,	10, "2019/01/01", 5),
			(2	,NULL,	2, "2019/05/01", 3),
			(3	,1,	100, "2020/01/01", 4),
			(4	,2,	17, "2022/04/01", 4),
			(5	,2,	10, "2020/09/01", 6),
			(6	,4,	101, "2021/12/01", 22);
		
-- Answer
select CONCAT(QUARTER(DIFFERENTIATION_DATE), "Q") AS "QUARTER", count(*) as "ECOLI_COUNT" 
from ecoli_data
group by CONCAT(QUARTER(DIFFERENTIATION_DATE), "Q")
order by QUARTER ASC;

