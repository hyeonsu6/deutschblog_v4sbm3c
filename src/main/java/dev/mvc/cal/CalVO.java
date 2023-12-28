package dev.mvc.cal;

import java.util.Date;

public class CalVO {
	/*
	 *
	SEQ NUMBER PRIMARY KEY,
    ID VARCHAR2(50) NOT NULL,
    TITLE VARCHAR2(100) NOT NULL,
    CONTENT VARCHAR2(4000),
    RDATE VARCHAR2(8) NOT NULL,
    WDATE DATE
	 */
	
    private int seq;
    private String id;
    private String title;
    private String content;
    private String rdate;
    private Date wdate;

    // 생성자, Getter, Setter 메서드는 필요에 따라 추가할 수 있습니다.

    public int getSeq() {
        return seq;
    }

    public void setSeq(int seq) {
        this.seq = seq;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getRdate() {
        return rdate;
    }

    public void setRdate(String rdate) {
        this.rdate = rdate;
    }

    public Date getWdate() {
        return wdate;
    }

    public void setWdate(Date wdate) {
        this.wdate = wdate;
    }
}
