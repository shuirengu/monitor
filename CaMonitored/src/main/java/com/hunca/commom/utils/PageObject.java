package com.hunca.commom.utils;
import java.io.Serializable;
import java.util.List;

/**
 * VO: Value Object (值对象) 用于封装数据
 * 说明:当一个泛型参数应用在了类名的右侧时,
 * 表示这个类为泛型类.
 */
public class PageObject<T> implements Serializable{
	@Override
	public String toString() {
		return "PageObject [records=" + records + ", rowCount=" + rowCount + ", pageCurrent=" + pageCurrent
				+ ", pageSize=" + pageSize + ", pageCount=" + pageCount + "]";
	}
	private static final long serialVersionUID = 5200663226616533603L;
	/**当前页记录*/
	private List<T> records;
	/**总记录数*/
	private int rowCount;
	/**当前页码值*/
	private Integer pageCurrent;
	/**页面大小*/
	private Integer pageSize;
	/**总页数*/
	private Integer pageCount;
	public List<T> getRecords() {
		return records;
	}
	public void setRecords(List<T> records) {
		this.records = records;
	}
	public int getRowCount() {
		return rowCount;
	}
	public void setRowCount(int rowCount) {
		this.rowCount = rowCount;
	}
	public Integer getPageCurrent() {
		return pageCurrent;
	}
	public void setPageCurrent(Integer pageCurrent) {
		this.pageCurrent = pageCurrent;
	}
	public Integer getPageSize() {
		return pageSize;
	}
	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}
	public Integer getPageCount() {
		return pageCount;
	}
	public void setPageCount(Integer pageCount) {
		this.pageCount = pageCount;
	}
	
}
