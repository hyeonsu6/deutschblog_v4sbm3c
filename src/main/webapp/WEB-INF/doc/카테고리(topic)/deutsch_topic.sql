/**********************************/
/* Table Name: 독일어 주제 */
/**********************************/
DROP TABLE topic CASCADE CONSTRAINTS; -- 자식 무시하고 삭제 가능
drop TABLE topic

CREATE TABLE topic(
		topicno                       		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		name                          		VARCHAR2(100)		 NOT NULL,
		cnt                           		NUMBER(10)		 NOT NULL,
		rdate                         		DATE		 NOT NULL,
        seqno                               NUMBER(5)        DEFAULT 1 NOT NULL,
        VISIBLE                             CHAR(1)          DEFAULT 'N' NOT NULL        
);

COMMENT ON TABLE topic is '독일어 주제';
COMMENT ON COLUMN topic.topicno is '주제 번호';
COMMENT ON COLUMN topic.name is '주제 이름';
COMMENT ON COLUMN topic.cnt is '관련 자료 수';
COMMENT ON COLUMN topic.rdate is '등록일';
COMMENT ON COLUMN topic.seqno is '출력 순서';
COMMENT ON COLUMN topic.VISIBLE is '출력 모드';

DROP SEQUENCE topic_SEQ;

CREATE SEQUENCE topic_SEQ
  START WITH 1         -- 시작 번호
  INCREMENT BY 1       -- 증가값
  MAXVALUE 9999999999  -- 최대값: 9999999999 --> NUMBER(10) 대응
  CACHE 2              -- 2번은 메모리에서만 계산
  NOCYCLE;             -- 다시 1부터 생성되는 것을 방지
  
  
-- CREATE
INSERT INTO topic(topicno, name, cnt, gdate) VALUES(topic_seq.nextval, '1일 1표현', 0, sysdate); 

-- READ: LIST
SELECT * FROM topic;
SELECT topicno, name, cnt, gdate FROM topic ORDER BY topicno ASC;

-- READ
SELECT topicno, name, cnt, gdate FROM topic WHERE topicno=1;
   
-- UPDATE
UPDATE topic SET name='공부 기록', cnt=0 WHERE topicno=2;

-- DELETE
DELETE FROM topic WHERE topicno=1;
DELETE FROM topic WHERE topicno >= 10;

COMMIT;

-- COUNT
SELECT COUNT(*) as cnt FROM topic;


-- 우선 순위 높임, 10 등 -> 1 등
UPDATE topic SET seqno = seqno - 1 WHERE topicno=1;
SELECT topicno, name, cnt, gdate, seqno FROM topic ORDER BY topicno ASC;

-- 우선 순위 낮춤, 1 등 -> 10 등
UPDATE topic SET seqno = seqno + 1 WHERE topicno=1;
SELECT topicno, name, cnt, gdate, seqno FROM topic ORDER BY topicno ASC;

-- READ: LIST
SELECT topicno, name, cnt, gdate, seqno FROM topic ORDER BY seqno ASC;

COMMIT;

-- 카테고리 공개 설정
UPDATE topic SET visible='Y' WHERE topicno=1;
SELECT topicno, name, cnt, gdate, seqno, visible FROM topic ORDER BY topicno ASC;

-- 카테고리 비공개 설정
UPDATE topic SET visible='N' WHERE topicno=1;
SELECT topicno, name, cnt, gdate, seqno, visible FROM topic ORDER BY topicno ASC;

COMMIT;

-- 비회원/회원 SELECT LIST, id: list_all_y
SELECT topicno, name, cnt, gdate, seqno, visible 
FROM topic 
WHERE visible='Y'
ORDER BY seqno ASC;

  
  
  
  
  
  
  
  
  
  
