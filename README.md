# 여행 경비 정산 DB 실습

## 개요
- 주제: 여행 경비 정산 (traveler, trip, expense, expense_split)
- DB: PostgreSQL
- 백엔드 프레임워크 사용 금지, View/Procedure/Trigger 사용 금지

## 스키마 설계
| 테이블 | 역할 |
|---|---|
| traveler | 여행 참여자 |
| trip | 여행 (주최자 포함) |
| expense | 지출 내역 (여행, 결제자 연결) |
| expense_split | 지출 분담 (지출, 참여자 연결) |

1:N 관계
- trip.organizer_id → traveler.id
- expense.trip_id → trip.id
- expense.paid_by_traveler_id → traveler.id
- expense_split.expense_id → expense.id
- expense_split.traveler_id → traveler.id

## 진행 체크리스트

### 스키마 (schema.sql)
- [x] traveler 테이블
- [x] trip 테이블
- [x] expense 테이블
- [x] expense_split 테이블

### 샘플 데이터 (seed.sql)
- [x] traveler 10행 이상
- [x] trip 10행 이상
- [x] expense 10행 이상
- [x] expense_split 10행 이상

### 핵심 쿼리 15개 (queries.sql)
- [x] 기본 조회 4개 이상 (WHERE/ORDER BY/LIMIT) — Q1~Q4
- [x] 조인 4개 이상 (INNER 2+, LEFT 1+) — Q5,Q6,Q8(INNER) / Q7,Q9,Q10(LEFT)
- [x] 집계 3개 이상 (COUNT/SUM/AVG + GROUP BY) — Q9,Q10,Q11
- [x] 서브쿼리 1개 이상 — Q12
- [x] UPDATE/DELETE 2개 이상 — Q13,Q14
- [x] 인덱스 1개 이상 (CREATE INDEX + 이유) — Q15

### 결과 확인
- [x] results/ 폴더에 쿼리별 실행 결과 캡처 또는 텍스트 정리

### 선택
- [ ] ERD 다이어그램
- [ ] 보너스: JOIN vs 서브쿼리 비교
- [ ] 보너스: FK 위반 재현 및 기록
- [ ] 보너스: 미니 리포트 (핵심 지표 3개)
