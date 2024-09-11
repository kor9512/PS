-- 151141
-- Lv.4 - 자동차 대여 기록 별 대여 금액 구하기
/*

대여 중인 자동차들의 정보 CAR_RENTAL_COMPANY_CAR
- CAR_ID, CAR_TYPE, DAILY_FEE, OPTIONS
- 자동차 종류는 '세단', 'SUV', '승합차', '트럭', '리무진'
- 자동차 옵션 리스트는 콤마(',')로 구분된 키워드 리스트
- (예: ''열선시트,스마트키,주차감지센서'')로 되어있으며
- 자동차 옵션 키워드 리스트는 '주차감지센서', '스마트키', '네비게이션', '통풍시트', '열선시트', '후방카메라', '가죽시트'

자동차 대여 기록 정보 CAR_RENTAL_COMPANY_RENTAL_HISTORY
- HISTORY_ID, CAR_ID, START_DATE, END_DATE
자동차 종류 별 대여 기간 종류 별 할인 정책 정보 CAR_RENTAL_COMPANY_DISCOUNT_PLAN
- PLAN_ID, CAR_TYPE, DURATION_TYPE, DISCOUNT_RATE
- 0<= 대여기간 <7, 7 <= 대여기간 < 30, 30 <= 대여기간 < 90
- 대여기간 7일 미만시 할인 X 

CAR_TYPE이 트럭. 
대여 기록별로 대여 금액(FEE) 계산.
대여 기록 ID, 대여 금액 리스트(HISTORY_ID) 출력. 
대여 금액 기준 내림차순, 대여기록 ID 기준 내림차순
*/

WITH dt as(
    SELECT car.car_type, car.daily_fee, his.history_id, 
        DATEDIFF(his.end_date, his.start_date) + 1 as period,
        CASE 
        WHEN DATEDIFF(his.end_date, his.start_date) + 1 >= 90
            THEN "90일 이상"
        WHEN DATEDIFF(his.end_date, his.start_date) + 1 >= 30
            THEN "30일 이상"
        WHEN DATEDIFF(his.end_date, his.start_date) + 1 >= 7
            THEN "7일 이상"
        ELSE "" END as duration_type
    FROM CAR_RENTAL_COMPANY_CAR as car
    INNER JOIN CAR_RENTAL_COMPANY_RENTAL_HISTORY as his
    ON car.car_id = his.car_id
    where car_type = "트럭"
)
select dt.HISTORY_ID, 
    CAST(dt.DAILY_FEE*(1-IFNULL(plan.DISCOUNT_RATE,0)/100)*dt.period as signed integer) as FEE
from dt
LEFT JOIN CAR_RENTAL_COMPANY_DISCOUNT_PLAN as plan
ON dt.CAR_TYPE = plan.CAR_TYPE and dt.DURATION_TYPE = plan.DURATION_TYPE
order by FEE desc, HISTORY_ID desc;
