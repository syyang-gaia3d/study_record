
/* 데이터 갱신 */


-- 데이터 등록(INSERT 문)

-- 예시로 사용할 GoodsIns 테이블 생성 구문
CREATE TABLE GoodsIns
(goods_id        CHAR(4)        NOT NULL,
 goods_name      VARCHAR(100)   NOT NULL,
 goods_classify  VARCHAR(32)    NOT NULL,
 sell_price      INTEGER        DEFAULT 0,
 buy_price       INTEGER        ,
 register_date   DATE           ,
 PRIMARY KEY    (goods_id));

--------------------------------------------------------------------------

-- INSERT 문 기본 구문
INSERT INTO GoodsIns (goods_id, goods_name, goods_classify, sell_price, buy_price, register_date)
    VALUES ('0001', '티셔츠', '의류', 1000, 500, '2009-09-20');

-- 문자형, 날짜형 : 작은따옴표 사용

-- 리스트 : 열명이나 값을 쉼표로 구분하고 바깥을 괄호로 감싸는 형식
    -- 열 리스트 => (goods_id, goods_name, goods_classify, sell_price, buy_price, register_date)
    -- 값 리스트 => ('0001', '티셔츠', '의류', 1000, 500, '2009-09-20')

-- 테이블명 뒤에 있는 열 리스트와 VAULE 구의 값 리스트는 열 수가 일치해야 함!
-- 수가 서로 다르면 에러가 발생하여 삽입 처리가 되지 않음.
INSERT INTO GoodsIns (goods_id, goods_name, goods_classify, sell_price, buy_price, register_date)
    VALUES ('0001', '티셔츠', '의류', 1000, 500); -- 에러발생
-- 단, 기본값을 이용하는 경우는 열 수가 일치하지 않아도 상관무! (기본값이 자동으로 입력되므로)

-- INSERT 문은 기본적으로 1회 실행에 1회 삽입함.
-- 따라서, 원칙적으로 복수의 행 삽입은 행 수만큼 INSERT 문을 반복 실행해야 함.

--------------------------------------------------------------------------

-- 복수행 INSERT : 1회에 복수 행을 INSERT 하는 기능

-- 일반 INSERT
INSERT INTO GoodsIns VALUES ('0002', '펀칭기', '사무용품', 500, 320, '2009-09-11');
INSERT INTO GoodsIns VALUES ('0003', '와이셔츠', '의류', 4000, 2800, NULL);
INSERT INTO GoodsIns VALUES ('0004', '식칼', '주방용품', 3000, 2800, '2009-09-20');

-- 복수행 INSERT (Oracle 이외)
INSERT INTO GoodsIns VALUES ('0002', '펀칭기', '사무용품', 500, 320, '2009-09-11'),
                            ('0003', '와이셔츠', '의류', 4000, 2800, NULL),
                            ('0004', '식칼', '주방용품', 3000, 2800, '2009-09-20');

/* 복수행 구문 사용 시, 주의점
    - INSERT 문 작성 내용에 실수가 있거나 부정확한 데이터를 삽입하려고 한 경우
        => 어느 행, 어느 지점에서 에러가 발생하고 있는지 찾아내기 어렵다.
    - 이 구문이 모든 RDBMS에서 지원되는 것은 아니다.
        => Oracle에서는 사용할 수 없다.(구문이 조금 다름)
*/
-- 참고 : Oracleㅇ서의 복수행 INSERT
INSERT ALL INTO GoodsIns VALUES ('0002', '펀칭기', '사무용품', 500, 320, '2009-09-11'),
           INTO GoodsIns VALUES ('0003', '와이셔츠', '의류', 4000, 2800, NULL),
           INTO GoodsIns VALUES ('0004', '식칼', '주방용품', 3000, 2800, '2009-09-20')
        SELECT * FROM DUAL; -- 실질적인 의미가 없는 부분
    -- * DUAL = Oracle에서만 존재하는 일종의 더미 테이블(설치하면 반드시 생겨남)
    -- ** DUAL 내에는 의미 있는 데이터는 들어 있지 않고, INSERT나 UPDATE도 되지 않음

--------------------------------------------------------------------------

-- 열 리스트 생략
-- 테이블의 모든 열에 대해 INSERT 문을 실행하는 경우, 테이블명 뒤에 기술하는 열 리스트 생략 가능

-- 열 리스트가 있음
INSERT INTO GoodsIns (goods_id, goods_name, goods_classify, sell_price, buy_price, register_date)
    VALUES ('0005', '압력솥', '주방용품', 6800, 5000, '2009-01-15');
-- 열 리스트가 없음
INSERT INTO GoodsIns VALUES ('0005', '압력솥', '주방용품', 6800, 5000, '2009-01-15');

--------------------------------------------------------------------------

-- NULL 삽입
-- 열에 NULL을 할당하고 싶은 경우, VALUE 구의 값 리스트에 NULL을 직접 기술한다.

-- buy_price에 NULL 할당
INSERT INTO GoodsIns (goods_id, goods_name, goods_classify, sell_price, buy_price, register_date)
    VALUES ('0006', '포크', '주방용품', 500, NULL, '2009-09-20');

-- NULL을 할당하기 위해선 해당 열이 NOT NULL 제약을 가지고 있으면 안 된다.
-- NOT NULL 제약이 있는 열에 NULL을 지정한 경우, INSERT 문은 에러 처리가 된다.

/* '삽입에 실패한다' 
    = INSERT 문으로 등록하려 했던 데이터가 등록되지 않았다.
    => 이전에 이미 테이블에 등록되어 있던 데이터가 사라지거나 망가지지는 않는다.
        (DELETE나 UPDATE 등 갱신문에 대해서도 동일함)

    *** SQL이 실패한 경우 테이블 내 데이터에는 아무런 변동이 없다!
*/

--------------------------------------------------------------------------

-- 기본값 삽입 (DEFAULT 제약)
-- 테이블 열에는 기본값(초깃값)을 설정할 수 있다.
-- 방법 : CREATE TABLE 문 안에, 열에 대한 DEFAULT 제약 부여
    CREATE TABLE GoodsIns
    (goods_id        CHAR(4)        NOT NULL,
    goods_name      VARCHAR(100)   NOT NULL,
    goods_classify  VARCHAR(32)    NOT NULL,
    sell_price      INTEGER        DEFAULT 0, -- 기본값 설정!
    buy_price       INTEGER        ,
    register_date   DATE           ,
    PRIMARY KEY    (goods_id));

/* 테이블 정의 시, 기본값이 설정된 경우 */
-- 자동으로 해당 값을 INSERT 문 값으로 사용 가능

--  1. 명시적 방법 : VALUE 구에 DEFAULT 키워드 지정
INSERT INTO GoodsIns (goods_id, goods_name, goods_classify, sell_price, buy_price, register_date)
    VALUES ('0007', '도마', '주방용품', DEFAULT, 790, '2009-04-28');
    -- RDBMS가 자동으로 열의 기본값을 사용하여 레코드 삽입을 수행
        -- 삽입 행 확인
        SELECT * FROM GoodsIns WHERE goods_id = '0007';

-- 2. 암묵적 방법 : 기본값이 설정되어 있는 열을 열 리스트 및 VALUE 구에서 생략
INSERT INTO GoodsIns (goods_id, goods_name, goods_classify, buy_price, register_date) -- sell_price(판매단가) 생략
    VALUES ('0007', '도마', '주방용품', 790, '2009-04-28'); --값도 생략

-- 사용은 무엇을 하면 좋을까? "명시적 방법" 추천!
-- WHY??? sell_price 열에 기본값이 사용되고 있다는 것을 소스를 보고 바로 알 수 있는, 알기 쉬운 SQL문이 되기 때문!!

/* 기본값이 설정되어 있지 않은 열을 생략한 경우
    - NULL이 할당됨.
    - 따라서, NOT NULL 제약이 있는 열을 생략하면 INSERT 문이 에러 처리가 됨!
*/
-- buy_price 열(제약 없음)을 생략 : NULL이 됨
INSERT INTO GoodsIns (goods_id, goods_name, goods_classify, sell_price, register_date)
    VALUES ('0008', '볼펜', '사무용품', 100, '2009-11-11');
-- goods_name 열(NOT NULL 제약)을 생략 : 에러!
INSERT INTO GoodsIns (goods_id, goods_classify, sell_price, buy_price, register_date)
    VALUES ('0008', '사무용품', 1000, 500, '2009-12-12');
    
--------------------------------------------------------------------------

-- 다른 테이블에서 데이터 복사(INSERT .... SELECT) => 데이터 백업에 유용함

/* 데이터를 삽입하는 방법
    - VALUE 구를 사용하여 구체적인 데이터를 지정하는 방법
    - '다른 테이블에서 선택'하는 방법
*/

-- 데이터 삽입 대상인 상품 복사 테이블(GoodsCopy)
CREATE TABLE GoodsCopy
(goods_id       CHAR(4)         NOT NULL,
 goods_name     VARCHAR(100)    NOT NULL,
 goods_classify VARCHAR(32)     NOT NULL,
 sell_price     INTEGER         ,
 buy_price      INTEGER         ,
 register_date  DATE            ,
 PRIMARY KEY    (goods_id));

-- INSERT ... SELECT
-- 상품 테이블 데이터를 상품 복사 테이블로 '복사'
INSERT INTO GoodsCopy (goods_id, goods_name, goods_classify, sell_price, buy_price, register_date)
SELECT goods_id, goods_name, goods_classify, sell_price, buy_price, register_date FROM Goods;


/* SELECT 문의 적용 범위
    - WHERE 구나 GROUP BY 구 등을 사용할 수도 있음.
      (단, ORDER BY 구는 테이블 내부 레코드 정렬 순서가 보장되지 않아 의미가 없음)
    - 테이블 간 데이터를 교환하고 싶은 경우에 편리한 기능
*/
-- 상품분류별로 정리한 테이블(GoodsClassify)
CREATE TABLE GoodsClassify
(goods_classify VARCHAR(32) NOT NULL,
 sum_sell_price INTEGER     ,
 sum_buy_price  INTEGER     ,
 PRIMARY KEY    (goods_classify));

-- 다른 테이블에서 데이터를 집악해서 삽입하는 INSERT ... SELECT 뭄ㄴ
INSERT INTO GoodsClassify (goods_classify, sum_sell_price, sum_buy_price)
SELECT goods_classify, SUM(sell_price), SUM(buy_price)
    FROM Goods
    GROUP BY goods_classify;

-- 삽입 데이터 확인
SELECT * FROM GoodsClassify;

--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------

-- 데이터 삭제(DELETE 문)

/* 데이터 삭제 방법
    1. DROP TABLE 문 : 테이블 자체를 삭제함
        테이블을 통째로 삭제하므로 한번 삭제 후 다시 데이터를 등록하려면 
        CREATE TABLE 문으로 테이블을 다시 생성한 후, 데이터를 처음부터 입력해야 함 
    2. DELETE 문 : 테이블은 남겨두고 테이블 내의 모든 행을 삭제
        데이터(행)을 삭제해도 테이블은 남아있어 INSERT문을 사용해서 금방 데이터를 재등록할 수 있음.
*/

--------------------------------------------------------------------------

-- DELETE 문 기본 구문
DELETE FROM Goods; -- Goods 테이블을 빈 테이블로 만듬

-- 자주 틀리는 문법 오류!
    -- DELETE <테이블명> : FROM 구를 생략하여 에러 발생!
    -- DELETE <열명> FROM <테이블명> : <열명>이 들어가서 에러 발생!
    -- DELETE * FROM <테이블명> : 위와 마찬가지!
-- 위 명령이 제대로 동작하지 않는 이유?
--  => 삭제 대상이 테이블이 아닌 테이블에 포함된 '행(레코드)'이므로!

/* 참고 */
-- INSERT 문과 마찬가지로 데이터 갱신 처리는 모든 "행(레코드)"을 기본 단위로 처리!

--------------------------------------------------------------------------

-- 삭제 대상을 제한하는 DELETE 문(탐색형 DELETE) : WHERE 구 이용
-- (정식명이 '탐색형 DELETE문'인데 보통은 단순히 'DELETE문'이라고 부를 때가 많다.)

-- 판매단가가 4000원 이상인 행만 삭제
DELETE FROM Goods
    WHERE sell_price >= 4000;

-- WHERE 구 기술 방법은 SELECT 문과 동일

-- 삭제 결과 확인
SELECT * FROM Goods;

-- DELETE 문은 GROUP BY, HAVING, ORDER BY 구를 지정할 수 없다.
/* 
    >> 이유?

    GROUP BY와 HAVING은 원 테이블에서 데이터를 선택할 때 '추출 형식을 바꾸고 싶은' 경우에 사용하며
    ORDER BY는 결과의 표시 순서를 지정하는 것이 목적이다.

    즉, 테이블 데이터 자체를 삭제하는 처리에는 필요가 없는 구문들이다.
*/

--------------------------------------------------------------------------

-- 삭제와 버리기(TRUNCATE 문)

-- TRUNCATE 문 ('잘라 버리다'는 의미) : 반드시 테이블의 모든 데이터를 삭제함!
-- Oracle, SQL Server, PostgreSQL, MySQL 등에서 지원(DE2는 사용불가)
TRUNCATE <테이블명>;

/*  특징
  - WHERE 구로 조건을 지정해서 일부 행만 삭제하는 기능 없음
  - 세밀한 제어가 불가능한 대신, "DELETE보다 고속으로" 데이터를 삭제
    (DELETE 문은 DML문 중에서도 시간이 많이 걸리는 처리 중 하나)
  - 모든 데이터를 삭제해도 될 때는 TRUNCATE를 사용하는 것이 처리 시간을 단축할 수 있음
  - 단, Oracle처럼 TRUNCATE를 DML이 아니라 DDL로 정의하고 있는 경우 등 제품에 따라 주의할 점이 있음.
    (Oracle에서는 TrUNCATE에 대한 ROLLBACK이 불가능. TRUNCATE 실행과 동시에 암묵적으로 COMMIT도 실행됨)
*/

--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------

-- 데이터 갱신(UPDATE 문)

-- UPDATE 문 기본 구문 : 갱신 대상 열과 갱신 후 값을 SET 구에 기술

-- 등록일을 모두 '2009년 10월 10일'로 변경
UPDATE Goods
    SET register_date = '2009-10-10'; -- 이 경우, 설령 원데이터가 NULL값이더라도 해당 값으로 변경됨
-- 변경 내용 확인
SELECT * FROM Goods;

--------------------------------------------------------------------------

-- 조건을 지정한 UPDATE문(탐색형 UPDATE) : WHERE 구 이용

-- 상품분류(goods_classify)가 '주방용품'인 행만 판매단가(sell_price)를 10배 변경
UPDATE Goods
    SET sell_price = 10 * sell_price -- 열을 포함한 식도 가능
    WHERE goods_classify = '주방용품';
-- 변경 내용 확인
SELECT * FROM Goods ORDER BY goods_id;

--------------------------------------------------------------------------

-- NULL로 갱신하기(NULL 클리어)
-- 방법 : 대입식 우변에 NULL을 직접 입력

-- 상품ID가 '0008'인 볼펜의 등록일을 NULL로 변경
UPDATE Goods
    SET register_date = NULL
    WHERE goods_id = '0008';
-- 변경 내용 확인
SELECT * FROM Goods ORDER BY goods_id;

-- UPDATE 문도 INSERT 문과 마찬가지로 NULL을 하나의 값으로 취급
-- 단, NULL 클리어가 가능한 것은 NOT NULL 제약이나 주 키 제약이 없는 열에만 해당!!!
-- (위와 같은 제약이 있는 경우, 에러 발생)

--------------------------------------------------------------------------

-- 복수 열 갱신
-- SET 구에 복수의 열을 변경 대상으로 기술 가능

-- 주방용품 판매단가(sell_price)를 10배로 변경했는데, 동시에 매입단가(buy_price)도 1/2로 변경
    -- 1. 1회 UPDATE로 1열만 갱신
    UPDATE Goods
        SET sell_price = sell_price * 10
        WHERE goods_classify = '주방용품';
    
    UPDATE Goods
        SET buy_price = buy_price / 2
        WHERE goods_classify = '주방용품';

    -- 2. 열을 쉼포료 구분해서 나열(어떤 DBMS든 사용가능)
    UPDATE Goods
        SET sell_price = sell_price * 10,
            buy_price = buy_price / 2
        WHERE goods_classify = '주방용품';
    
    -- 3. 열을 괄호로 감싸 리스트로 표현(postgreSQL, DB2에서만 가능)
    UPDATE Goods
        SET (sell_price, buy_price) = (sell_price * 10, buy_price /2)
        WHERE goods_classify = '주방용품';
    
-- 변경 내용 확인
SELECT * FROM Goods ORDER BY goods_id;

--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------

-- 트랜잭션 : 세트(한 묶음)로 실행되어야 할 하나 이상의 변경 처리 집합
-- 즉, 데이터베이스에서 이루어지는 하나 이상의 갱신 처리를 모아서 부르는 명칭

/*
    하나의 트랜잭션에 '어느 정도 수의 갱신 처리를 포함해야 하는지'
    또는, '어떤 처리를 포함해야 하는지' 등에 대한 고정된 기준은 없다!

    => 어디까지나 사용자 요구에 따라 결정된다.
*/

-- 트랜잭션 구문
/*
    트랜잭션 개시문;

        DML 문(1);
        DML 문(2);
        DML 문(3);

    트랜잭션 종료문(COMMIT 또는 ROLLBACK);
*/

-- 트랜잭션 개시문
    -- SQL Server, PostgreSQL
    BEGIN TRANSACTION;
    -- My SQL
    START TRANSACTION;
    -- Oracle, DB2
    -- 없음!!

-- EX> 취급 상품 갱신 트랜잭션
BEGIN TRANSACTION;
    
    -- 와이셔츠 판매단가 1000원 내림
    UPDATE Goods
        SET sell_price = sell_price - 1000
        WHERE goods_name = '와이셔츠';
    
    -- 티셔츠 판매단가 1000원 올림
    UPDATE Goods
        SET sell_price = sell_price + 1000
        WHERE goods_name = '티셔츠';

COMMIT;

--------------------------------------------------------------------------

-- COMMIT : 처리 확정(트랜잭션 종료문)
-- 트랜잭션에 의한 변경 내용을 모두 반영한 후에 트랜잭션을 종료하는 명령(파일에서의 '덮어쓰기')

-- 한번 "커밋"하면 더이상 트랜잭션 개시 이전으로 돌아갈 수 없다!!
-- (때문에 특히 DELETE문의 COMMIT은 더 세심한 주의가 필요하다)

--------------------------------------------------------------------------

-- ROLLBACK : 처리 취소(트랜잭션 종료문)
-- 트랜잭션에 의해 처리된 변경 내용을 모두 취소하고 트랜잭션을 종료하는 명령(파일로 치면 '저장하지 않고 종료')

-- "롤백"하면 데이터베이스 상태가 트랜잭션 개시 전으로 돌아간다.
-- 따라서, 데이터 손실로 이어지는 경우는 거의 없다.

-- 롤백의 예
BEGIN TRANSACTION;
    
    -- 와이셔츠 판매단가 1000원 내림
    UPDATE Goods
        SET sell_price = sell_price - 1000
        WHERE goods_name = '와이셔츠';
    
    -- 티셔츠 판매단가 1000원 올림
    UPDATE Goods
        SET sell_price = sell_price + 1000
        WHERE goods_name = '티셔츠';

ROLLBACK;
-- 위 트랜잭션을 실행해도 테이블 데이터에는 아무런 변경사항이 없다.
-- 때문에 커밋과 달리, 롤백할 때에는 비교적 가벼운 마음으로 실행해도 된다.
-- 설령, 처리를 확정하고 싶었던 경우라도 트랜잭션을 재실행하기만 하면 된다.

--------------------------------------------------------------------------

-- 트랜잭션은 언제 시작되는가????
/*
    - 트랜잭션 개시를 위한 표준 명령이 존재하지 않으므로 DBMS마다 서로 다른 개시문을 사용한다.
    - 실제로는 대부분의 제품이 트랜잭션 개시 명령을 사용하지 않는다.
    - 즉, 대부분 데이터베이스에 접속한 시점에 트랜잭션이 암묵적으로 개시되기 때문에 
      사용자가 명시적으로 트랜잭션을 시작해 줄 필요가 없다.
    - 예를 들어, Oracle은
        1. '하나의 SQL 문에 하나의 트랜잭션'이라는 규칙이 적용(자동 커밋 모드)
        2. 사용자가 COMMIT 또는 ROLLBACK을 실행하기까지가 하나의 트랜잭션으로 간주(Oracle 기본 설정)
      의 두 가지 패턴을 사용한다.
    - 자동 커밋을 기본 설정으로 하는 DBMS => SQL Server, PostgreSQL, MySQL 등
    - 자동 커밋 모드에서는 DML 문 하나마다 트랜잭션 개시문과 종료문이 실행됨.
    - 자동 커밋 모드에서는 DELETE 문 실행에 주의해야 한다.(ROLLBACK 불가능)
        -> 트랜잭션을 명시적으로 개시하고 있거나 자동 커밋 모드를 꺼놓은 상태일 때만 ROLLBACK이 가능하다.
*/

--------------------------------------------------------------------------

-- ACID 특성 : 원자성(Atomicity), 일관성(Consistency), 독립성(Isolation), 지속성(Durablility)
    -- DBMS 트랜잭션에서 지켜야 할 네 가지 약속을 뜻함(표준 규격)

/*
    1. 원자성
    - 트랜잭션이 끝난 시점에 모든 갱신 처리가 실행된 상태 또는 실행되지 않은 상태로 종료되는 것을 보증하는 성질
    - All or Noting
    - 원자성의 중요성 : 트랜잭션이 어중간하게 종료되는 경우, 업무에 지장이 발생

    2. 일관성(= 정합성)
    - 트랜잭션에 포함되는 처리는 데이터베이스에 미리 설정된 제약(주 키 제약이나 NOT NULL 제약 등)을 지켜야 한다는 성질
    - NOT NULL 제약이 있는 열을 NULL로 갱신하거나, 주 키 제약 위반 레코드를 삽입하는 SQL문이 에러 처리되는 이유
        => 트랜잭션 관점으로는 '롤백되었다'고 할 수 있다.
        => 이는 SQL이 한 문장 단위로 취소되어 실행되지 않았다는 것과 동일하다.
    - 트랜잭션 내에서 일관성(정합성)을 위반한 DML문이 포함되어 있는 경우, 제약을 위반한 DML문만 실행되지 않는다.
    
    3. 독립성
    - 트랜잭션 상호 간 서로 간섭하지 않음을 보증하는 성질
    - 트랜잭션 상호 간에 내포 관계 성립하지 않음
    - 어떤 트랜잭션에 의한 변경은 트랜잭션 종료 시까지는 다른 트랜잭션으로부터 은폐된다.
    - 즉, 어떤 트랜잭션이 테이블에 행을 추가했다해도 커밋 전까지는 다른 트랜잭션이 인식할 수 없다!

    4. 지속성(영속성)
    - 트랜잭션이 (커밋이든 롤백이든) 종료되면 해당 시점의 데이터 상태가 저장되는 것을 보증하는 성질
    - 시스템에 장애가 발생해서 데이터가 망가진 경우라도 데이터베이스는 어떠한 방법으로든 복구 수단을 가지고 제공해야 한다.
    - 지속성이 없다면 커밋을 해서 종료했다해도 시스템 장애로 모든 데이터가 날아가버릴 수 있다.
    - 지속성 보증 방법 : 구현방법에 따라 다름
        => 가장 일반적인 방법 : 트랜잭션 실행 기록을 디스크 등에 기록(로그)해 두었다가 장애가 발생한 경우 이 로그를 사용해서 장애 이전 상태로 복원함
*/
