/**********************************/
/* Table Name: 관리자 */
-- 개인 프로젝트에서는 개발자가 유일한 관리자로 처리됨.
/**********************************/
DROP TABLE manager CASCADE CONSTRAINTS; -- 자식 무시하고 삭제 가능
DROP TABLE manager;

CREATE TABLE manager(
    managerNO    NUMBER(5)    NOT NULL,
    ID         VARCHAR(20)   NOT NULL UNIQUE, -- 아이디, 중복 안됨, 레코드를 구분 
    pw     VARCHAR(15)   NOT NULL, -- 패스워드, 영숫자 조합
    MNAME      VARCHAR(20)   NOT NULL, -- 성명, 한글 10자 저장 가능
    MDATE      DATE          NOT NULL, -- 가입일    
    GRADE      NUMBER(2)     NOT NULL, -- 등급(1~10: 관리자, 정지 관리자: 20, 탈퇴 관리자: 99)    
    PRIMARY KEY (managerNO)              -- 한번 등록된 값은 중복 안됨
);

COMMENT ON TABLE manager is '관리자';
COMMENT ON COLUMN manager.managerNO is '관리자 번호';
COMMENT ON COLUMN manager.ID is '아이디';
COMMENT ON COLUMN manager.pw is '패스워드';
COMMENT ON COLUMN manager.MNAME is '성명';
COMMENT ON COLUMN manager.MDATE is '가입일';
COMMENT ON COLUMN manager.GRADE is '등급';

DROP SEQUENCE manager_SEQ;

CREATE SEQUENCE manager_SEQ
  START WITH 1              -- 시작 번호
  INCREMENT BY 1            -- 증가값
  MAXVALUE 99999            -- 최대값: 99999 --> NUMBER(5) 대응
  CACHE 2                   -- 2번은 메모리에서만 계산
  NOCYCLE;                  -- 다시 1부터 생성되는 것을 방지

-- CREATE
INSERT INTO manager(managerno, id, pw, mname, mdate, grade)
VALUES(manager_seq.nextval, 'manager', '1234', '관리자1', sysdate, 1);

commit;

-- READ: List
SELECT managerno, id, pw, mname, mdate, grade FROM manager ORDER BY managerno ASC;

-- READ         
SELECT managerno, id, pw, mname, mdate, grade 
FROM manager
WHERE managerno=1;

-- READ by id
SELECT managerno, id, pw, mname, mdate, grade 
FROM manager
WHERE id='dduddu';

-- UPDATE
UPDATE manager
SET pw='3210', mname='관리자1', mdate=sysdate, grade=1
WHERE managerNO=1;

COMMIT;

-- DELETE
DELETE FROM manager WHERE managerno=3;
         
-- 로그인, 1: 로그인 성공, 0: 로그인 실패
SELECT COUNT(*) as cnt
FROM manager
WHERE id='dduddu' AND pw='3210'; 
