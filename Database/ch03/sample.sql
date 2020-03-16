

/* 집약 함수(집합 함수) : COUNT, SUM, AVG, MAX, MIN */

--------------------------------------------------------------------------

-- 테이블 행 수를 계산
SELECT COUNT(*) FROM Goods;

-- 괄호 안이 함수의 입력 데이터 = 인수 or 파라미터
-- 출력 데이터 = 반환 값

-- NULL을 제외한 행 수 계산 : 대상 열(인수)를 한정한다.
SELECT COUNT(buy_price) FROM Goods;

-- *** 주의 사항 ***
--  COUNT 함수는 인수에 따라 처리 결과가 달라진다!

    CREATE TABLE NullTbl
        (col_1 INTEGER);

    INSERT INTO NullTbl VALUES (NULL);
    INSERT INTO NullTbl VALUES (NULL);
    INSERT INTO NullTbl VALUES (NULL);

    SELECT COUNT(*), COUNT(col_1) FROM NullTbl;

-- 단, COUNT를 제외하고 다른 함수는 별표 자체를 인수로 지정할 수 없다.

--------------------------------------------------------------------------

-- 합계를 구하기

SELECT SUM(sell_price) FROM Goods; -- 판매단가의 합계
SELECT SUM(sell_price), SUM(buy_price) FROM Goods; -- 판매단가와 매입단가 합계

-- NULL이 포함된 열명을 인수로 가질 경우, 집약함수는 NULL을 제하고 실행됨.(COINT(*)은 제외)
-- 단, NULL을 제한다 != 0과 같다

--------------------------------------------------------------------------

-- 평균값

SELECT AVG(sell_price) FROM Goods; -- 판매단가의 평균
SELECT AVG(sell_price), AVG(buy_price) FROM Goods; -- 판매단가와 매입단가 평균

/*
NULL이 포함된 행을 아예 제외하므로, 
판매단가는 (판매단가의 합)/8(=전체 행 수)
매입단가는 (매입단가의 합(NULL제외))/6(=NULL제외한 전체 행 수)

즉, NULL 값이 있는 경우 평균 계산 시, NULL 행 자체가 생략되어 계산된다.
하지만 NULL이 계산에서는 제외되어도 NULL을 가진 행 수는 포함되어야 하는 경우도 있다.
*/

--------------------------------------------------------------------------

-- 최솟값, 최댓값

SELECT MAX(sell_price), MIN(buy_price) FROM Goods; -- 판매단가의 최댓값, 매입단가의 최솟값

-- 최솟값, 최댓값은 원칙상 어떤 데이터형에도 사용할 수 있다.(평균과 합계는 숫자형만 가능!)
--  => 순서를 정할 수 있는 데이터라면 최댓값과 최솟값이 자연스럽게 정해지므로 두 가지 함수 모두 적용할 수 있음!

SELECT MAX(register_date), MIN(register_date) FROM Goods; -- 등록일의 최댓값, 최솟값

--------------------------------------------------------------------------

-- COUNT에는 DISTINCT 키워드를 사용할 수 있다.
-- 중복값을 제외한 집약 함수 사용(DISTINCT 키워드)

SELECT COUNT(DISTINCT goods_classify) FROM Goods; -- 반환 값 : 3

-- DISTINCT 키워드는 괄호 안에 기술해야 함(중복값을 "먼저" 제외하고 총 행 수를 계산하기 때문)

SELECT DISTINCT COUNT(goods_classify) FROM Goods; -- 반환 값 : 8 (먼저 행 수를 센 후에 결과에서 중복값을 제외하므로)

-- DISTINCT는 집약 함수라면 어디든 사용할 수 있다.
-- (중복값을 제외하고 집약하려면 집약 함수의 인수에 DISTINCT 키워드를 사용한다.)

-- DISTINCT 유무에 따른 동작 차이(SUM) : 중복값을 제외한 합계를 구함
SELECT SUM(sell_price), SUM(DISTINCT sell_price) FROM Goods;

--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------

-- GROUP BY 구 : '~마다', '~별', '~단위' 등 테이블을 일정한 기준으로 나누기 위한 구

-- 상품분류별 행 수 계산
SELECT goods_classify, COUNT(*)
    FROM Goods
    GROUP BY goods_classify;

-- 집약 키(그룹화 열) : GROUP BY 구에 지정하는 열(그룹을 나누는 기준열)
-- GROUP BY 구는 복수의 열을 쉼표 구분으로 지정할 수 있다.

/* 구 "작성" 순서(변경불가!!) : SELECT -> FROM -> WHERE -> GROUP BY */

-- 집약 키에 NULL이 포함된 경우
SELECT buy_price, COUNT(*)
    FROM Goods
    GROUP BY buy_price;

-- 'NULL'이라는 별도 그룹으로 분류됨('불변'을 의미)

-- WHERE 구를 사용한 경우 GROUP BY 동작 : WHERE 구에서 지정한 조건으로 레코드를 먼저 선택한 후 집약
SELECT buy_price, COUNT(*)
    FROM Goods
   WHERE goods_classify = '의류'
    GROUP BY buy_price;

/* WHERE 구와 GROUP BY 구를 병용할 때 SELECT 문 "실행" 순서 : FROM -> WHERE -> GROUP BY -> SELECT */

--------------------------------------------------------------------------

-- 집약 함수와 GROUP BY 구를 사용할 때 자주하는 실수

-- 1. SELECT 구에 필요없는 열을 쓴다.
SELECT goods_name, buy_price, COUNT(*) -- 에러발생(단, MySQL은 복수 후보 중에 적합한 하나만 빼내는 식으로 작동함)
    FROM Goods                         -- ===> goods_name 이라는 열명이 GROUP BY 구에 없기 때문에 SELECT 구에 쓸 수 없음
    GROUP BY buy_price;

/* 집약 함수를 사용할 때 SELECT구에 기술할 수 있는 것
    a) 상수
    b) 집약 함수
    c) GROUP BY 구에서 지정할 열(= 집약 키) : 하나의 집약 키에 대해 복수의 값이 존재하는 열이 발생할 가능성 차단
*/

-- 2. GROUP BY 구에 별명을 쓴다.
SELECT goods_classify AS sb, COUNT(*)
    FROM Goods
    GROUP BY sb; -- 에러발생(단, MySQL과 postgreSQL 제외) : SELECT구가 GROUP BY 구보다 뒤에 실행되기 때문

-- 3. GROUP BY 구는 결과의 순서를 정렬한다...?
--      => SELECT 문 결과는 '무작위'로 정렬된다! 제대로 정렬하려면 따로 지정해주어야 한다.

-- 4. WHERE 구에 집약 함수를 사용한다.
SELECT goods_classify, COUNT(*)
    FROM Goods
    GROUP BY goods_classify;

-- 위 SELECT문의 결과에서 COUNT(*) 값이 2인 그룹만 선택하고 싶을 때?
SELECT goods_classify, COUNT(*)
    FROM Goods
   WHERE COUNT(*) = 2
    GROUP BY goods_classify; -- 에러발생!!(HAVING 구를 이용해야 함)

-- 집약 함수를 사용할 수 있는 부분은 SELECT 구와 HAVING 구, ORDER BY 구 뿐이다.

--------------------------------------------------------------------------

-- DISTINCT와 GROUP BY : "중복을 배제한다"는 공통된 처리 수행
SELECT DISTINCT goods_classify FROM Goods;
SELECT goods_classify FROM Goods GROUP BY goods_classify;

-- NULL을 하나의 행으로 간주, 복수 열을 사용하는 경우 결과도 동일함
/* 
        <<논리적 구분법>>
    - SELECT 문이 가진 의미가 요건에 부합하는지를 먼저 생각하라.
        -> 선택 결과에서 중복을 제외하고 싶다. = DISTINCT
        -> 집약한 결과를 구하고 싶다. = GROUP BY
*/

--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------

-- HAVING 구 : 집합(그룹)에 대한 조건 지정을 위한 구 => GROUP BY 뒤에 기술함
/* HAVING 구를 사용하는 경우, SELECT 문 "기술" 순서 : SELECT -> FROM -> WHERE -> GROUP BY -> HAVING */

-- 상품분류로 집약한 그룹에서 '포함되는 행 수가 2행'인 것을 선택
SELECT goods_classify, COUNT(*)
    FROM Goods
    GROUP BY goods_classify
    HAVING COUNT(*) = 2;

-- HAVING 구 없이 선택한 결과
SELECT goods_classify, AVG(sell_price)
    FROM Goods
    GROUP BY goods_classify;

-- HAVING 구에 조건을 설정하고 선택한 결과
SELECT goods_classify, AVG(sell_price)
    FROM Goods
    GROUP BY goods_classify
    HAVING AVG(sell_price) >= 2500;

/* HAVING 구에 쓸 수 있는 요소
    a) 상수
    b) 집약 함수
    c) GROUP BY 구에 지정한 열명(= 집약 키)
*/

--------------------------------------------------------------------------

-- 에러가 발생하는 HAVING 구 사용법
SELECT goods_classify, COUNT(*)
    FROM Goods
    GROUP BY goods_classify
    HAVING goods_name = '볼펜'; -- 에러 : goods_name 열은 GROUP BY 구에 포함되어 있지 않으므로 HAVING구에 사용할 수 없다.

-- HAVING 구는 "'한 번 집약이 끝난 단계'를 출발점으로 하고 있다."고 생각하자.

--------------------------------------------------------------------------

-- HAVING 구보다 WHERE 구에 쓰는 것이 좋은 조건

-- '집약 키에 대한 조건'은 둘 중 어느 곳에서든 쓸 수 있음!
SELECT goods_classify, COUNT(*)
    FROM Goods
    GROUP BY goods_classify
    HAVING goods_classify = '의류'; -- 정상!

SELECT goods_classify, COUNT(*)
    FROM Goods
   WHERE goods_classify = '의류' -- 정상!
    GROUP BY goods_classify;

/*
    어느 쪽이든 결과는 같지만, '읽기 쉬운 코드'를 위해 상호 기능을 확실히 분리하자!
    
    - '그룹'에 대한 조건 지정 => HAVING 구
    - '행'에 대한 조건 지정 => WHERE

    로 구분하여 쓰자.
    (즉, 위의 경우처럼 '집약 키에 대한 조건'은 후자를 권장)

    + DBMS 내부 처리 문제도 있다.(실행속도)
        -> COUNT 함수 등으로 데이터를 집약할 때, '소트(정렬)'라고 하는 행 재정렬이 이루어짐.
            이는, 큰 부하가 걸리는 '무거운' 처리로, 가능한 한 소트할 행 수가 적게 하는 거이 처리 속도를 빠르게 하는 방법!
        -> WHERE 구에서 조건으로 지정하는 열에 '색인(index, 인덱스)'을 작성함으로써 처리를 큰 폭으로 고속화 할 수 있음.
            * 색인은 DBMS 성능 향상 방법으로 매우 자주 사용!
            ** 색인의 DBMS 성능 향상 효과 역시 매우 좋음
*/

--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------

-- ORDER BY 구 : 검색 결과 재정렬(행 정렬 순서)

-- 기본적으로 SELECT 문은 "무작위"로 나열됨
SELECT goods_id, goods_name, sell_price, buy_price
    FROM Goods; -- 무작위 나열

-- ORDER BY 구를 추가하여 명시적으로 순서를 지정

-- 판매단가가 낮은 순(오름차순)으로 나열 << ASC 사용이 원칙(생략해도 암묵적으로 오름차순 정렬)
SELECT goods_id, goods_name, sell_price, buy_price
    FROM Goods
    ORDER BY sell_price;

-- ORDER BY 구는 SELECT문 제일 "마지막"에 기술(행을 재정렬(소트)하는 처리는 결과 반환 직전에 이루어져야 하기 때문)
/* 구 "기술" 순서 : SELECT -> FROM -> WHERE -> GROUP BY -> HAVING -> ORDER BY */

-- 소트 키 : ORDER BY 구에 쓰는 열명

-- 오름차순과 내림차순 지정(열 단위로 지정가능! = 하나의 열은 오름차순, 다른 열은 내림차순 정렬도 가능)

-- 판매단가가 높은 순서(내림차순)으로 나열 << DESC 사용
SELECT goods_id, goods_name, sell_price, buy_price
    FROM Goods
    ORDER BY sell_price DESC;

--------------------------------------------------------------------------

-- 복수의 소트 키 지정
-- ORDER BY 구를 이용해도 특별히 지정하지 않는 한, 같은 값 내에서의 정렬은 역시나 "무작위"
--  => 같은 값 내에서의 정렬도 지정하고 싶다면 복수의 소트 키를 지정하라.

-- 판매단가와 상품ID를 오름차순으로 정렬
SELECT goods_id, goods_name, sell_price, buy_price
    FROM Goods
    ORDER BY sell_price, goods_id;

/*
    <<복수의 소트 키를 지정한 경우>>

    - 왼쪽 키부터 우선적으로 사용
    - 해당 키와 같은 값이 존재할 경우, 오른쪽 키를 참조
    - 3열 이상의 소트 키 사용 가능
*/

--------------------------------------------------------------------------

-- NULL 순서
--  => NULL은 비교 연산자를 사용할 수 없으므로, 순서를 비교할 수 없다.
--     따라서, NULL은 제일 앞 또는 제일 뒤에 모아서 표시된다.

-- 매입단가(buy_price)를 오름차순 정렬
SELECT goods_id, goods_name, sell_price, buy_price
    FROM Goods
    ORDER BY buy_price;

-- 처음에 올지, 마지막에 올지는 특별히 정해져 있지 않음. 이것을 지정할 수 있는 DBMS도 존재.

--------------------------------------------------------------------------

-- 소트 키에 표시용 별명(alias) 사용

-- ORDER BY 구에서는 별명 사용을 허가하고 있다.
SELECT goods_id AS id, goods_name, sell_price AS ht, buy_price
    FROM Goods
    ORDER BY ht, id;

/* SELECT 문 "실행" 순서 : FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY */
-- (대략적인 순서로, 세부적인 부분은 DBMS마다 차이가 있음. 전체적인 흐름을 이해하도록!)

-- 위 실행 순서에서 중요한 것은 "GROUP BY보다 뒤이고 ORDER BY보다 앞"인 SELECT 구의 위치
--  => GROUP BY 구가 실행되는 시점에서는 SELECT 구에서 부여하는 별명을 인식할 수 없으나,(HAVING 구도 마찬가지)
--     SELECT 구보다 뒤에 실행되는 ORDER BY 구는 별명을 인식할 수 있다.

--------------------------------------------------------------------------

-- ORDER BY 구에 사용할 수 있는 열

-- SELECT 구에 포함되지 않은 열이라도 테이블에 존재하는 열이라면 ORDER BY 구에 지정 가능하다.
SELECT goods_name, sell_price, buy_price
    FROM Goods
    ORDER BY goods_id;

-- 집약 함수도 사용 가능
SELECT goods_classify, COUNT(*)
    FROM Goods
    GROUP BY goods_classify
    ORDER BY COUNT(*);
    
--------------------------------------------------------------------------

-- 열 번호를 사용해선 안 된다!!(이유는 후술)
-- 열 번호 :  SELECT 구에서 지정한 열을 왼쪽부터 1, 2, 3, ...으로 순번을 부여한 번호

-- ORDER BY 구에서는 열 번호를 지정할 수 있다.
-- 왼쪽부터 1(goods_id), 2(goods_name), 3(sell_price), 4(buy_price) => 열번호
    -- 열명으로 지정
    SELECT goods_id, goods_name, sell_price, buy_price
        FROM Goods
        ORDER BY sell_price DESC, goods_id;
    -- 열 번호로 지정
    SELECT goods_id, goods_name, sell_price, buy_price 
        FROM Goods
        ORDER BY 3 DESC, 1;
        -- 이는 "SELECT 구의 3번째 열로 내림차순 정렬하고, 계속해서 1번째 열로 오름차순 정렬한다."는 의미

/*
    <<열 번호를 사용하는 것을 피해야 하는 이유>>

    1. 코드가 읽기 어려워진다.
        => ORDER BY만 봤을 때 어떤 열을 소트 키로 하고 있는지 알 수 없고,
           SELECT 구에 있는 열 리스트를 처음부터 세어 보아야 함.
           실무에선 수많은 열이 SELECT 구에 포함될 수 있고,
           SELECT 구와 ORDER BY 구 사이에 WHERE 구나 HAVING 구 등이 있으므로 눈으로 따라가기 어려움.
    2. 열 번호는 1992년 제정된 표준 SQL 규격(SQL-92)에서 이미 '장래에 배제해야 할 기능' 목록에 올라가 있다.
        => 당장에 문제없이 실행되던 SQL이라도 DBMS가 버전업하면서 에러를 일으킬 수 있는 위험성이 잔존.
           임시 SQL이면 몰라도, 시스템에 내장할 SQL이라면 이 문제가 심각한 이슈로 발전할 수 있다!
*/
