from inspect import stack
from datetime import datetime
from pickle import dump
from os import path
from os import makedirs

def pickle_quick_dump(variable, suffix=""):
	if not path.exists('pickle_jar'):
		makedirs('pickle_jar')
	if suffix != "": suffix = "_"+suffix
	caller_function_name = stack()[1].function
	filename="./pickle_jar/"+datetime.now().strftime('%Y%m%d_%H%M%S_')+caller_function_name+suffix+".p"
	dump(variable,open(filename,"wb"))
	return