
/* 함수, 술어, CASE 식 */

--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------

-- 함수 => 산술 함수 / 문자열 함수 / 날짜 함수 / 변환 함수 / 집약 함수
/* 함수란?
    어떤 값을 '입력' 하면 그에 대응하는 값을 '출력'하는 기능 
    - 인수(파라미터) : 입력값
    - 반환 값 : 출력값
*/

/* 함수의 종류
    - 산술 함수 : 수치 계산을 위한 함수
    - 문자열 함수 : 문자열 처리를 위한 함수
    - 날짜 함수 : 날짜 처리를 위한 함수
    - 변환 함수 : 데이터형이나 값을 변환하기 위한 함수
    - 집약 함수 : 데이터 집계를 위한 함수
*/

-- 함수의 종류는 매~~~우 많다. 자주 사용하는 건 30~50개 정도.
-- 자주 사용하는 것을 제외한 함수들은 참고자료(DBMS별 메뉴얼, 서적, 웹 사이트 등)를 찾자

--------------------------------------------------------------------------
--------------------------------------------------------------------------

/* 산술 함수 */
-- 대표적으로 사칙연산(+, -, *, /)가 있지만 그 외에 다른 함수들 소개

/* --------------------- 샘플 테이블(SampleMath) 생성 --------------------- */

-- DDL : 테이블 작성
CREATE TABLE SampleMath
(m      NUMERIC(10,3),      -- NUMERIC(전체 자릿수, 소수 자릿수) : 수치의 크기를 지정하는 소수 데이터형
 n      INTEGER,            -- postgreSQL의 ROUND 함수는 NUMERIC처럼 제한된 데이터형만 사용할 수 있다.
 p      INTEGEr);

-- DML : 데이터 등록
BEGIN TRANSACTION;

INSERT INTO SampleMath(m, n, p) VALUES (500,    0,    NULL);
INSERT INTO SampleMath(m, n, p) VALUES (-180,   0,    NULL);
INSERT INTO SampleMath(m, n, p) VALUES (NULL,  NULL,  NULL);
INSERT INTO SampleMath(m, n, p) VALUES (NULL,   7,    3);
INSERT INTO SampleMath(m, n, p) VALUES (NULL,   5,    2);
INSERT INTO SampleMath(m, n, p) VALUES (NULL,   4,    NULL);
INSERT INTO SampleMath(m, n, p) VALUES (8,      NULL, 3);
INSERT INTO SampleMath(m, n, p) VALUES (2.27,   1,    NULL);
INSERT INTO SampleMath(m, n, p) VALUES (5.555,  2,    NULL);
INSERT INTO SampleMath(m, n, p) VALUES (NULL,   1,    NULL);
INSERT INTO SampleMath(m, n, p) VALUES (8.76,   NULL, NULL);

COMMIT;

-- 데이터 확인
SELECT * FROM SampleMath;

/* ----------------------------------------------------------------------- */

-- ABS(수치) : 절댓값
    -- 절댓값을 구하는 함수
SELECT m,
       ABS(m) AS abs_col
    FROM SampleMath;

-- ABS 함수를 포함한 거의 모든 함수는 NULL을 인수로 받을 경우, NULL을 반환하도록 정해져있다.
-- (단, COALESE 함수는 예외)


-- MOD(피제수, 제수) : 나머지   (주의 : SQLServer에서는 %를 사용)
    -- 나눗셈의 나머지 값을 구하는 함수
    -- 소수 값이 들어가면 '나머지'라는 개념이 없어지므로 MOD 함수는 정수형 열에만 사용할 수 있다.
-- 나눗셈(n/p)의 나머지
SELECT n, p,
       MOD(n, p) AS mol_col
    FROM SampleMath;


-- ROUND(대상 수, 반올림 자릿수) : 반올림
    -- 소수점 이하 (반올림 자릿수 +1)에서 반올림한다.
SELECT m,n,
       ROUND(m, n) AS round_col
    FROM SampleMath;

--------------------------------------------------------------------------
--------------------------------------------------------------------------

/* 문자열 함수 */

/* --------------------- 샘플 테이블(SampleStr) 생성 --------------------- */

-- DDL 테이블 작성
CREATE TABLE SampleStr
(str1   VARCHAR(40),
 str2   VARCHAR(40),
 str3   VARCHAR(40));

-- DML : 데이터 등록
BEGIN TRANSACTION;

INSERT INTO SampleStr(str1, str2, str3) VALUES ('가나다', '라마', NULL);
INSERT INTO SampleStr(str1, str2, str3) VALUES ('abc', 'def', NULL);
INSERT INTO SampleStr(str1, str2, str3) VALUES ('김', '철수', '입니다');
INSERT INTO SampleStr(str1, str2, str3) VALUES ('aaa', NULL, NULL);
INSERT INTO SampleStr(str1, str2, str3) VALUES (NULL, '가가가', NULL);
INSERT INTO SampleStr(str1, str2, str3) VALUES ('@!#$%', NULL, NULL);
INSERT INTO SampleStr(str1, str2, str3) VALUES ('ABC', NULL, NULL);
INSERT INTO SampleStr(str1, str2, str3) VALUES ('aBC', NULL, NULL);
INSERT INTO SampleStr(str1, str2, str3) VALUES ('abc철수', 'abc', 'ABC');
INSERT INTO SampleStr(str1, str2, str3) VALUES ('abcdefabc', 'abc', 'ABC');
INSERT INTO SampleStr(str1, str2, str3) VALUES ('아이우', '이', '우');

COMMIT;

-- 데이터 확인
SELECT * FROM SampleStr;

/* ----------------------------------------------------------------------- */

-- 문자열1 || 문자열2 : 연결
    -- '가나다' + '라마' = '가나다라마'
SELECT str1, str2,
       str1 || str2 AS str_concat
    FROM SampleStr;

-- 문자열 연결도 결합하는 문자가 NULL이면 결과도 NULL이다.

-- 3개 이상의 문자열 연결도 가능하다.
SELECT str1, str2, str3,
       str1 || str2 || str3 AS str_concat
    FROM SampleStr
    WHERE str1 = '김';

-- || 함수는 SQLServer와 MySQL에서는 사용할 수 없다.
    -- SQLServer => + 함수 사용
    -- MySQL => CONCAT 함수 사용


-- LENGTH(문자열) : 문자열 길이
    -- 문자열이 몇 개의 문자로 구성되는지 조사하는 함수
SELECT str1,
       LENGTH(str1) AS len_str
    FROM SampleStr;

-- LENGTH 함수는 SQLServer에서 사용불가
    -- SQLServer => LEN(문자열) 함수 사용
-- 1문자를 길이 2 이상으로 세는 LENGTH 함수
/*
    LENGTH 함수는 무엇을 단위로 '1개'라고 세는 걸까?
    - 영문자(1바이트) 외에도 멀티바이트 문자(한글, 한자 등)가 존재
    - LENGTH 함수의 단위가 '바이트'인 경우(대표적으로 MySQL), 멀티바이트 문자에 대해 1 이상의 수가 더해진다.
    - 즉, 같은 LENGTH 함수라도 DBMS에 따라 결과값이 다를 수 있다. 주의할 것.
    (* MySQL의 경우, 문자열 길이를 취득하기 위한 CHAR_LENGTH라는 독자 함수를 제공)
*/


-- LOWER(문자열) : 소문자화
    -- 알파벳에만 적용되는 함수로, 인수 문자열을 모두 소문자로 변환함
    -- 알파벳 이외에 적용하거나, 원 데이터가 소문자인 경우 변화없음!
SELECT str1,
       LOWER(str1) AS low_str
    FROM SampleStr
    WHERE str1 IN ('ABC', 'aBC', 'abc', '김');


-- UPPER(문자열) : 대문자화
    -- 알파벳에만 적용되는 함수로, 인수 문자열을 모두 대문자로 변환
    -- 알파벳 이외의 문자, 원 데이터가 대문자인 경우 변화없음!
SELECT str1,
       UPPER(str1) AS up_str
    FROM SampleStr
    WHERE str1 IN ('ABC', 'aBC', 'abc', '김');


-- REPLACE(대상 문자열, 치환 전 문자열, 치환 후 문자열) : 문자열 치환
    -- 문자열 안에 있는 일부 문자열을 다른 문자열로 변경할 때 사용
SELECT str1, str2, str3,
       REPLACE(str1, str2, str3) AS rep_str     -- str1 안에 str2이 있다면 str3로 치환!
    FROM SampleStr;
-- 함수 내 파라미터 중 한 군데라도 NULL 값이 있으면 NULL 반환


-- SUBSTRING(대상 문자열 FROM 잘라내기 시작 위치 FOR 잘라낼 문자 수) : 문자열 잘라내기
    -- 문자열에서 일부 문자열만 잘라내고 싶은 경우 사용
    -- 잘라내기 시작 위치 => '좌측에서부터 몇번째 문자'인가?
    -- 단, 멀티바이트 문자 문제가 존재하므로 주의가 필요
SELECT str1,
       SUBSTRING(str1 FROM 3 FOR 2) AS sub_str
    FROM SampleStr;
-- 표준SQL에서 정해져있는 함수이나, 사용이 가능한 건 PostgreSQL과 MySQL뿐
-- SQLServer 전용 구문 => SUBSTRING(대상 문자열, 잘라내기 시작 위치, 잘라낼 문자 수)
-- Oracle, DB2 => SUBSTR(대상 문자열, 잘라내기 시작 위치, 잘라낼 문자 수)

--------------------------------------------------------------------------
--------------------------------------------------------------------------

/* 날짜 함수 */

-- 대부분이 DBMS별 개발 방법에 의존하고 있어서 제각각
-- 날짜 함수에 대해 보다 자세히 알고 싶은 경우, 가장 확실한 방법은 '사용하고 있는 DBMS의 매뉴얼'을 보는 것!

    /* 표준SQL에서 정하고 있고 대부분의 DBMS에서 사용할 수 있는 것을 추린 내용 */

-- CURRENT_DATE : 현재 날짜
    -- SQL을 실행한 날, 즉 함수가 실행된 날을 반환 값으로 출력
    -- 인수 없음(괄호 없음)
SELECT CURRENT_DATE;
    -- SQLServer => CURRENT_TIMESTAMP를 이용
        -- CURRENT_TIMESTAMP를 CAST해서 날짜형으로 변환
        SELECT CAST(CURRENT_TIMESTAMP AS DATE) AS CUR_DATE;
    -- Oracle => 더미 테이블(DAUL)을 FROM구에 지정
        SELECT CURRENT_DATE FROM DAUL;
    -- DB2 => CURRENT와 DATE 사이에 공백(스페이스)을 두고 'SYSIBM.SYSDUMMY1'이란 더미 테이블을 지정
        SELECT CURRENT DATE FROM SYSIBM.SUSDUMMY1;


-- CURRENT_TIME : 현재 시간
    -- SQL을 실행한 시간, 즉 함수가 실행된 시간을 반환 값으로 출력
    -- 인수 없음(괄호 없음)
SELECT CURRENT_TIME;
    -- SQLServer => CURRENT_TIMESTAMP를 이용
        --CURRENT_TIMESTAMP를 CAST해서 시간형 변환
        SELECT CAST(CURRENT_TIMESTAMP AS TIME) AS CUR_TIME;
    -- Oracle => 날짜까지 포함된 형태로 결과 출력
        -- 더미 테이블로 DAUL 지정
        SELECT CURRENT_TIMESTAMP FROM DAUL;
    -- DB2 => CURRENT와 TIME 사이에 공백 & SYSIBM.SYSDUMMY1 더미 테이블 지정
        SELECT CURRENT TIME FROM SYSIBM.SYSDUMMY1;


-- CURRENT_TIMESTAMP : 현재 일시
    -- CURRENT_TIMESTAMP = SURRENT_DATE + DURRENT_TIME
    -- 현재 날짜와 시간을 함께 취득하고 취득한 결과로부터 날짜나 시간만 잘라낼 수 있다.
SELECT CURRENT_TIMESTAMP;
-- 주요 DBMS에서 사용할 수 있다. 단, Oracle과 DB2에서는 구문이 조금 다르다.(앞서 언급한 차이)


-- EXTRACT(날짜 요소 FROM 날짜) : 날짜 요소 추출하기
    -- 날짜 데이텅서 일부분을 추출하는 것
    -- '년', '월', '시간', '초' 등 일부만 추출할 때 사용 => 반환 값은 "숫자형"(날짜형아님)
SELECT CURRENT_TIMESTAMP,
       EXTRACT(YEAR     FROM CURRENT_TIMESTAMP) AS year,
       EXTRACT(MONTH    FROM CURRENT_TIMESTAMP) AS month,
       EXTRACT(DAY      FROM CURRENT_TIMESTAMP) AS day,
       EXTRACT(HOUR     FROM CURRENT_TIMESTAMP) AS hour,
       EXTRACT(MINUTE   FROM CURRENT_TIMESTAMP) AS minute,
       EXTRACT(SECOND   FROM CURRENT_TIMESTAMP) AS second;
    -- SQLServer => DATEPART 독자 함수 사용
        SELECT CURRENT_TIMESTAMP,
               DATEPART(YEAR    FROM CURRENT_TIMESTAMP) AS year,
               DATEPART(MONTH   FROM CURRENT_TIMESTAMP) AS month,
               DATEPART(DAY     FROM CURRENT_TIMESTAMP) AS day,
               DATEPART(HOUR    FROM CURRENT_TIMESTAMP) AS hour,
               DATEPART(MINUTE  FROM CURRENT_TIMESTAMP) AS minute,
               DATEPART(SECOND  FROM CURRENT_TIMESTAMP) AS second;
    -- Oracle, DB2 => CURRENT_DATE경우와 동일
        -- Oracle : FROM 구에 더미 테이블(DAUL) 지정
        SELECT CURRENT_TIMESTAMP,
               EXTRACT(YEAR     FROM CURRENT_TIMESTAMP) AS year,
               EXTRACT(MONTH    FROM CURRENT_TIMESTAMP) AS month,
               EXTRACT(DAY      FROM CURRENT_TIMESTAMP) AS day,
               EXTRACT(HOUR     FROM CURRENT_TIMESTAMP) AS hour,
               EXTRACT(MINUTE   FROM CURRENT_TIMESTAMP) AS minute,
               EXTRACT(SECOND   FROM CURRENT_TIMESTAMP) AS second
            FROM DAUL;
        -- DB2 : CURRENT와 TIMESTAMP 사이에 공백 & 더미 테이블(SYSIBM.SYSDUMMY1)지정
        SELECT CURRENT TIMESTAMP,
               EXTRACT(YEAR     FROM CURRENT_TIMESTAMP) AS year,
               EXTRACT(MONTH    FROM CURRENT_TIMESTAMP) AS month,
               EXTRACT(DAY      FROM CURRENT_TIMESTAMP) AS day,
               EXTRACT(HOUR     FROM CURRENT_TIMESTAMP) AS hour,
               EXTRACT(MINUTE   FROM CURRENT_TIMESTAMP) AS minute,
               EXTRACT(SECOND   FROM CURRENT_TIMESTAMP) AS second
            FROM SYSIBM.SYSDUMMY1;

--------------------------------------------------------------------------
--------------------------------------------------------------------------

/* 변환 함수 */

-- CAST(변환 전 값 AS 변환할 데이터형) : 형 변환
    /* 형 변환을 하는 이유
        - 데이터형에 맞지 않는 데이터를 테이블에 등록하거나
        - 연산할 때 형이 일치하지 않으면 에러가 발생하거나
        - 암묵적인 형 변환이 일어나서 처리 속도가 저하될 수 있기 때문에
    */
-- 문자형을 숫자형으로 변환
    --SQL Server, PostgreSQL
    SELECT CAST('0001' AS INTEGER) AS int_col;
    -- MySQL
    SELECT CAST('0001' AS SIGNED INTEGER) AS int_col;
    -- Oracle
    SELECT CAST('0001' AS INTEGER) AS int_col
        FROM DAUL;
    -- DB2
    SELECT CAST('0001' AS INTEGER) AS int_col
        FROM SYSIBM.SYSDUMMY1;
-- 문자형을 날짜형으로 변환
    --SQL Server, PostgreSQL
    SELECT CAST('2009-12-14' AS DATE) AS date_col;
    -- My SQL
    SELECT CAST('2009-12-14' AS DATE) AS date_col;
    -- Oracle
    SELECT CAST('2009-12-14' AS DATE) AS date_col
        FROM DAUL;
    -- DB2
    SELECT CAST('2009-12-14' AS DATE) AS date_col
        FROM SYSIBM.SYSDUMMY1;
-- 형 변환은 사용자의 편의보다는 DBMS 내부 처리를 보다 수월하게 하도록 만들어진 기능


-- COALESCE(데이터1, 데이터2, 데이터3, ....) : NULL을 값으로 변환
    -- COALESCE[퀄리스]는 SQL 독자 함수
    -- 복수 개의 인수(인수 수가 정해져있지 않아 기술할 수 있는 수를 자유롭게 바꿀 수 있는 인수)
    --  => 필요한만큼 자유롭게 인수를 늘릴 수 있음
    -- 왼쪽부터 차례대로 인수를 보고 처음으로 NULL이 아닌 값이 나타났을 때 그 값을 반환
    -- SQL 문에서 NULL을 별도의 값으로 변경해서 처리하고 싶은 경우 사용
    --  => 연산이나 함수 안에 NULL이 포함되면 결과가 전부 NULL로 바뀌는 현상을 방지할 때 유용
-- SQL Server, PostgreSQL, MySQL
SELECT COALESCE(NULL, 1)                   AS col_1,
       COALESCE(NULL, 'test', NULL)        AS col_2,
       COALESCE(NULL, NULL, '2009-11-01')  AS col_3;
-- Oracle
SELECT COALESCE(NULL, 1)                   AS col_1,
       COALESCE(NULL, 'test', NULL)        AS col_2,
       COALESCE(NULL, NULL, '2009-11-01')  AS col_3
    FROM DAUL;
-- DB2
SELECT COALESCE(NULL, 1)                   AS col_1,
       COALESCE(NULL, 'test', NULL)        AS col_2,
       COALESCE(NULL, NULL, '2009-11-01')  AS col_3
    FROM SYSIBM.SYSDUMMY1;

-- SampleStr 테이블 열을 사용한 샘플
SELECT COALESCE(str2, 'NULL입니다') FROM SampleStr;

--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------

-- 술어 : 반환값이 진릿값인 함수
    -- SQL에서 추출 조건을 기술할 때 필수 사용
    -- 대표적으로 =, <, >, <> 등의 비교연산자가 해당(비교 술어)
-- 술어는 크게 보면 함수에 해당하나, "반환 값이 TRUE/FALSE/UNKNOWN이어야 한다."

--------------------------------------------------------------------------

-- LIKE : 문자열 '부분 일치' 검색 (전방 일치 / 중간 일치 / 후방 일치)
-- = : 문자열이 완전 일치하는 경우에만 참(TRUE)

/* --------------------- 샘플 테이블(SampleLike) 생성 --------------------- */

-- DDL : 테이블 생성
CREATE TABLE SampleLike
( strcol    VARCHAR(6)  NOT NULL,
  PRIMARY KEY (strcol));

-- DML : 데이터 등록
BEGIN TRANSACTION;

INSERT INTO SampleLike (strcol) VALUES ('abcddd');
INSERT INTO SampleLike (strcol) VALUES ('dddabc');
INSERT INTO SampleLike (strcol) VALUES ('abdddc');
INSERT INTO SampleLike (strcol) VALUES ('abcdd');
INSERT INTO SampleLike (strcol) VALUES ('ddabc');
INSERT INTO SampleLike (strcol) VALUES ('abddc');

COMMIT;

-- 데이터 확인
SELECT * FROM SampleLike;

/* ---------------------------------------------------------------------- */

-- 'ddd' LIKE 검색 => 패턴 매칭
-- 패턴 : 문자열 안에 포함되는 규칙으로써 검색조건이 되는 문자열
    -- 전방 일치 : 검색 조건이 되는 문자열('ddd')이 검색 대상 문자열의 가장 앞에 위치하고 있는 행만 선택
    SELECT *
        FROM SampleLike
       WHERE strcol LIKE 'ddd%'; -- % : '0문자 이상의 임의 문자열'을 의미하는 특수 기호

    -- 중간 일치 : 검색 조건이 되는 문자열('ddd')이 검색 대상 문자열의 "어딘가"에 포함되어 있으면 선택
    --             검색 조건 문자열의 위치는 상관 없음!
    -- 가장 많은 행을 선택할 수 있는, 가장 검색 조건이 느슨한 것!
    SELECT *
        FROM SampleLike
       WHERE strcol LIKE '%ddd%';

    -- 후방 일치 : 검색 조건이 되는 문자열('ddd')이 검색 대상 문자열의 가장 뒤에 위치하고 있는 행만 선택
    SELECT * 
        FROM SampleLike
       WHERE strcol LIKE '%ddd';
    
    -- _(언더바) : 임의의 1문자
    -- strcol가 'abc+임의의 2문자'로 구성된 행 선택
    SELECT *
        FROM SampleLike
       WHERE strcol LIKE 'abc__';
    -- abc로 시작하는 문자열 중에는 'abcddd'도 있으나, 이는 abc+3문자 이므로 제외되었다.

    -- strcol가 'abc+임의의 3문자'로 구성된 행 선택
    SELECT *
        FROM SampleLike
       WHERE strcol LIKE 'abc___';

--------------------------------------------------------------------------

-- BETWEEN : 범위 검색
    -- 인수를 "3개" 사용

-- 판매단가가 100~1000원인 상품 선택
SELECT goods_name, sell_price
    FROM Goods
    WHERE sell_price BETWEEN 100 AND 1000;
-- BETWEEN의 특징 : 양극단의 값(ex. 100과 1000)도 포함한다.

-- 양극단의 값을 제외하고 싶다면 <와 >을 사용한다.
-- 판매단가가 101~999원인 상품 선택(100과 1000제외)
SELECT goods_name, sell_price
    FROM Goods
    WHERE sell_price > 100
    AND sell_price < 1000;

--------------------------------------------------------------------------

-- IS NULL, IS NOT NULL : NULL 또는 비NULL 판정

-- IS NULL : 특정 열이 NULL인 행 선택
-- 매입단가가 NULL인 상품 선택
SELECT goods_name, buy_price
    FROM Goods
    WHERE buy_price IS NULL;

-- IS NOT NULL : NULL이 아닌 행 선택
SELECT goods_name, buy_price
    FROM Goods
    WHERE buy_price IS NOT NULL;

--------------------------------------------------------------------------

-- IN (값, ...) : OR의 간략버전

-- OR로 복수의 매입단가를 지정해서 검색
SELECT goods_name, buy_price
    FROM Goods
    WHERE buy_price = 320
    OR buy_price = 500
    OR buy_price = 5000;
-- 단점 : 선택 대상으로 지정할 값이 늘어날수록 가독성 저하(OR때문에 SQL 작성 길이가 늘어나서)

-- IN으로 복수의 매입단가를 지정해서 검색(매입단가가 320원, 500원, 5000원인 상품)
SELECT goods_name, buy_price
    FROM Goods
    WHERE buy_price IN (320, 500, 5000);

-- 매입단가가 320원, 500원, 5000원이 아닌 상품
-- NOT IN으로 검색 시에 제외할 매입단가를 복수 지정
SELECT goods_name, buy_price
    FROM Goods
    WHERE buy_price NOT IN (320, 500, 5000);

-- IN과 NOT IN은 둘 다 "NULL을 선택할 수 없다"는 것에 주의할 것
    -- NULL은 IS NULL과 IS NOT NULL로만 판별가능


-- IN과 서브쿼리 => IN은 테이블과 뷰를 인수로 지정할 수 있다


/* --------------------- 샘플 테이블(StoreGoods) 생성 --------------------- */
-- 점포상품 테이블

-- DDL : 테이블 생성
CREATE TABLE StoreGoods
(store_id   CHAR(4)      NOT NULL,
 store_name VARCHAR(200) NOT NULL,
 goods_id   CHAR(4)      NOT NULL,
 num        INTEGER      NOT NULL,
 PRIMARY KEY    (store_id, goods_id));  -- 주 키를 2열 지정(테이블에 포함된 특정 행을 중복 없이 지정하기 위해 1열로 부족한 경우)

-- DML : 데이터 등록
BEGIN TRANSACTION;

INSERT INTO StoreGoods (store_id, store_name, goods_id, num) VALUES ('000A', '서울', '0001', 30);
INSERT INTO StoreGoods (store_id, store_name, goods_id, num) VALUES ('000A', '서울', '0002', 50);
INSERT INTO StoreGoods (store_id, store_name, goods_id, num) VALUES ('000A', '서울', '0003', 15);
INSERT INTO StoreGoods (store_id, store_name, goods_id, num) VALUES ('000B', '대전', '0002', 30);
INSERT INTO StoreGoods (store_id, store_name, goods_id, num) VALUES ('000B', '대전', '0003', 120);
INSERT INTO StoreGoods (store_id, store_name, goods_id, num) VALUES ('000B', '대전', '0004', 20);
INSERT INTO StoreGoods (store_id, store_name, goods_id, num) VALUES ('000B', '대전', '0006', 10);
INSERT INTO StoreGoods (store_id, store_name, goods_id, num) VALUES ('000B', '대전', '0007', 40);
INSERT INTO StoreGoods (store_id, store_name, goods_id, num) VALUES ('000C', '부산', '0003', 20);
INSERT INTO StoreGoods (store_id, store_name, goods_id, num) VALUES ('000C', '부산', '0004', 50);
INSERT INTO StoreGoods (store_id, store_name, goods_id, num) VALUES ('000C', '부산', '0006', 90);
INSERT INTO StoreGoods (store_id, store_name, goods_id, num) VALUES ('000C', '부산', '0007', 70);
INSERT INTO StoreGoods (store_id, store_name, goods_id, num) VALUES ('000D', '대구', '0001', 100);

COMMIT; -- 트랜잭션 중간에 에러발생 시, 커밋을 명령해도 자동 롤백(에러로 인해 중단되었으므로)됨
/* ----------------------------------------------------------------------- */

-- 부산점(000C)에 있는 어떤 상품(goods_id)의 상품명(goods_name)와 판매단가(sell_price)
    -- 1) StoreGoods에서 부산점에 어떤 상품이 있는지 검색
    SELECT goods_id FROM StoreGoods WHERE store_id = '000C';   -- store_name = '부산'을 써도 같지만, ID보다 변경확률이 높으므로 권장X
    -- 2) 1에서 검색한 상품ID로 Goods 테이블에서 상품명과 판매단가 검색
    -- IN 인수에 서브쿼리 사용
    SELECT goods_name, sell_price
        FROM Goods
        WHERE goods_id IN (SELECT goods_id
                            FROM StoreGoods 
                            WHERE store_id = '000C');
    -- 유지보수성이 우수한 SQL문(정비 작업 프리) : 반복작업을 대폭 줄이기 때문

-- NOT IN과 서브쿼리
SELECT goods_name, sell_price
    FROM Goods
    WHERE goods_id NOT IN (SELECT goods_id
                            FROM StoreGoods
                            WHERE store_id = '000A');

--------------------------------------------------------------------------

-- EXISTS
/* 특징
    1) EXISTS는 지금까지 배운 술어들과 사용법이 다름
    2) 구문을 작관적으로 이해하기 어려움
    3) EXISTS를 사용하지 않더라도 IN(또는 NOT IN)을 통해 거의 동일한 결과를 얻을 수 있음(완벽히 "동일"하지는 않음)

    ==> 위와 같은 이유로 중급 레벨이 되면 마스터하기를 권장
*/

-- EXISTS 사용법
    -- 역할 : 어떤 조건에 일치하는 행이 존재하는지 여부를 조사한다.
    -- 조건에 일치하는 행이 존재하면 참(TRUE)
    -- 조건에 일치하는 행이 없다면 거짓(FALSE)를 반환

-- 부산점(000C)에 있는 상품(goods_id)의 상품명(goods_name)과 판매단가(sell_price)
SELECT goods_name, sell_price
    FROM Goods AS S
    WHERE EXISTS (SELECT *
                    FROM StoreGoods AS TS
                    WHERE TS.store_id = '000C'
                    AND TS.goods_id = S.goods_id);
    -- '점포 ID가 000C이고, 상품ID가 상품(Goods) 테이블과 점포상품(StoreGoods)에서 일치'하는 행이 존재하는지 여부만 조사

--EXISTS의 인수 : 오른쪽에 하나의 인수(=상관 서브쿼리)만 지정.
    -- EXISTS는 "항상 상관 서브쿼리"를 인수로 가진다.

-- 서브쿼리 안의 'SELECT *' : EXISTS는 행의 존재유무만을 확인하므로 어떤 열이 반환되든 상관무 =>> 기본적으로 'SELECT *' 로 작성한다.
-- 위의 예제와 동일한 결과를 도출하는 SELECT ~ EXISTS문
SELECT goods_name, sell_price
    FROM Goods AS S
    WHERE EXISTS (SELECT 1
                    FROM StoreGoods AS TS
                    WHERE TS.store_id = '000C'
                    AND TS.goods_id = S.goods_id);

-- NOT IN을 NOT EXISTS로
-- 서울점(000A)에 있는 상품(goods_id)이외의 상품명(goods_name)과 판매단가(sell_price)
SELECT goods_name, sell_price
    FROM Goods AS S
    WHERE NOT EXISTS (SELECT *
                        FROM StoreGoods AS TS
                        WHERE TS.store_id = '000A'
                        AND TS.goods_id = S.goods_id);

--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------

-- CASE 식 (단순 CASE 식과 검색 CASE 식) ===> 조건 분기(IF문이나 CASE문의 SQL 버전)
-- SQL 기능 중 가장 중요!

-- '경우 구분'을 기술할 때 사용한다. => CASE = 경우


-- CASE 식 구문
-- "단순 CASE"식과 "검색 CASE"식
-- 검색 CASE : 단순 CASE식을 모두 포함

-- 검색 CASE
CASE WHEN <평가식> THEN <식>
     WHEN <평가식> THEN <식>
     WHEN <평가식> THEN <식>
     ...
     ELSE <식>
END

-- WHEN 구의 <평가식> :  반환 값이 '진릿값(TRUE/FALSE/UNKNOWN)'인 식
    -- 이를 테면, 술어를 사용해 만든 식 (ex : =, !=, LIKE, BETWEEN 등)
-- 평가 : 해당 식의 진릿값을 조사하는 처리
/*    - 참일 때 = THEN 구에 지정한 식 반환 후, CASE 식 종료
      - 참이 아닐 때 = 다음 WHEN 구 평가
        => 마지막 WHEN 구까지 반복해도 참이 되지 않을 때는 ELSE에서 지정한 식 반환 후, CASE 식 종료
*/

-- CASE는 전체가 하나의 식을 구성하고, 최종적으로 하나의 값을 반환하므로 '식'으로 표현된다.
-- CASE 식을 사용해서 상품분류에 A~C 문자열 할당
SELECT goods_name,
       CASE WHEN goods_classify = '의류'
            THEN 'A:' || goods_classify
            WHEN goods_classify = '사무용품'
            THEN 'B:' || goods_classify
            WHEN goods_classify = '주방용품'
            THEN 'C:' || goods_classify
            ELSE NULL
        END AS abc_goods_classify
    FROM Goods;

-- ELSE 구는 생략이 가능(이 경우 ELSE NULL로 간주)하나, 명시적으로 ELSE를 기술한다.(가독성의 편의를 위해)
-- END는 생략이 불가능하다. (생략 시, 구문 에러)

-- CASE는 식이므로, 식을 사용할 수 있는 곳이라면 어디든 쓸 수 있다.
-- 상품분류별로 판매단가를 합한 결과(GROUP BY) : 결과 값이 '행'으로 출력(열로 정렬해서 출력할 수 없음)
SELECT goods_classify,
       SUM(sell_price) AS sum_tanka
    FROm Goods
    GROUP BY goods_classify;
-- 상품분류별 판매단가의 합(CASE식을 통한 행렬 반환) : 결과 값을 열로 출력
SELECT SUM(CASE WHEN goods_classify = '의류'
                THEN sell_price ELSE 0 END) AS sum_price_cloth,
       SUM(CASE WHEN goods_classify = '주방용품'
                THEN sell_price ELSE 0 END) AS sum_price_kitchen,
       SUM(CASE WHEN goods_classify = '사무용품'
                THEN sell_price ELSE 0 END) AS sum_price_office
    FROM Goods;

-- CASE 식은 SELECT 문의 결과를 유연하게 재조합해야 할 경우에 유용

-- 단순 CASE 식 : 검색 CASE식에 비해 작성법이 간단하나, 기술할 수 있는 조건이 제한적
CASE <식>               -- 처음 CASE 식에서 평가 대상이 되는 식을 정하는 점이 검색 CAST와의 차이
    WHEN <식> THEN <식>
    WHEN <식> THEN <식>
    WHEN <식> THEN <식>
    ...
    ELSE <식.
END

-- 상품분류에 A~C문자열 할당하기
-- 검색 CASE 사용
SELECT goods_name,
       CASE WHEN goods_classify = '의류'
            THEN 'A:' || goods_classify
            WHEN goods_classify = '사무용품'
            THEN 'B:' || goods_classify
            WHEN goods_classify = '주방용품'
            THEN 'C:' || goods_classify
            ELSE NULL
        END
    FROM Goods;
-- 단순 CASE 사용
SELECT goods_name,
       CASE goods_classify
            WHEN '의류'     THEN 'A:' || goods_classify
            WHEN '사무용품' THEN 'B:' || goods_classify
            WHEN '주방용품' THEN 'C:' || goods_classify
            ELSE NULL
        END
    FROM Goods;
    -- WHEN 구에서 한 번 더 기준 식을 기술할 필요가 없는 대신, WHEN 구별로 다른 열에 대한 조건을 지정하고 싶은 경우는 구현 불가

-- 독자적인 CASE식 개별 구문 : 특정 DBMS에만 쓸 수 있고, 기술 조건도 CASE 식보다 제한되어 있으므로 큰 이점X
-- Oracle : DECODE를 사용한 CASE 식
SELECT goods_name,
       DECODE(goods_classify,
                '의류',     'A:' || goods_classify,
                '사무용품'  'B:' || goods_classify,
                '주방용품'  'C:' || goods_classify,
                NULL) AS abc_goods_classify
    FROM Goods;
-- MySQL : IF로 CASE 식 구현
SELECT goods_name,
       IF( IF( IF(goods_classify = '의류',
                  CONCAT('A:' || goods_classify), NULL)
               IS NULL AND goods_classify = '사무용품',
                  CONCAT('B:' || goods_classify),
           IF(goods_classify = '의류',
              CONCAT('A:' || goods_classify, NULL))
                IS NULL AND goods_classify = '주방용품',
                   CONCAT('C:' || goods_classify),
                IF( IF(goods_classify = '의류',
                       CONCAT('A:' || goods_classify), NULL)
              IS NULL AND goods_classify = '사무용품',
                 CONCAT('B:' || goods_classify),
          IF(goods_classify = '의류',
             CONCAT('A:' || goods_classify),
        NULL))) AS abc_goods_classify
    FROM Goods;
                
-- CASE 식은 표준SQL이 인정하고 있는 기능이므로 어느 DBMS에서나 사용가능 => 되도록 CASE를 사용하자
