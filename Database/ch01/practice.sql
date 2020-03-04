-- 1. 주소록 테이블 작성
CREATE TABLE Address_book
(
    register_no     INTEGER         NOT NULL,
    name            VARCHAR(128)    NOT NULL,
    address         VARCHAR(256)    NOT NULL,
    tel_no          CHAR(10)        ,
    mail_address    CHAR(20)        ,
    PRIMARY KEY (register_no)
);

-- 2. post_code (우편번호) 칼럼 추가
ALTER TABLE Address_book ADD COLUMN post_code CHAR(8) NOT NULL;

-- 3. Address_book 테이블 삭제
DROP TABLE Address_book;

-- 4. 삭제한 Address_book 테이블 재작성 => 1번 답에 post_code를 추가해서 다시 실행
CREATE TABLE Address_book
(
    register_no     INTEGER         NOT NULL,
    name            VARCHAR(128)    NOT NULL,
    address         VARCHAR(256)    NOT NULL,
    tel_no          CHAR(10)        ,
    mail_address    CHAR(20)        ,
    post_code       CHAR(8)         NOT NULL,
    PRIMARY KEY (register_no)
);