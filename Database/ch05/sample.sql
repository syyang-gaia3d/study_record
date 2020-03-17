
/* 복잡한 질의 - 뷰, 서브쿼리, 상관 서브쿼리 */

--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------

-- 뷰 : SQL 관점에서 보면 '테이블과 동일한 것' 단, 실제 데이터를 저장하지 않음

/*
    테이블과 뷰의 차이

    - 테이블 => INSERT 문으로 데이터를 추가하여 데이터베이스에 저장할 수 있다.
                데이터베이스에 데이터가 저장되는 곳은 컴퓨터의 '기억 장치(하드 디스크)'
             => SELECT 문으로 데이터를 검색할 때 실제 기억 장치(하드 디스크)에서
                데이터를 끌어와서 다양한 계산을 거친 뒤, 사용자에게 결과를 반환
    - 뷰 => 데이터를 "어디에도 저장하지 않"는다.
         => 뷰가 저장하는 것은 'SELECT 문' 자체!
         => 뷰에서 데이터를 꺼내려 하면 뷰는 내부적으로 SELECT문을 실행하여
            일시적인 가상 테이블을 만듬
*/

--------------------------------------------------------------------------

-- 뷰가 가진 이점
    -- 1. 데이터를 저장하지 않으므로 기억 장치 용량을 절약
    SELECT goods_classify, SUM(sell_price), SUM(buy_price)
        FROM Goods
        GROUP BY goods_classify; -- 뷰는 SELECT문만 저장한다.
    -- 2. 자주 사용하는 SELECT 문을 매번 작성하지 않고 뷰로 저장해 반복 사용
        -- 집계나 조건이 복잡하고 SELECT 문의 몸집이 커질수록 뷰를 통한 편의성 증대!
    
    -- 추가. 뷰가 포함하는 데이터는 원 테이블과 연동해서 자동으로 최신 상태를 유지
        -- 뷰란, 결국 'SELECT 문' = "뷰를 참조한다" 라는 것은 곧 "SELECT문을 실행한다"란 의미이므로
        -- 이것은 데이터를 테이블에 저장한 경우엔 얻을 수 없는 이점!
        -- (해당 테이블을 명시적으로 갱신하는 SQL을 실행하지 않는 한, 테이블의 데이터는 갱신되지 않음)

--------------------------------------------------------------------------

-- 뷰 작성 방법(CREATE VIEW 문) <- "SELECT 문 열과 뷰 열의 순서 일치"에 주의!!
-- 뷰 열은 뷰명 뒤에 리스트 형태로 정의

-- GoodsSum(상품합계) 뷰 생성
CREATE VIEW GoodsSum (goods_classify, cnt_goods) -- 리스트(괄호) 안에 쓰여진 것이 "뷰의 열명"이다.
AS      -- 절대 생략 안됨!!!!!
SELECT goods_classify, COUNT(*) -- 뷰 정의 내용(일반적인 SELECT문)
    FROM Goods
    GROUP BY goods_classify;

-- 뷰 사용 방법은 테이블과 동일함 
    -- 즉, SELECT문의 FROM구에 쓸 수 있다.
-- 뷰 사용 예
SELECT goods_classify, cnt_goods
    FROM GoodsSum;

-- 뷰 정의에는 어떤 SELECT 문이든 기술 가능
    -- WHERE, GROUP BY, HAVING 사용 가능
    -- 'SELECT *'로 모든 열을 지정할 수도 있음

--------------------------------------------------------------------------

-- 뷰 검색

-- 뷰를 FROM구에 지정했을 때, 검색은 2단계로 나뉨
    -- (!) 뷰에 정의된 SELECT 문 실행
    -- (2) 그 결과에 대해 뷰를 FROM 구에 지정한 SELECT 문 실행
-- => 뷰 검색에서는 항상 2개 이상의 SELECT 문이 실행됨!!
    -- 2개 이상? 다단 뷰(뷰를 가지고 또 다른 뷰를 만드는 형태)도 가능하기 때문

-- GoodsSumJim 뷰(다단 뷰의 예)
CREATE VIEW GoodsSumJim (goods_classify, cnt_goods)
AS
SELECT goods_classify, cnt_goods
    FROM GoodsSum
    WHERE goods_classify = '사무용품';

-- 뷰가 작성되었는지 확인
SELECT goods_classify, cnt_goods FROM GoodsSumJim;

-- 다단 뷰는 가능한 사용을 피하도록 하자!!
/* 대부분의 DBMS에서는 뷰를 겹쳐 사용할 경우, 성능저하가 발생한다!!! */

--------------------------------------------------------------------------

-- 뷰 제약사항

-- 1. 뷰 정의에 ORDER BY 구는 사용불가 : 테이블과 마찬가지로 뷰도 "행에는 순서가 없다"라고 정의하기 때문
-- 아래와 같은 뷰 정의는 불가능(postgreSQL은 예외적으로 실행된다.)
CREATE VIEW GoodsSum (goods_classify, cnt_goods)
AS
SELECT goods_classify, COUNT(*)
    FROM Goods
    GROUP BY goods_classify
    ORDER BY goods_classify; -- 뷰 정의에 ORDER BY를 사용하면 안됨

-- 2. 뷰 갱신(INSERT, DELETE, UPDATE)
-- 매우 엄격한 제약이 있으나, 뷰 갱신이 가능한 예외 경우 존재
    -- 표준 SQL 정의 : '뷰 정의 SELECT 문이 몇 가지 조건을 만족하는 경우 뷰 갱신이 가능하다.'
        /* 대표적인 조건
            (1) SELECT 구에 DISTINCT가 포함되어 있지 않다.
            (2) FROM 구에 포함되는 테이블이 하나다.
            (3) GROUP BY 구를 사용하고 있지 않다.
            (4) HAVING 구를 사용하고 있지 않다.
        */
    -- 에러 발생의 예(조건을 위배하고 있는 뷰에 대한 갱신 SQL)
    INSERT INTO GoodsSum VALUES ('전자제품', 5); -- GoodsSum은 원 테이블의 집약 결과를 보전하고 있는 뷰이다.

/* 집약한 뷰는 갱신할 수 없는 이유?
    - 뷰는 어디까지나 테이블로부터 파생된 것
    - 따라서, 기준이 되는 테이블이 갱신 => 뷰의 데이터 내용도 갱신됨 (연동)
    - 반대로 뷰가 갱신되었는데 원 테이블이 그에 맞춰 변경되지 않으면 "정합성에 문제"가 발생
    - 하지만 집약한 뷰에 대한 갱신은 테이블의 시점에서 정보가 부족해 테이블 내용을 갱신할 수 없다!
*/

-- 뷰를 갱신할 수 있는 경우
CREATE VIEW GoodsJim (goods_id, goods_name, goods_classify, sell_price, buy_price, register_date)
AS
SELECT *
    FROM Goods
    WHERE goods_classify = '사무용품';  -- 집약도, 결합도 없는 SELECT문
-- 뷰에 행 추가하기
INSERT INTO GoodsJim VALUES ('0009', '도장', '사무용품', 95, 10, '2009-11-30');
-- 뷰에 추가된 것을 확인
SELECT * FROM GoodsJim;
-- 원 테이블에 추가된 것을 확인
SELECT * FROM Goods;

-- UPDATE나 DELETE도 일반적인 테이블 처리와 동일한 방식으로 실행 가능하나,
-- 기본 테이블에 걸려있는 다양한 제약(주 키 제약이나 NOT NULL 제약 등)도 파생되므로 주의가 필요

--------------------------------------------------------------------------

-- 뷰 삭제(DROP VIEW 문)
-- GoodsSum 뷰 삭제
DROP VIEW GoodsSum; -- 뷰명 뒤에 뷰 열명을 리스트 형태로 나열할 수도 있다.

/* 뷰 삭제와 관련된 개별 구문 */
-- postgreSQL : 다단 뷰의 작성 기반이 되는 뷰를 삭제할 때
    -- 다단 뷰 작성 기반이 되는 뷰를 삭제할 때, 그것에 의존하는 뷰가 존재하면 에러 발생
    -- 의존하는 뷰 단위로 삭제하는 CASCADE 옵션 사용
    DROP VIEW GoodsSum CASCADE;

--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------

-- 서브쿼리(일회용 뷰(SELECT 문))

/* 뷰와 서브쿼리 비교 */
    -- 뷰 : 데이터 자체를 저장하는 것이 아니라 데이터를 추출하는 SELECT문을 저장하는 방법
    --      사용자 편의성을 향상시키는 도구
    -- 서브쿼리 : 뷰 정의 SELECT 문을 그대로 FROM 구에 삽입

-- GoodsSum 뷰 정의
-- 상품분류별로 상품을 집계하는 뷰
CREATE VIEW GoodsSum (goods_classify, cnt_goods)
AS
SELECT goods_classify, COUNT(*)
    FROM Goods
    GROUP BY goods_classify;
-- 뷰 작성 확인
SELECT goods_classify, cnt_goods FROM GoodsSum;

-- 서브쿼리
    -- FROM 구에 직접 뷰 정의 SELECT 기술
SELECT goods_classify, cnt_goods
    FROM (SELECT goods_classify, COUNT(*) AS cnt_goods
            FROM Goods
            GROUP BY goods_classify) AS GoodsSum; -- Oracle에서는 FROM 구에 AS를 쓸 수 없으므로 AS를 삭제해야 함

-- 서브쿼리는 일회용으로, 기억 장치(하드디스크)에 저장되는 뷰와 달리 실행 후에 "사라진다."

-- 서브쿼리(subquery) = sub(하위) + query(질의 = SELECT 문) = 한 단계 아래의 SELECT 문
-- 위 SELECT 문은 내포 구조로 되어 있어 FROM 구 안의 SELECT 문(서브쿼리)이 먼저 실행되고, 그 뒤에 바깥 SELECT 문이 실행됨


-- 서브쿼리 계층 수를 늘린다.
    -- 원칙적으로 서브쿼리 계층 수에 대한 제한이 없다.
    -- 따라서, 서브쿼리 안의 FROM 구에 서브쿼리를 작성하고 그 안에 있는 FROM 구에 또 서브쿼리를 작성하는 것도 가능하다.
SELECT goods_classify, cnt_goods
    FROM (SELECT *
            FROM (SELECT goods_classify, COUNT(*) AS cnt_goods
                    FROM Goods
                    GROUP BY goods_classify) AS GoodsSum
            WHERE cnt_goods = 4) AS GoodsSum2;

-- 서브쿼리 계층이 깊어질수록
    -- SQL 문을 이해하기 어려워지고,
    -- (뷰에서와 마찬가지로) 성능에도 악영향을 미친다.

-- 위와 같은 이유로 계층을 너무 깊게 만들지 않는 것이 좋다.


-- 서브쿼리 이름

-- 원칙상 필요한 것으로, 처리 내용을 표현할 수 있는 적절한 이름을 부여
-- 이름을 부여할 때는 AS 키워드를 사용하나, 생략도 가능하다. (예외적으로 Oracle 같은 경우는 AS를 사용하면 에러가 발생)

--------------------------------------------------------------------------

-- 스칼라 서브쿼리

-- 스칼라 : '단일'이란 의미.(데이터베이스 이외 분야에도 자주 사용되는 용어)
-- 스칼라 서브쿼리 : "반드시 1행 1열만을 반환 값으로 반환한다."라는 제약을 가진 서브쿼리
--                  테이블의 어떤 1행에 있는 어떤 1열의 값이란, 다시말해 "단 하나의 값"을 의미

-- 결과 값이 스칼라 값(단일 값) == 스칼라 서브쿼리 값(단일 값)을 비교 연산자(=, <> 등)의 입력값으로 사용할 수 있다!!


-- WHERE 구에 스칼라 서브쿼리를 사용

-- 판매단가가 전체 평균 판매단가보다 높은 상품만을 검색
-- 에러!! : WHERE 구에 집약 함수는 사용불가
SELECT goods_id, goods_name, sell_price
    FROM Goods
    WHERE sell_price > AVG(sell_price);
-- 평균 판매단가를 구하는 스칼라 서브쿼리
SELECT AVG(sell_price) FROM Goods; -- AVG 값만 결과 값으로 나오므로 스칼라 값!
-- 스칼라 서브쿼리를 이용한 바른 SQL문
SELECT goods_id, goods_name, sell_price
    FROM Goods
    WHERE sell_price > (SELECT AVG(sell_price) FROM Goods);

-- 서브쿼리를 사용한 SQL에서는 가장 먼저 서브쿼리가 실행되므로, 위 경우도 평균 단가를 구하는 스칼라 서브쿼리가 우선 실행됨


-- 스칼라 서브쿼리를 쓸 수 있는 곳
    -- 기본적으로 스칼라 값을 사용할 수 있는 곳이라면 어디든 가능
    -- => 상수나 열명을 쓸 수 있는 곳이라면 모두 가능!

-- SELECT 구에 스칼라 서브쿼리를 사용
SELECT goods_id,
       goods_name,
       sell_price,
       (SELECT AVG(sell_price) FROM Goods) AS avg_price
    FROM Goods;

-- HAVING 구에 스칼라 서브쿼리 사용
SELECT goods_classify, AVG(sell_price)
    FROM Goods
    GROUP BY goods_classify
    HAVING AVG(sell_price) > (SELECT AVG(sell_price) FROM Goods);


-- 스칼라 서브쿼리 사용 시 주의점
--  "절대로 서브쿼리가 복수 행을 반환하지 않도록 해야 한다."

-- 에러!! (스칼라 서브쿼리가 아니기 때문에 SELECT 문에 쓸 수 없다.)
SELECT goods_id,
       goods_name,
       sell_price,
       (SELECT AVG(sell_price)      -- 복수 행 반환
            FROM Goods
            GROUP BY goods_classify) AS avg_price
    FROM Goods;

/*
    복수 행을 반환하는 순간, 일반 서브쿼리가 된다.
    즉, 대입연산자를 사용할 수도 없고, SELECT 구 등에도 쓸 수 없다.
*/

--------------------------------------------------------------------------

-- 상관 서브쿼리 : 작은 그룹 내에서 비교가 필요할 때 사용
    -- GROUP BY 구와 동일(집합을 '자르는' 기능)

/* 일반 서브쿼리와 상관 서브쿼리의 차이점*/
-- 상품분류별로 평균 판매단가를 비교하기
-- => '상품분류별로 평균 판매단가보다 높은 상품'을 상품분류 그룹으로부터 추출하자
    -- 상품분류별로 평균단가를 구한다
    SELECT AVG(sell_price)
        FROM Goods
        GROUP BY goods_classify;
    /* 에러가 발생하는 서브쿼리(서브쿼리가 복수 행을 반환하는 일반 서브쿼리기 때문)
    SELECT goods_id, goods_name, sell_price
        FROM Goods
        WHERE sell_price > (SELECT AVG(sell_price) FROM Goods GROUP BY goods_classify);
    */
-- 상관 서브쿼리를 사용해서 상품분류별로 평균 판매단가를 비교하기
SELECT goods_classify, goods_name, sell_price
    FROM Goods AS S1
    WHERE sell_price > (SELECT AVG(sell_price)
                            FROM Goods AS S2
                            WHERE S1.goods_classify = S2.goods_classify -- 핵심!
                            GROUP BY goods_classify);
    -- 위 SELECT문의 WHERE 구(조건) 해설 : "각 상품의 판매단가와 평균 단가 비교를 '같은 상품분류 내(핵심)'에서 한다."
-- 상관 서브쿼리에서 핵심 포인트는 "서브쿼리 내에 추가한 WHERE 구 조건"

-- 상관 서브쿼리의 경우, 테이블 별명을 열명 앞에 '<테이블명(별명)>.<열명>' 형식으로 기술할 필요가 있다.
    -- (본 예시는 비교 대상 테이블이 Goods라는 동일 테이블이므로 구별을 위해 S1, S2를 별명으로 사용)

-- 상관 서브쿼리는 "테이블 전체가 아닌, 테이블 일부 레코드 집합에 한정된 비교를 하고싶은 경우"에 사용한다.
--  => 묶다(바인딩한다), 제한한다 등으로 표현하기도 
--     기본적으로 상관 서브쿼리가 행(레코드) 집합을 나누는 것은 GROUP BY와 유사하다.

/* 상관 서브쿼리가 에러처리 되지 않는 이유

    각각의 상품분류별로 평균 판매단가를 계산하고 
    이것을 가지고 상품 테이블의 '각' 행과 비교
    => 상관 서브쿼리가 행에 대해 1행만 반환하는 것과 동일

    즉, 상품분류가 바뀌면 비교할 평균단가도 바뀜
    ==> 각 상품의 판매단가와 평균단가가 비교됨

    상관 서브쿼리가 이해되지 않을 땐, '도식화'를 해보자!
*/


-- 결합 조건은 "반드시" 서브쿼리 안에 기술한다.
-- 잘못된 상관 서브쿼리 작성법('상관명 스코프'에 의한 금지)
SELECT goods_classify, goods_name, sell_price
    FROM Goods AS S1
    WHERE S1.goods_classify = S2.goods_classify         -- '묶기' 위한 조건을 서브쿼리 외부로 옮김 => 에러
    AND sell_price > (SELECT AVG(sell_price) FROM Goods AS S2
                        GROUP BY goods_classify);

/* 상관명 스코프
    - 상관명 : 테이블 별명으로 부여한 이름
    - 스코프(scope) : 생존 범위(유효범위)
    - 즉, 상관명이 통용될 수 있는 범위에 제한이 있음을 의미
*/

-- 서브쿼리 내부에서 부여된 상관명은 "해당 서브쿼리 내"에서만 사용할 수 있다!
-- SQL은 안쪽 서브쿼리부터 바깥쪽 서브쿼리 순으로 실행된다.
    -- 예시에서, 서브쿼리 실행이 끝난 후에는 실행 결과만 남고 추출 대상이었던 테이블 S2는 사라짐(물론 별명만 말소되고 데이터는 보존됨)
    -- 때문에 서브쿼리 바깥쪽이 시행되는 시점에서는 이미 S2가 존재하지 않아 '그런 이름의 테이블은 존재하지 않습니다'라는 에러가 반환
