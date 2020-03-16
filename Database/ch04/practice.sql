-- 1. A씨가 자신의 컴퓨터에서 CREATE TABLE로 생성한 빈 테이블 Goods에 대해 아래의 SQL을 실행했다.
BEGIN TRANSACTION;
    INSERT INTO Goods VALUES ('0001','티셔츠', '의류', 1000, 500, '2009-09-20');
    INSERT INTO Goods VALUES ('0002','펀칭기', '사무용품', 500, 320, '2009-09-11');
    INSERT INTO Goods VALUES ('0003','와이셔츠', '의류', 4000, 2800, NULL);
-- 바로 직후에 B씨가 다른 컴퓨터로부터 동일한 데이터베이스에 접속해서 다음 SELECT문을 실행했다.
SELECT * FROM Goods;
-- 이때 B씨는 어떤 결과를 보는가?
/* 정답 */
-- 0행 즉, 어떤 행도 선택되지 않는다.
-- (이유 : 트랜잭션을 종료하는 COMMIT이나 ROLLBACK 명령어가 실행되지 않았기 때문)

/* 참고! - 데이터를 입력하고 있는 A씨는 COMMiT하기 전에도 SELECT문을 실행하면 자신이 INSERT한 3행을 확인할 수 있으나,
           B씨는 A씨가 COMMIT하기 전까지 SELECT 문으로 데이터를 확인할 수 없다. (ACID 특성의 독립성(I)에 기반)
*/

-- 2. 위의 3행이 포함된 Goods 테이블에서 3행을 그대로 복사해서 6행으로 늘리려고 생각하고 다음 INSERT 문을 실행했다.
INSERT INTO Goods SELECT * FROM Goods;
-- 결과는?
/* 정답 */
-- 상품ID의 주 키 제약에 위반되므로 에러가 발생한다. (주 키 제약이 있는 열에는 동일한 데이터가 들어갈 수 없다.)
-- (ACID 특성의 일관성(C) 위반)
