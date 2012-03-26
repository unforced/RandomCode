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
