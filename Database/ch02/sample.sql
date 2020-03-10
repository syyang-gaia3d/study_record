
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

-- 산술연산자 : 연산은 행 단위로 이루어짐
SELECT goods_name, sell_price,
       sell_price * 2 AS "sell_price_x2"
    FROM Goods;
-- 단, NULL을 포함한 계산은 무조건 NULL이 된다.(NULL/0 도 NULL이다.)

-- SELECT 구만으로 이뤄진 SELECT문 : 실무에서 가끔씩 FROM 없이 SELECT문을 쓰는 경우가 있다.
-- 단, Oracle, DB2의 경우는 FROM구가 없는 SELECT문을 허락하지 않는다.
-- (Oracle : 필요 시 DUAL이란 더미 테이블 지정 / DB2 : SYSIBM< SYSDUMMY1 테이블 지정)
SELECT (100+200) * 3 AS calculation;

-- 비교연산자(= : 같다 / <> : 같지 않다(표준SQL) => !=을 쓰는 RDBMS도 존재)
SELECT goods_name, goods_classify
    FROM Goods
   WHERE sell_price = 500;

SELECT goods_name, goods_classify
    FROM Goods
   WHERE sell_price <> 500;

SELECT goods_name, goods_classify, sell_price
    FROM Goods
   WHERE sell_price >= 1000;
-- 이상(>=), 이하(<=) 표현은 반드시 부등호가 앞, 등호가 뒤

SELECT goods_name, goods_classify, register_date
    FROM Goods
   WHERE register_date < '2009-09-27';

-- WHERE 구 조건식에서 계산식 사용
SELECT goods_name, sell_price, buy_price
    FROM Goods
   WHERE sell_price - buy_price >= 500;

-- 문자열에 부등호를 사용할 때 주의사항
-- -> 사전식 순서(같은 문자로 시작하는 단어들은 다른 문자로 시작하는 단어들보다 가까운 관계)
/* -----------------------------------
    -- DDL : 샘플테이블(Chars) 생성
    CREATE TABLE Chars
        (chr CHAR(3) NOT NULL,
        PRIMARY KEY (chr));
    -- DML : 데이터 등록
    BEGIN TRANSACTION;
    INSERT INTO Chars VALUES ('1');
    INSERT INTO Chars VALUES ('2');
    INSERT INTO Chars VALUES ('3');
    INSERT INTO Chars VALUES ('10');
    INSERT INTO Chars VALUES ('11');
    INSERT INTO Chars VALUES ('222');

    COMMIT;
*/ -----------------------------------
SELECT chr
    FROM Chars
   WHERE chr > '2';

/* 
<<SELECT 문 수행 결과>>
 chr
-----
 3
 222
(2개 행)
*/

-- NULL에 비교 연산자를 사용할 수 없다. (NULL행은 판별할 수 없어 제외됨)
SELECT goods_name, buy_price
    FROM Goods
   WHERE buy_price = 2800;

SELECT goods_name, buy_price
    FROM Goods
   WHERE buy_price <> 2800;

-- NULL행을 선택하려면?
/*
SELECT goods_name, buy_price
    FROM Goods
   WHERE buy_price = NULL; -- 비문이다.(결과 0행)
*/
SELECT goods_name, buy_price
    FROM Goods
   WHERE buy_price IS NULL;

-- NULL 아닌 행 선택
SELECT goods_name, buy_price
    FROM Goods
   WHERE buy_price IS NOT NULL;

-- 논리 연산자
    -- 판매단가(sell_price)가 1000원 이상인 행
SELECT goods_name, goods_classify, sell_price
    FROM Goods
   WHERE sell_price >= 1000;
-- NOT 연산자 추가
SELECT goods_name, goods_classify, sell_price
    FROM Goods
   WHERE NOT sell_price >= 1000; -- == sell_price < 1000

-- AND, OR 연산자
SELECT goods_name, goods_classify, sell_price
    FROM Goods
   WHERE goods_classify = '주방용품'
     AND sell_price >= 3000;

SELECT goods_name, goods_classify, sell_price
    FROM Goods
   WHERE goods_classify = '주방용품'
      OR sell_price >= 3000;

-- 괄호를 이용한 비교 연산자

/*  
     '상품분류가 사무용품' 
    그리고 
     '등록일이 2009년 9월 11일 또는 2009년 9월 20일'
     인 행만 검색하기
*/

-- 비문 (이유 : AND 연산자가 OR 연산자보다 우선순위가 높기 때문)
SELECT goods_name, goods_classify, register_date
    FROM Goods
   WHERE goods_classify = '사무용품'
     AND register_date = '2009-09-11'
      OR register_date = '2009-09-20';
/* 
    위 SELECT문은 
     '상품분류가 사무용품이다. 그리고 등록일이 2009년 9월 11일이다.' 
    또는 
     '등록일이 2009년 9월 20일이다.'
    에 해당하는 행이 모두 검색된다. 
*/

-- 정답
SELECT goods_name, goods_classify, register_date
    FROM Goods
   WHERE goods_classify = '사무용품'
     AND (   register_date = '2009-09-11'
          OR register_date = '2009-09-20');

-- NULL을 포함하는 진릿값 => UNKNOWN
    -- AND에 불명(UNKNOWN) 진릿값이 있을 경우, 다른 조건이 거짓인 경우를 제외하고 불명 처리(거짓과 불명의 경우는 거짓으로 처리됨)
    -- OR에 불명(UNKNOWN) 진릿값이 있을 경우, 다른 조건이 참인 경우를 제외하고 불명 처리(참과 불명의 경우는 참으로 처리됨)
