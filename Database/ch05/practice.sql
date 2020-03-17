
-- 1. 아래 세가지 조건을 만족하는 뷰를 만들기(뷰 이름 : ViewExer5_1)
--      원 테이블은 Goods(상품) 테이블 하나로, 데이터 초기 상태는 8행 모두 들어 있다고 가정.
/* 조건
    1) 판매단가가 1000원 이상일 것
    2) 등록일이 2009년 9월 20일일 것
    3) 포함하는 열은 상품명, 판매단가, 등록일일 것
*/
-- 이 뷰를 가지고 SELECT문을 실행하면 티셔츠, 식칼만 떠야 한다.
/* 뷰 확인용 SELECT 문 */ SELECT * FROM ViewExer5_1;

/* 답안 */
CREATE VIEW ViewExer5_1 AS
SELECT goods_name, sell_price, register_date
    FROM Goods
    WHERE sell_price >= 1000
    AND register_date = '2009-09-20';


-- 2. ViewExer5_1 뷰에 다음과 같은 데이터를 등록하려 한다. 결과는?
    INSERT INTO ViewExer5_1 VALUES ('나이프', 300, '2009-11-02');

/* 답안 */
-- 에러처리. 원 테이블의 제약들로 인해 데이터 등록이 되지 않는다.
/* 해설
    뷰를 통한 갱신은 다시 말해, 뷰를 통해 원 테이블을 갱신하는 처리다.
    때문에 뷰에 대한 INSERT 문은 곧 테이블에 대한 INSERT 문으로도 고칠 수 있는데,
    이 때 뷰에서 정해진 것 외에 값으로는 NULL이 입력된다.
    주 키 제약이 걸린 goods_id 열과 NOT NULL 제약이 걸린 goods_name, goods_classify 열에는 NULL이 들어갈 수 없다.

    현재 뷰를 통해 갱신 가능한 열은 goods_name, sell_price, register_date 3열 뿐이므로
    나머지는 자동으로 NULL이 들어가고 여기서 에러가 발생한다.
*/

-- 3. 상품 전체 평균 판매단가(sell_price_all) 열을 포함한 결과 행 도출을 위한 SELECT문?

/* 답안 */
SELECT goods_id,
       goods_name, 
       goods_classify, 
       sell_price,
       (SELECT AVG(sell_price) FROM Goods) AS sell_price_all -- 스칼라 서브쿼리
    FROM Goods;

-- 4. 뷰 AvgPriceByClassify를 생성하는 SQL문 작성.
/* 조건
    1) 포함하는 열은 상품ID, 상품명, 상품분류, 판매단가, 상품분류별 평균단가
    2) 원 테이블은 Goods, 데이터 초기 상태는 8행 모두 있다고 가정
*/

/* 답안 */
CREATE VIEW AvgPriceByClassify AS
SELECT goods_id,
       goods_name,
       goods_classify,
       sell_price, 
       (SELECT AVG(sell_price)
            FROM Goods AS S2
           WHERE S1.goods_classify = S2.goods_classify) AS avg_sell_price
    FROM Goods AS S1;

/* 해석 */
CREATE VIEW AvgPriceByClassify AS
SELECT goods_id,
       goods_name,
       goods_classify,
       sell_price, 
       (SELECT AVG(sell_price)
            FROM Goods AS S2
           WHERE S1.goods_classify = S2.goods_classify
           GROUP BY S1.goods_classify) AS avg_sell_price -- 정답은 GROUP BY가 추가되어 있는데, 없어도 결과값은 같다... 왜?
    FROM Goods AS S1;
-- 뷰 삭제
DROP VIEW AvgPriceByClassify;