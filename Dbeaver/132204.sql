-- 132204
-- Lv.4 - 취소되지 않은 진료 예약 조회하기
/*
2022년 4월 13일 취소되지 않은 흉부외과(CS) 진료 예약 내역을 조회
진료예약번호, 환자이름, 환자번호, 진료과코드, 의사이름, 진료예약일시 항목이 출력
진료예약일시를 기준 ASC 

환자 정보. PATIENT - PT_NO, PT_NAME, GEND_CD, AGE, TLNO
의사 정보. DOCTOR - DR_NAME, DR_ID, LCNS_NO, HIRE_YMD, MCDP_CD, TLNO
진료 예약목록. APPOINTMENT - APNT_YMD, APNT_NO, PT_NO, MCDP_CD, MDDR_ID, APNT_CNCL_YN, APNT_CNCL_YMD

PT, DC, AP
*/

SELECT AP.APNT_NO, PT.PT_NAME, PT.PT_NO, 
	DC.MCDP_CD, DC.DR_NAME, AP.APNT_YMD
FROM APPOINTMENT AS AP
INNER JOIN DOCTOR AS DC
ON DC.DR_ID = AP.MDDR_ID
INNER JOIN PATIENT AS PT
ON PT.PT_NO = AP.PT_NO
WHERE DC.MCDP_CD = "CS" 
	AND DATE_FORMAT(AP.APNT_YMD, "%Y-%m-%d") = "2022-04-13"
	AND AP.APNT_CNCL_YN = 'N' -- NULL일수도 있다
ORDER BY AP.APNT_YMD ASC 
 