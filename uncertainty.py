'''
uncertainty.py:
I wrote this because I was too lazy to calculate the uncertainties for my physics lab.
Uses the computational method to calculate the uncertainty of a formula, given the formula, the variable values, and the uncertaintys.
Use:
python uncertainty.py variables uncertainties formula
Separate the indiviudal values in variables and uncertainties with commas, and ensure there is a space between variables, uncertainties, and formula.
Formula variables must be entered as n[x]
Ex: python uncertainty.py 1,2,3,4 0.1,0.15,0.05,0.1 n[0]*n[1]+n[2]*n[3]
'''

import parser
import sys
def calculateUncertainty(variables, uncertainties, formula):
    if (len(uncertainties) != len(variables)): 
        print 'Please input same number of variables as uncertainties'
    else:
        for x in range(len(variables)):
            if 'n[{}]'.format(x) not in formula:
                print 'Please use all variables in the formula'
        uncertaintyDueTo = []
        temp = variables[:]
        original = findValue(variables,formula)
        for x in range(len(temp)):
            temp[x] += uncertainties[x]
            newValue = findValue(temp,formula)
            uncertaintyDueTo.append(newValue-original)
            temp[x] -= uncertainties[x]
        totalUncertainty = 0
        for x in range(len(uncertaintyDueTo)):
            print "Uncertainty due to {} is {}".format(x, uncertaintyDueTo[x])
            totalUncertainty += uncertaintyDueTo[x]**2
        print "Total Uncertainty is {}".format(totalUncertainty**(0.5))


def findValue(numbers,formula):
    code = parser.expr(formula).compile()
    n = numbers[:]
    return eval(code)
    #Still needs error checking for formula name errors.  Might add later.

if __name__=="__main__":
    calculateUncertainty(map(float, sys.argv[1].split(',')), map(float, sys.argv[2].split(',')), sys.argv[3])


