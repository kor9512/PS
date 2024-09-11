-- 284528
-- lv.4 - 연간 평가점수에 해당하는 평가 등급 및 성과금 조회하기

/*
HR_DEPARTMENT 
- DEPT_ID, DEPT_NAME_KR, DEPT_NAME_EN, LOCATION

HR_EMPLOYEES 
- EMP_NO, EMP_NAME, DEPT_ID, POSITION, EMAIL, COMP_TEL, HIRE_DATE, SAL

HR_GRADE 
- EMP_NO, YEAR, HALF_YEAR, SCORE

사원별 성과금 정보를 조회
기준 점수	평가 등급	성과금(연봉 기준)
96 이상	S	20%
90 이상	A	15%
80 이상	B	10%
이외	C	0%

사번, 성명, 평가 등급, 성과금을 조회
평가등급의 컬럼명은 GRADE로, 성과금의 컬럼명은 BONUS
사번 기준으로 오름차순 정렬
*/

use ps;

DROP TABLE IF EXISTS HR_DEPARTMENT;
DROP TABLE IF EXISTS HR_EMPLOYEES;
DROP TABLE IF EXISTS HR_GRADE;

CREATE TABLE IF NOT exists HR_DEPARTMENT
(	DEPT_ID		VARCHAR(255)				NOT NULL,
	DEPT_NAME_KR VARCHAR(255)				not null,
	DEPT_NAME_EN VARCHAR(255)				not null,
	LOCATION VARCHAR(255)				not null,
	PRIMARY KEY (DEPT_ID)
);

CREATE TABLE IF NOT exists HR_EMPLOYEES
(	EMP_NO		VARCHAR(255)				NOT NULL,
	EMP_NAME	VARCHAR(255)	not null,
	DEPT_ID		VARCHAR(255)	not null,
	POSITION	VARCHAR(255)	not null,
	EMAIL		VARCHAR(255)	not null,
	COMP_TEL	VARCHAR(255)	not null,
	HIRE_DATE	DATE			not null,
	SAL			INT			not null,
	PRIMARY KEY (EMP_NO)
);

CREATE TABLE IF NOT exists HR_GRADE 
(	EMP_NO		VARCHAR(255)				NOT NULL,
	YEAR  INT				not null,
	HALF_YEAR INT				not null,
	SCORE INT				not null,
	PRIMARY KEY (EMP_NO)
);

-- Answer
WITH scoring as(
    SELECT EMP_NO, AVG(SCORE) AS avg_score 
    FROM HR_GRADE
    GROUP BY EMP_NO  
)
SELECT emp.EMP_NO, emp.EMP_NAME,
    CASE 
        WHEN sc.avg_score >= 96 THEN 'S'
        WHEN sc.avg_score >= 90 THEN 'A'
        WHEN sc.avg_score >= 80 THEN 'B'
        ELSE 'C' 
    END AS GRADE,
    CASE 
        WHEN sc.avg_score >= 96 THEN emp.SAL * 0.2
        WHEN sc.avg_score >= 90 THEN emp.SAL * 0.15
        WHEN sc.avg_score >= 80 THEN emp.SAL * 0.1
        ELSE emp.SAL * 0 
    END AS BONUS
FROM HR_EMPLOYEES AS emp
JOIN scoring AS sc
ON emp.EMP_NO = sc.EMP_NO
ORDER BY emp.EMP_NO ASC;