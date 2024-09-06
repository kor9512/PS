-- 77487
/*
	 1. 헤비 유저의 HOST_ID를 찾아 낸다
	 2. 해당 HOST_ID에 해당되는 컬럼을 ID ASC 순으로 출력한다.
*/  
use ps;

DROP TABLE IF EXISTS PLACES;

CREATE TABLE IF NOT exists PLACES
(	ID		INT				NOT NULL,
	NAME	VARCHAR(255)	NOT NULL,
	HOST_ID	INT 			NOT NULL,
	PRIMARY KEY (ID)
);

INSERT INTO	PLACES(ID, NAME, HOST_ID)
     VALUES (4431977	,"BOUTIQUE STAYS - Somerset Terrace, Pet Friendly",	760849),
			(5194998	,"BOUTIQUE STAYS - Elwood Beaches 3, Pet Friendly",	760849),
			(16045624	,"Urban Jungle in the Heart of Melbourne",	30900122),
			(17810814	,"Stylish Bayside Retreat with a Luscious Garden",	760849),
			(22740286	,"FREE PARKING - The Velvet Lux in Melbourne CBD",	30900122),
			(22868779	,"★ Fresh Fitzroy Pad with City Views! ★",	21058208);

-- Answer
SELECT ID, NAME, HOST_ID
FROM PLACES
WHERE HOST_ID IN (
    SELECT HOST_ID
    FROM PLACES 
    GROUP BY HOST_ID
    HAVING COUNT(*) >= 2
)
ORDER BY ID ASC;
