package com.hunca.commom.utils;

import java.util.UUID;

public class UuidUtil {
	
	public static String uuid(){
		return UUID.randomUUID().toString().replace("-", "");
	}
	
	/***
	 * 
	 * @param charCount 需要随机数的数量
	 * @return 随机数
	 */
	public static String getRandNum(int charCount) {
		String randomcode = "";
		// 用字符数组的方式随机
		String model = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		char[] m = model.toCharArray();
		for (int j = 0; j < charCount; j++) {
			char c = m[(int) (Math.random() * 36)];
			// 保证六位随机数之间没有重复的
			if (randomcode.contains(String.valueOf(c))) {
				j--;
				continue;
			}
			randomcode = randomcode + c;
		}
		return randomcode;
   }

}
