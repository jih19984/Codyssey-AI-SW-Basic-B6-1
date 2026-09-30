--
-- 여행 경비 정산 DB 핵심 쿼리 15개
-- 아래 문제 설명에 맞는 쿼리를 각자 작성한다.
--

-- ===== 기본 조회 (WHERE / ORDER BY / LIMIT 포함, 4개 이상) =====

-- Q1. (WHERE) 카테고리가 '숙박'인 지출 내역만 조회하기
SELECT id, trip_id, category, amount, description
FROM expense
WHERE category = '숙박';

-- Q2. (ORDER BY) 지출 내역을 금액이 큰 순서로 정렬해서 조회하기
SELECt id, trip_id, category, amount, description
FROM expense
ORDER BY amount DESC;

-- Q3. (ORDER BY + LIMIT) 가장 최근에 시작한 여행 3건만 조회하기


-- Q4. (WHERE + ORDER BY) 아직 정산되지 않은 분담 내역을 금액이 큰 순서로 조회하기


-- ===== 조인 (INNER JOIN 2개 이상, LEFT JOIN 1개 이상 포함, 4개 이상) =====

-- Q5. (INNER JOIN) 지출 내역에 결제자 이름을 함께 조회하기


-- Q6. (INNER JOIN) 분담 내역에 지출 설명과 부담자 이름을 함께 조회하기


-- Q7. (LEFT JOIN) 지출이 하나도 없는 여행까지 포함해서, 여행별 지출 목록 조회하기


-- Q8. (INNER JOIN) 특정 여행 하나를 골라, 그 여행의 지출 내역과 결제자를 함께 조회하기


-- ===== 집계 (COUNT/SUM/AVG 중 2개 이상 + GROUP BY, 3개 이상) =====

-- Q9. (COUNT + GROUP BY) 회원별로 주최한 여행이 몇 건인지 조회하기


-- Q10. (SUM + GROUP BY) 여행별 총 지출 금액 조회하기


-- Q11. (AVG + GROUP BY) 카테고리별 평균 지출 금액 조회하기


-- ===== 서브쿼리 (1개 이상) =====

-- Q12. (서브쿼리) 지출을 한 번도 결제한 적 없는 회원 조회하기


-- ===== 데이터 수정 및 삭제 (UPDATE / DELETE, 2개 이상) =====

-- Q13. (UPDATE) 분담 내역 하나를 골라 정산 완료 상태로 변경하기


-- Q14. (DELETE) 분담 내역 하나를 골라 삭제하기


-- ===== 인덱스 (1개 이상) =====

-- Q15. (CREATE INDEX) 자주 조회/조인에 쓰이는 컬럼 하나를 골라 인덱스 생성하고, 적용 이유 한 줄 남기기

