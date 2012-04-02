"""
I saw something on DailyWTF about how someone tested new programmers by having them write rom2num
Apparently most people had a hard time with it and one answer was particularly ridiculous.
So I tried writing it myself.
Requires roman numerals to be entered in the standard way(VIII, not IIX).
"""
import sys
def rom2num(rom):
	num = 0
	lastNum = 0
	roman_numerals = {'I':1, 'V':5, 'X':10, 'L':50, 'C':100, 'D':500, 'M':1000}
	for char in rom.upper()[::-1]:
		try:
			value = roman_numerals[char]
		except:
			return "Please enter a valid roman_numeral"
		if value >= lastNum:
			num+=value
		else:
			num-=value
		lastNum = value
	return num

if __name__=="__main__":
	print rom2num(sys.argv[1])
