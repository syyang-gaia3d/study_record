
-- 1. Goods 테이블에 대해 다음 두 가지 SELECT 문을 실행한다. 각 SQL 문 결과?
    -- (1)
    SELECT goods_name, buy_price
        FROM Goods
        WHERE buy_price NOT IN (500, 2800, 5000);
    -- (2)
    SELECT goods_name, buy_price
        FROM Goods
        WHERE buy_price NOT IN (500, 2800, 5000, NULL);
/* 답안 */
-- (1)의 경우, 구입단가가 500원, 2800원 5000원인 상품을 제외한 >>펀칭기, 도마<<가 선택된다.
-- (2)의 경우, 아무것도 선택되지 않는다.

/* 해설 */
-- NOT IN에 어떤 경우라도 NULL이 "절대로" 들어가선 안 된다.(IN은 상관없이 NULL값은 제외되고 도출됨..)
-- NULL이 인수로 들어가는 순간, 어떤 값도 반환하지 않게 되어버린다.(도출과정은 복잡하므로 생략)
-- 서브쿼리의 반환값으로든, 직접 입력이든 어떤 경우에라도 NOT IN에 NULL이 입력되지 않도록 반드시 주의해야 함을 기억하자.


-- 2. Goods 테이블에 있는 상품을 판매단가(sell_price)에 따라 분류한다.
    -- 저가 상품(low_price) : 판매단가가 1000원 이하(티셔츠, 펀칭기, 포크, 도마, 볼펜)
    -- 중가 상품(mid_price) : 판매단가가 1001원 이상 3000원 이하(식칼)
    -- 고가 상품(high_price) : 판매단가가 3001원 이상(와이셔츠, 압력솥)
-- 이들 상품분류에 포함되는 상품 수를 구하는 SELECT문?

/* 답안 */
SELECT COUNT(CASE WHEN sell_price <= 1000
                  THEN goods_id ELSE NULL END) AS low_price,
       COUNT(CASE WHEN sell_price BETWEEN 1001 AND 3000
                  THEN goods_id ELSE NULL END) AS mid_price,
       COUNT(CASE WHEN sell_price >= 3001
                  THEN goods_id ELSE NULL END) AS high_price
    FROM Goods;
/* 해설 */
SELECT SUM(CASE WHEN sell_price <= 1000
                THEN 1 ELSE 0 END) AS low_price,
       SUM(CASE WHEN sell_price BETWEEN 1001 AND 3000
                THEN 1 ELSE 0 END) AS mid_price,
       SUM(CASE WHEN sell_price >= 3001
                THEN 1 ELSE 0 END) AS high_price
    FROM Goods;