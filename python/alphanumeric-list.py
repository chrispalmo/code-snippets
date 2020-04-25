from string import digits, ascii_uppercase, ascii_lowercase

"""
List comprehension with nested iterations

Build a list of alphanumeric characters: ['A1', 'A2', ... 'B1', 'B2'...'Z9']
"""

### Like chump

alphanumeric = []

for letter in ascii_uppercase:
	for digit in digits:
		alphanumeric.append(str(letter)+str(digit))
print(alphanumeric)

### Like a boss

alphanumeric = [letter+digit for letter in ascii_uppercase for digit in digits]
print(alphanumeric)

