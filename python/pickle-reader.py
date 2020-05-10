#!/usr/bin/python
'''
Above "shebang": if you have installed many versions of Python, then 
#!/usr/bin/env ensures that the interpreter will use the first installed 
version on your environment's $PATH. Used for unix-based operating systems. 
'''

import argparse
import pickle
import numpy

parser = argparse.ArgumentParser(description='Open a Python "Pickle" file, print variable TYPE and CONTENTS')
parser.add_argument('filename', type=str, nargs='+',
                   help='path to pickle file')

args = parser.parse_args()
filename = args.filename[0]

with open(filename, 'rb') as pickle_file:
	pickled_variable = pickle.load(pickle_file)

print(f'\nLoaded {filename}.')

try:
	print(f'\nType: ',type(pickled_variable))
except:
	pass
try:
	print(f'\nContents: ')
	for row in pickled_variable: 
		print("\n",row)
		print("Type: ",type(row))
		print("Contains: ",type(row[0]),"(based on 0th element)")
except:
	print(pickled_variable)
