def main():
	try:
		a = int(input("Enter an integer value for a:"))
		b = int(input("Enter an integer value for b:"))
	except ValueError as e:
		print("Not an integer!")
		return

	print("%d + %d = %d" % (a, b, a + b))

if __name__ == '__main__':
	main()
		

