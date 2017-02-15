package com.haoyi.ipanther.common.dict.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.haoyi.ipanther.common.dict.vo.DictEntry;
import com.haoyu.sip.core.jdbc.MybatisDao;
import com.haoyu.sip.core.web.SearchParam;

@Repository
public class DictEntryDao extends MybatisDao{

	public List<DictEntry> selectAll(SearchParam searchParam) {
		return this.getSqlSession().selectList("selectAll",searchParam);
	}

	public List<Map<String, Object>> selectDictEntryOptions() {
		return this.selectList("selectDictEntryOptions");
	}

	public int checkSameValue(DictEntry dictEntry) {
		return this.selectOne("checkSameValue",dictEntry);
	}

	public int deleteByIdArray(String[] idArray) {
		return this.delete("deleteByIdArray", idArray);
	}

	public Map<String, DictEntry> selectByObjectForMap(DictEntry dictEntry) {
		return this.selectMap("selectByObjectForMap", dictEntry, "dictValue");
	}

	public List<DictEntry> selectDictLike(DictEntry t) {
		return this.selectList("selectDictLike", t);
	}
}
