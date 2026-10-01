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
SELECT id, trip_id, category, amount, description
FROM expense
ORDER BY amount DESC;

-- Q3. (ORDER BY + LIMIT) 가장 최근에 시작한 여행 3건만 조회하기
SELECT id, title, organizer_id, start_date
FROM trip
ORDER BY start_date DESC
LIMIT 3;

-- Q4. (WHERE + ORDER BY) 아직 정산되지 않은 분담 내역을 금액이 큰 순서로 조회하기
SELECT id, traveler_id, expense_id, share_amount, is_settled
FROM expense_split
WHERE is_settled = FALSE
ORDER BY share_amount DESC;

-- ===== 조인 (INNER JOIN 2개 이상, LEFT JOIN 1개 이상 포함, 4개 이상) =====

-- Q5. (INNER JOIN) 지출 내역에 결제자 이름을 함께 조회하기
SELECT e.id, e.category, e.amount, t.name AS paid_by
FROM expense e
INNER JOIN traveler t ON e.paid_by_traveler_id = t.id
ORDER BY e.id;

-- Q6. (INNER JOIN) 분담 내역에 지출 설명과 부담자 이름을 함께 조회하기
SELECT es.id, e.description, t.name AS payer
FROM expense_split es
INNER JOIN expense e ON es.expense_id = e.id
INNER JOIN traveler t ON es.traveler_id = t.id;

-- Q7. (LEFT JOIN) 지출이 하나도 없는 여행까지 포함해서, 여행별 지출 목록 조회하기
SELECT tr.id AS trip_id, tr.title, e.id AS expense_id, e.category, e.amount
FROM trip tr
LEFT JOIN expense e ON tr.id = e.trip_id
ORDER BY tr.id;

-- Q8. (INNER JOIN) 특정 여행 하나를 골라, 그 여행의 지출 내역과 결제자를 함께 조회하기
SELECT e.id, e.category, e.amount, e.description, t.name AS paid_by
FROM expense e
INNER JOIN traveler t ON e.paid_by_traveler_id = t.id
WHERE e.trip_id = 1
ORDER BY e.id;

-- ===== 집계 (COUNT/SUM/AVG 중 2개 이상 + GROUP BY, 3개 이상) =====

-- Q9. (COUNT + GROUP BY) 회원별로 주최한 여행이 몇 건인지 조회하기
SELECT t.name, COUNT(tr.id) AS trip_count
FROM traveler t
LEFT JOIN trip tr ON t.id = tr.organizer_id
GROUP BY t.id, t.name
ORDER BY trip_count DESC;

-- Q10. (SUM + GROUP BY) 여행별 총 지출 금액 조회하기
-- COALESCE(값, 대체값)은 값이 NULL이면 대체값을 쓰라는 함수
SELECT tr.id AS trip_id, tr.title, COALESCE(SUM(e.amount), 0) AS total_amount
FROM trip tr
LEFT JOIN expense e ON tr.id = e.trip_id
GROUP BY tr.id, tr.title
ORDER BY tr.id;

-- Q11. (AVG + GROUP BY) 카테고리별 평균 지출 금액 조회하기
SELECT category, AVG(amount) AS avg_amount
FROM expense
GROUP BY category
ORDER BY avg_amount DESC;

-- ===== 서브쿼리 (1개 이상) =====

-- Q12. (서브쿼리) 지출을 한 번도 결제한 적 없는 회원 조회하기
SELECT id, NAME
FROM traveler
WHERE id NOT IN (
    SELECT paid_by_traveler_id
    FROM expense
);

-- ===== 데이터 수정 및 삭제 (UPDATE / DELETE, 2개 이상) =====

-- Q13. (UPDATE) 분담 내역 하나를 골라 정산 완료 상태로 변경하기
SELECT * FROM expense_split WHERE id = 6;
UPDATE expense_split SET is_settled = TRUE WHERE id = 6;

-- Q14. (DELETE) 분담 내역 하나를 골라 삭제하기
DELETE FROM expense_split
WHERE id = 7;

-- ===== 인덱스 (1개 이상) =====

-- Q15. (CREATE INDEX) 자주 조회/조인에 쓰이는 컬럼 하나를 골라 인덱스 생성하고, 적용 이유 한 줄 남기기
-- 인덱스란?
-- 특정 컬럼 값으로 행을 빨리 찾을 수 있게 만들어둔 보조 자료구조
DROP INDEX IF EXISTS idx_expense_trip_id;
CREATE INDEX idx_expense_trip_id ON expense(trip_id);
-- 후보 컬럼 찾기
-- Q5, Q8: expense.paid_by_traveler_id (JOIN 조건으로 계속 사용)
-- Q6: expense_split.expense_id, expense_split.traveler_id
-- Q7, Q10: expense.trip_id
-- Q1: expense.category
-- 이 중에 expense.trip_id가 반복적으로 쓰임
-- 왜 모든 컬럼에 인덱스를 걸지 않는가?
-- 인덱스는 조회가 빨라지지만 INSERT/UPDATE/DELETE는 느려진다. 또한 저장공간도 추가로 차지한다.