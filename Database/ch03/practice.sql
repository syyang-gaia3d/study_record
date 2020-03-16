-- 1. SELECT 문의 문법 오류 모두 찾기
SELECT goods_id, SUM(goods_name)
    -- 이 SELECT문은 틀렸다.
    FROM Goods
    GROUP BY goods_classify
    WHERE register_date > '2009-09-01';

/* 정답 */
-- 1. 집약 함수 SUM의 인수는 숫자형만 가능한데, goods_name은 데이터형이 문자형이다.
-- 2. GROUP BY 구에 쓰이는 집약 키만 SELECT 구에 쓰일 수 있다.
-- 3. GROUP BY 구는 WHERE 구 다음에 쓰여야 한다.

-- 2. 판매단가(sell_price) 합계가 매입단가(buy_price) 합계보다 1.5배 이상 큰 상품분류를 구하는 SELECT문
SELECT goods_classify, SUM(sell_price), SUM(buy_price)
    FROM Goods
    GROUP BY goods_classify
    HAVING SUM(sell_price) >= (1.5 * SUM(buy_price));

-- 3. Goods(상품) 테이블에서 모든 레코드를 선택하는 SELECT 문을 사용해 결과를 취득했다.
--    당시 ORDER BY 구를 사용해서 순서를 지정했지만, 어떤 규칙으로 지정했는지 잊어버렸다.
--    실행 결과를 참고로 어떤 ORDER BY 구가 적용됐는지 생각해보자.
SELECT goods_id, goods_name, goods_classify, sell_price, buy_price, register_date
    FROM Goods
    ORDER BY register_date DESC;
-- 위의 SQL을 시행하면 같은 실행 결과가 나옴

/* 정답 */
-- 등록일(register_date)를 최신순(내림차순)으로 순서를 지정하였다.
-- (50%만 정답!!!!!)

/* 답안 해설 */
SELECT goods_id, goods_name, goods_classify, sell_price, buy_price, register_date
    FROM Goods
    ORDER BY register_date DESC, sell_price;
-- 2009-09-20에 해당하는 행이 3개인데, 이 3행에 대해 규칙성을 살펴보면
-- sell_price가 작은 순(오름차순)으로 정렬되어 있음을 알 수 있음.