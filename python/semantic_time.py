from math import floor

def time_breakdown(ms):
	"""Converts an integer representing number of milliseconds into a dictionary 
	representing days, hours, minutes, seconds and milliseconds. Output numbers 
	are rounded down to the nearest whole number.

	Parameters:
		ms (integer): number of milliseconds.

	Returns:
		(dictionary): breakdown of total days, hours, minutes, seconds and 
		milliseconds.

	Example usage:
		>>> time_breakdown = time_breakdown(123456789)
		{'day': 1, 'hr': 10, 'min': 17, 'sec': 36, 'ms': 789} 
	"""

	ms_out = ms % 1000;
	sec = floor((ms % (1000 * 60)) / 1000)
	min = floor((ms % (1000 * 60 * 60)) / 1000 / 60)
	hr = floor((ms % (1000 * 60 * 60 * 24)) / 1000 / 60 / 60)
	day = floor(
		(ms % (1000 * 60 * 60 * 24 * 365)) / 1000 / 60 / 60 / 24
	)

	return {
		"day": day,
		"hr": hr,
		"min": min,
		"sec": sec,
		"ms": round(ms_out)
	}

def time_breakdown_string(ms, granularity=5):
	"""Converts an integer representing number of milliseconds into a string that 
	uses natural language to represent the time quantity.

	Parameters:
		ms (integer): number of milliseconds.
		granularity (integer): the level of detail required.

	Returns:
		(string): string that uses natural language to represent the time quantity.

	Example usage:
		>>> time_breakdown_string(123456789)
		
		'1 day 10 hours 17 minutes 36 seconds 789 milliseconds'

		>>>time_breakdown_string(
		123456789,
		granularity=3)
		
		'1 day 10 hours 17 minutes'
	"""

	time = time_breakdown(ms)
	time_string = ""

	if time["day"] != 0:
		time_string += str(time["day"]) + " day"
		if time["day"] != 1:
			time_string += "s"

	if time["hr"] != 0:
		time_string += " " + str(time["hr"]) + " hour"
		if time["hr"] != 1:
			time_string += "s"

	if time["min"] != 0:
		time_string += " " + str(time["min"]) + " minute"
		if time["min"] != 1:
			time_string += "s"

	if time["sec"] != 0:
		time_string += " " + str(time["sec"]) + " second"
		if time["sec"] != 1:
			time_string += "s"	

	if time["ms"] != 0:
		time_string += " " + str(time["ms"]) + " millisecond"
		if time["ms"] != 1:
			time_string += "s"	

	#filter to specified granularity
	time_string = time_string.strip().split(" ")[:2*granularity]

	return " ".join(time_string)

# Example implementation
def main():
	from datetime import datetime

	mercury_orbit_period = 7600608000
	print(f"""
To orbit the sun, it takes Mercury:

	{time_breakdown(mercury_orbit_period)}
	{time_breakdown_string(mercury_orbit_period, 1)}
	{time_breakdown_string(mercury_orbit_period, 2)}
	{time_breakdown_string(mercury_orbit_period, 3)}
	{time_breakdown_string(mercury_orbit_period, 4)}
	""")

	one_day_minus_one_second = 1*24*60*60*1000 - 1000
	one_day_exactly = 1*24*60*60*1000
	one_day_plus_one_second = 1*24*60*60*1000 + 1000
	one_day_plus_one_minute = 1*24*60*60*1000 + 1000*60
	print(f"""
Ignores 'zero' units:

	{time_breakdown(one_day_minus_one_second)}
	{time_breakdown_string(one_day_minus_one_second)}
	
	{time_breakdown(one_day_exactly)}
	{time_breakdown_string(one_day_exactly)}

	{time_breakdown(one_day_plus_one_second)}
	{time_breakdown_string(one_day_plus_one_second)}

	{time_breakdown(one_day_plus_one_minute)}
	{time_breakdown_string(one_day_plus_one_minute)}
	""")

	one_second = 1000
	two_seconds = 2000
	one_minute_one_second = 361000
	two_minute_one_second = 721000
	two_minute_two_second = 722000
	print(f"""
Plurality is considered:

	{time_breakdown_string(one_second)}
	{time_breakdown_string(two_seconds)}
	{time_breakdown_string(one_minute_one_second)}
	{time_breakdown_string(two_minute_one_second)}
	{time_breakdown_string(two_minute_two_second)}
	""")

if __name__ == "__main__":
	main()

