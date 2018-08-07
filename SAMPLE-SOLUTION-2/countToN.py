import sys

def main():
	if (len(sys.argv) < 2):
		print("usage: python3 countToN.py int_to_count_to")
		return

	try:
		n = int(sys.argv[1])
	except Exception as e:
		print("usage: python3 countToN.py int_to_count_to")
		return

	for i in range(n):
		print(i)

if __name__ == '__main__':
	main()