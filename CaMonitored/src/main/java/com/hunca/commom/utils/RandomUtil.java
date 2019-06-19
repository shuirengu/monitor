package com.hunca.commom.utils;

import java.util.Random;

public class RandomUtil {
	
	//private static Random randGen = null;
	//private static char[] numbersAndLetters = null;
	
	private static Random randGen = new Random();
	
	// 随机生成一串数字
	public static final String randomNumber(int length){
		//randGen = new Random();
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < length; i++) {
			int nextInt = randGen.nextInt(10);
			sb.append(nextInt);
		}
		return sb.toString();
	}
	
	public static final String randomString(int length)
	{
		char[] numbersAndLetters = ("0123456789abcdefghijklmnopqrstuvwxyz" +		                   
				 "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ").toCharArray();
		char[] randBuffer = new char[length];
		for (int i=0; i<randBuffer.length; i++){
			randBuffer[i] = numbersAndLetters[randGen.nextInt(71)];
		}
		return new String(randBuffer);
		 /*if (length < 1) 
		 { 
			 return null;
		 }
		 if (null==randGen) 
		 {
			 randGen = new Random();
			 numbersAndLetters = ("0123456789abcdefghijklmnopqrstuvwxyz" +		                   
					 "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ").toCharArray();		                  
			 //numbersAndLetters = ("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ").toCharArray();
		 }
		 char [] randBuffer = new char[length];
		 for (int i=0; i<randBuffer.length; i++) 
		 {
			 randBuffer[i] = numbersAndLetters[randGen.nextInt(71)];
			 //randBuffer[i] = numbersAndLetters[randGen.nextInt(35)];
		 }
		 return new String(randBuffer);*/
	}
	
	public static void main(String[] args) 
	{
		System.out.println(randomString(6));
		System.err.println(randomNumber(6));
	}
}
