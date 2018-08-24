package edu.ucsb.cs56.pconrad.m18_labxx;

public class Assignment {
	public int myNumber;

	public Assignment() {
		myNumber = -42;
	}

	public Assignment(int n) {
		myNumber = n;
	}

	public String hello() {
		return "WRONG STRING world!";
	}

	public int add(int x) {
		return myNumber - x;
	}
}
