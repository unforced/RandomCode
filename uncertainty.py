import parser
def calculateUncertainty(variables, uncertainties, formula):
    if (len(uncertainties) != len(variables)): print 'fail'
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
