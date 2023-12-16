/**********************************/
/* Table Name: 관리자 */
/**********************************/
DROP TABLE articles CASCADE CONSTRAINTS; -- 자식 무시하고 삭제 가능
DROP TABLE articles;

CREATE TABLE articles(
        articlesno                            NUMBER(10)         NOT NULL         PRIMARY KEY,
        managerno                              NUMBER(10)     NOT NULL , -- FK
        topicno                                NUMBER(10)         NOT NULL , -- FK
        title                                 VARCHAR2(200)         NOT NULL,
        article                               CLOB                  NOT NULL,
        recom                                 NUMBER(7)         DEFAULT 0         NOT NULL,
        cnt                                   NUMBER(7)         DEFAULT 0         NOT NULL,
        replycnt                              NUMBER(7)         DEFAULT 0         NOT NULL,
        pw                                VARCHAR2(15)         NOT NULL,
        word                                  VARCHAR2(100)         NULL ,
        gdate                                 DATE               NOT NULL,
        file1                                   VARCHAR(100)          NULL,  -- 원본 파일명 image
        file1saved                            VARCHAR(100)          NULL,  -- 저장된 파일명, image
        thumb1                              VARCHAR(100)          NULL,   -- preview image
        size1                                 NUMBER(10)      DEFAULT 0 NULL,  -- 파일 사이즈
        price                                 NUMBER(10)      DEFAULT 0 NULL,  
        dc                                    NUMBER(10)      DEFAULT 0 NULL,  
        saleprice                            NUMBER(10)      DEFAULT 0 NULL,  
        point                                 NUMBER(10)      DEFAULT 0 NULL,  
        salecnt                               NUMBER(10)      DEFAULT 0 NULL,
        map                                   VARCHAR2(1000)            NULL,
        youtube                               VARCHAR2(1000)            NULL,
        FOREIGN KEY (managerno) REFERENCES manager (managerno),
        FOREIGN KEY (topicno) REFERENCES topic (topicno)
);

DROP SEQUENCE articles_seq;

CREATE SEQUENCE articles_seq
  START WITH 1                -- 시작 번호
  INCREMENT BY 1            -- 증가값
  MAXVALUE 9999999999  -- 최대값: 9999999999 --> NUMBER(10) 대응
  CACHE 2                        -- 2번은 메모리에서만 계산
  NOCYCLE;                      -- 다시 1부터 생성되는 것을 방지

-- 등록 화면 유형 1: 커뮤니티(공지사항, 게시판, 자료실, 갤러리,  Q/A...)글 등록
INSERT INTO articles(articlesno, managerno, topicno, title, article, recom, cnt, replycnt, pw, 
                     word, gdate, file1, file1saved, thumb1, size1)
VALUES(articles_seq.nextval, 1, 3, 'articles 테스트1', 'articles 테스트1', 0, 0, 0, '123',
       '테스트', sysdate, 'germanflag01.jpg', 'germanflag01_1.jpg', 'germanflag01_t.jpg', 1000);

-- 유형 1 전체 목록
SELECT articlesno, managerno, topicno, title, article, recom, cnt, replycnt, pw, word, gdate,
           file1, file1saved, thumb1, size1
FROM articles
ORDER BY articlesno DESC;

-- 유형 2 카테고리별 목록
INSERT INTO articles(articlesno, managerno, topicno, title, article, recom, cnt, replycnt, pw, 
                     word, gdate, file1, file1saved, thumb1, size1)
VALUES(articles_seq.nextval, 1, 2, '대행사', '흙수저와 금수저의 성공 스토리', 0, 0, 0, '123',
       '드라마,K드라마,넷플릭스', sysdate, 'space.jpg', 'space_1.jpg', 'space_t.jpg', 1000);
            
INSERT INTO articles(articlesno, managerno, topicno, title, article, recom, cnt, replycnt, pw, 
                     word, gdate, file1, file1saved, thumb1, size1)
VALUES(articles_seq.nextval, 1, 2, '더글로리', '학폭의 결말', 0, 0, 0, '123',
       '드라마,K드라마,넷플릭스', sysdate, 'space.jpg', 'space_1.jpg', 'space_t.jpg', 1000);

INSERT INTO articles(articlesno, managerno, topicno, title, article, recom, cnt, replycnt, pw, 
                     word, gdate, file1, file1saved, thumb1, size1)
VALUES(articles_seq.nextval, 1, 2, '더글로리', '학폭의 결말', 0, 0, 0, '123',
       '드라마,K드라마,넷플릭스', sysdate, 'space.jpg', 'space_1.jpg', 'space_t.jpg', 1000);

COMMIT;

-- 1번 topicno 만 출력
SELECT articlesno, managerno, topicno, title, article, recom, cnt, replycnt, pw, word, gdate,
           file1, file1saved, thumb1, size1, map, youtube
FROM articles
WHERE topicno=1
ORDER BY articlesno DESC;

-- 2번 topicno 만 출력
SELECT articlesno, managerno, topicno, title, article, recom, cnt, replycnt, pw, word, gdate,
           file1, file1saved, thumb1, size1, map, youtube
FROM articles
WHERE topicno=2
ORDER BY articlesno ASC;

-- 3번 topicno 만 출력
SELECT articlesno, managerno, topicno, title, article, recom, cnt, replycnt, pw, word, gdate,
           file1, file1saved, thumb1, size1, map, youtube
FROM articles
WHERE topicno=3
ORDER BY articlesno ASC;

-- 모든 레코드 삭제
DELETE FROM articles;
commit;

-- 삭제
DELETE FROM articles
WHERE articlesno = 25;
commit;

DELETE FROM articles
WHERE topicno=12 AND articlesno <= 41;

commit;
