
-- Goods 테이블에서 세 개의 열을 선택하여 출력
SELECT goods_id, goods_name, buy_price
    FROM Goods;

-- 모든 열 출력(* = 모든 열) -> 결과 열의 정렬 순서를 지정할 수 없다. (CREATE TABLE에서 정의한 순서를 따라 출력)
SELECT * FROM Goods;

-- *은 모든 열을 나열하여 출력하는 것과 같다.
SELECT goods_id, goods_name, goods_classify, sell_price, buy_price, register_date
    FROM Goods;

-- 별명 부여하기(Alias => AS)
SELECT goods_id AS id,
       goods_name AS name,
       buy_price AS price
    FROM Goods;

-- 한글로 별명 부여(큰 따옴표("") 사용!)
SELECT goods_id AS "상품ID",
       goods_name AS "상품명",
       buy_price AS "매입 단가"
    FROM Goods;

-- 상수 출력 -> 상수는 작은따옴표('')
SELECT '상품' AS munja, 38 AS num, '2009-02-24' AS nalja, goods_id, goods_name
    FROM Goods;

-- 중복 행 제거 = DISTINCT
SELECT DISTINCT goods_classify
    FROM Goods;

-- DISTINCT 특징 => NULL도 하나의 데이터로 인식된다.
SELECT DISTINCT buy_price
    FROM Goods;

-- DISTINCT를 복수 열앞에 두는 경우 => 복수의 행을 조합해도 중복된 행만 하나로 모아진다...이해가 안되면 결과 확인
SELECT DISTINCT goods_classify, register_date
    FROM Goods;

-- DISTINCT 특징 => 열명(SELECT 등) 앞에만 놓일 수 있는 키워드

-- 조건 지정 => WHERE 구 + (조건식)
SELECT goods_name, goods_classify
    FROM Goods
   WHERE goods_classify = '의류';

/*
    WHERE 구에서 지정한 조건과 일치하는 행을 우선 선택 후,
    SELECT 구에서 지정한 열을 출력한다.
*/

-- 검색 조건에 사용한 열을 출력하지 않아도 된다.
SELECT goods_name
    FROM Goods
   WHERE goods_classify = '의류';
