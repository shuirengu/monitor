package com.hunca.commom.utils;
import java.util.List;
public class PageUtils {
      /**
       * 当一个泛型参数应用在了方法的返回值类型
       * 左侧时这样的方法称之为泛型方法.
       * @param rowCount
       * @param records
       * @param pageSize
       * @param pageCurrent
       * @return
       */
	  public static <T>PageObject<T> newPageObject(
			  Integer rowCount,
			  List<T> records,
			  Integer pageSize,
			  Integer pageCurrent){
		    PageObject<T> po=new PageObject<>();
			po.setRowCount(rowCount);
			po.setRecords(records);
			po.setPageSize(pageSize);
			po.setPageCurrent(pageCurrent);
			po.setPageCount((rowCount-1)/pageSize+1);
			return po;
	  }
}
