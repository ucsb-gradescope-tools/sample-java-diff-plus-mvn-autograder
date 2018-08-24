package edu.ucsb.cs56.pconrad.m18_labxx;

public class Assignment {
	public int myNumber;

	public Assignment() {
		myNumber = 0;
	}

	public Assignment(int n) {
		myNumber = n;
	}

	public String hello() {
		return "Hello, world!";
	}

	public int add(int x) {
		return myNumber + x;
	}
}
