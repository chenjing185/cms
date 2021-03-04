package com.etc.util;

import java.util.List;

/**
 * 分页实体类
 */
public class PageData {
	private List data;//查询数据库的数据  每一页显示的数据(eg:第一页10条就放在集合中)
	
	private Integer pageNo; //当前页
	
	private Integer pageSize;//每页显示记录数

	private Integer totalCount;//总记录数
	
	private Integer totalPage;//总页数
	

	public PageData() {
		super();
	}

	public Integer getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(Integer totalPage) {
		this.totalPage = totalPage;
	}

	public List getData() {
		return data;
	}

	public void setData(List data) {
		this.data = data;
	}

	public Integer getPageNo() {
		return pageNo;
	}

	public void setPageNo(Integer pageNo) {
		this.pageNo = pageNo;
	}

	public Integer getPageSize() {
		return pageSize;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}

	public Integer getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(Integer totalCount) {
		this.totalCount = totalCount;
	}

	public PageData(List data, Integer pageNo, Integer pageSize,Integer totalCount) {
		super();
		this.data = data;
		this.pageNo = pageNo;
		this.pageSize = pageSize;
		this.totalCount = totalCount; 
		//总页数:可以通过总条数和每页显示的条数换算出来
		this.totalPage = totalCount%pageSize == 0 ? totalCount/pageSize : (totalCount/pageSize+1);
	}
}

