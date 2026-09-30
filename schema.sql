--
--여행 경비 정산 DB - 스키마 생성 스크립트
--실행 순서: traveler -> trip -> expense -> expense_split
--
create TABLE traveler(
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    created_at DATE NOT NULL DEFAULT CURRENT_DATE
);

create TABLE trip(
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    organizer_id INTEGER NOT NULL REFERENCES traveler(id), -- FK: 이  여행을 주최한 사람
    start_date DATE NOT NULL,
    end_date DATE,
    created_at DATE NOT NULL DEFAULT CURRENT_DATE
);

create TABLE expense(
    id SERIAL PRIMARY KEY,
    trip_id INTEGER NOT NULL REFERENCES trip(id), -- 어느 여행의 지출인지
    paid_by_traveler_id INTEGER NOT NULL REFERENCES traveler(id), -- FK 누가 여행했는지
    category VARCHAR(30) NOT NULL,
    amount NUMERIC(10, 2) NOT NULL, -- 금액은 소수 오차 없는 NUMERIC (FLOAT 금지)
    description VARCHAR(200),
    expense_date DATE NOT NULL,
    created_at DATE NOT NULL DEFAULT CURRENT_DATE
);

create TABLE expense_split(
    id SERIAL PRIMARY KEY,
    traveler_id INTEGER NOT NULL REFERENCES traveler(id), -- 누구의 몫인지
    expense_id INTEGER NOT NULL REFERENCES expense(id), -- 어느 지출을 나누는지
    share_amount NUMERIC(10, 2) NOT NULL,
    is_settled BOOLEAN NOT NULL DEFAULT FALSE,
    UNIQUE(traveler_id, expense_id) -- 같은 지출에 같은 사람 몫이 중복 등록되는 것을 방지
);

