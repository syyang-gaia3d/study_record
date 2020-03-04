--- 데이터베이스를 작성하는 CREATE DATABASE 문(기본형)
--  실제 데이터베이스 개발에서는 데이터베이스명 외에 다양한 항목들을 설정함.
CREATE DATABASE shop;

-- 테이블을 작성하는 CREATE TABLE 문
CREATE TABLE Goods
(goods_id           CHAR(4)         NOT NULL,
 goods_name         VARCHAR(100)    NOT NULL,
 goods_classify     VARCHAR(32)     NOT NULL,
 sell_price         INTEGER         ,
 buy_price          INTEGER         ,
 register_date      DATE            ,
 PRIMARY KEY (goods_id));

-- 테이블을 삭제하는 DROP TABLE 문
DROP TABLE Goods;

-- 테이블 정의를 변경할 수 있는 ALTER TABLE 문
-- 열을 추가할 때
ALTER TABLE Goods ADD COLUMN goods_name_eng VARCHAR(100);
-- 열을 삭제할 때
ALTER TABLE Goods DROP COLUMN goods_name_eng;

-- 데이터 등록
BEGIN TRANSACTION;

INSERT INTO Goods VALUES ('0001', '티셔츠',     '의류',         1000,   500,    '2009-09-20');
INSERT INTO Goods VALUES ('0002', '펀칭기',     '사무용품',      500,   320,    '2009-09-11');
INSERT INTO Goods VALUES ('0003', '와이셔츠',   '의류',         4000,  2800,    NULL);
INSERT INTO Goods VALUES ('0004', '식칼',       '주방용품',     3000,  2800,    '2009-09-20');
INSERT INTO Goods VALUES ('0005', '압력솥',     '주방용품',     6800,  5000,    '2009-01-15');
INSERT INTO Goods VALUES ('0006', '포크',       '주방용품',      500,  NULL,    '2009-09-20');
INSERT INTO Goods VALUES ('0007', '도마',       '주방용품',      880,   790,    '2008-04-28');
INSERT INTO Goods VALUES ('0008', '볼펜',       '사무용품',      100,  NULL,    '2009-11-11');

COMMIT;

-- 테이블명 수정 => RENAME
ALTER TABLE Gods RENAME TO Goods;