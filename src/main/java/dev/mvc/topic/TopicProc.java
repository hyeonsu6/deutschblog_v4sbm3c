package dev.mvc.topic;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

//Controller가 사용하는 이름
@Component("dev.mvc.topic.TopicProc")
public class TopicProc implements TopicProcInter {
	@Autowired // TopicDAOInter interface 구현한 객체를 만들어 자동으로 할당해라.
	private TopicDAOInter topicDAO;

	@Override
	public int create(TopicVO topicVO) {
		int cnt = this.topicDAO.create(topicVO);

		return cnt;
	}

	@Override
	public ArrayList<TopicVO> list_all() {
		ArrayList<TopicVO> list = this.topicDAO.list_all();

		return list;
	}
	
	@Override
	public ArrayList<TopicVO> list_all_member() {
		ArrayList<TopicVO> list = this.topicDAO.list_all();

		return list;
	}

	@Override
	public TopicVO read(int topicno) {
		TopicVO topicVO = this.topicDAO.read(topicno);

		return topicVO;
	}

	@Override
	public int update(TopicVO topicVO) {
		int cnt = this.topicDAO.update(topicVO);

		return cnt;
	}

	@Override
	public int delete(int topicno) {
		int cnt = this.topicDAO.delete(topicno);

		return cnt;
	}

	@Override
	public int update_seqno_forward(int topicno) {
		int cnt = this.topicDAO.update_seqno_forward(topicno);
		return cnt;
	}

	@Override
	public int update_seqno_backward(int topicno) {
		int cnt = this.topicDAO.update_seqno_backward(topicno);
		return cnt;
	}

	@Override
	public int update_visible_y(int topicno) {
		int cnt = this.topicDAO.update_visible_y(topicno);
		return cnt;
	}

	@Override
	public int update_visible_n(int topicno) {
		int cnt = this.topicDAO.update_visible_n(topicno);
		return cnt;
	}

	@Override
	public ArrayList<TopicVO> list_all_y() {
		ArrayList<TopicVO> list = this.topicDAO.list_all_y();
		return list;
	}

}
