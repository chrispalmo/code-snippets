import numpy as np

def is_jagged(x):
	return not (max([len(i) for i in x])==min([len(i) for i in x]))

if __name__ == "__main__":
	a = np.array([np.array([1,2,3]),np.array([4,5,6])])
	b = np.array([np.array([1,2,3]),np.array([4,5])])
	print(f'\na: {a}')
	print(f'\nb: {b}')
	print(f'\nIs a jagged? {is_jagged(a)}')
	print(f'\nIs b jagged? {is_jagged(b)}')

	class JaggedArrayError(Exception):
		pass

	try:
		assert(not is_jagged(b))
	except:
		raise JaggedArrayError(f"Array dimensions are inconsistent, which will cause transposition to fail. This is probably due to blank values in visum. Please replace blank values with the string 'NULL' and try again.")