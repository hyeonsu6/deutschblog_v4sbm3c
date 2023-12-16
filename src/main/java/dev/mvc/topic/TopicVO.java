package dev.mvc.topic;

//CREATE TABLE topic(
//topicno                       		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
//name                          		VARCHAR2(30)		 NOT NULL,
//cnt                           		NUMBER(10)		 NOT NULL,
//gdate                         		DATE		 NOT NULL
//);

public class TopicVO {
	private int topicno;
	private String name;
	private int cnt;
	private String gdate;
	private int seqno;
	private String visible;

	public int getTopicno() {
		return topicno;
	}

	public void setTopicno(int topicno) {
		this.topicno = topicno;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

	public String getGdate() {
		return gdate;
	}

	public void setGdate(String gdate) {
		this.gdate = gdate;
	}

	public int getSeqno() {
		return seqno;
	}

	public void setSeqno(int seqno) {
		this.seqno = seqno;
	}

	public String getVisible() {
		return visible;
	}

	public void setVisible(String visible) {
		this.visible = visible;
	}


	@Override
	public String toString() {
		return "TopicVO [topicno=" + topicno + ", name=" + name + ", cnt=" + cnt + ", gdate=" + gdate + ", seqno="
				+ seqno + ", visible=" + visible + "]";
	}


}
