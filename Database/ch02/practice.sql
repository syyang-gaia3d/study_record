-- 1. 상품(Goods) 테이블에서 '등록일(register_date)이 2009년 4월 28일 이후'인 상품의 이름(goods_name)과 등록일
SELECT goods_name, register_date
    FROM Goods
   WHERE register_date >= '2009-04-28';

-- 2. Goods 테이블에 대해 실행한 3가지 SELECT문에 대한 결과
SELECT *
    FROM Goods
   WHERE buy_price = NULL;
/*
    비문이기때문에 결과값이 없다.(결과 행이 0이다.) 
    NULL 값을 가진 행을 출력하려면 IS NULL을 사용해야 한다.
*/

SELECT *
    FROM Goods
   WHERE buy_price <> NULL;

/*
    마찬가지로 비문이므로 결과값이 없다.
    NULL 값을 가지지 않은 행을 출력하려면 IS NOT NULL을 사용해야 한다.
*/

SELECT *
    FROM Goods
   WHERE goods_name > NULL;

/*
    비문이므로 결과값이 없다.
    NULL은 비교 연산자를 사용할 수 없다.
*/

-- 3. Goods 테이블에서 '판매단가(sell_price)가 매입단가(buy_price)보다 500원 이상 높은'상품을 선택하는 SELECT문
    --(1)번
SELECT goods_name, sell_price, buy_price
    FROM Goods
   WHERE sell_price - buy_price >= 500;
    --(2)번
SELECT goods_name, sell_price, buy_price
    FROM Goods 
   WHERE NOT sell_price - buy_price < 500;

-- 4. Goods 테이블에서 '판매단가를 10% 빼도 이익이 100원보다 높은 주방용품과 사무용품'을 선택한다.
-- 출력열은 goods_name, goods_classify, 판매단가를 10% 뺀 경우 이익(profit이란 별명)이다.
SELECT goods_name, goods_classify, sell_price - (sell_price * 0.9) AS profit
    FROM Goods
   WHERE sell_price - (sell_price * 0.9) > 100
     AND (   goods_classify = '주방용품'
          OR goods_classify = '사무용품');