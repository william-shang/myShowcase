import sys, os
def myCal(myNum1, myOperator, myNum2):
    if myOperator == "+":
        mySum = int(myNum1) + int(myNum2)
    elif myOperator == "-":
        mySum = int(myNum1) - int(myNum2)
    elif myOperator == "*":
        mySum = int(myNum1) * int(myNum2)
    elif myOperator == "/":
        mySum = int(myNum1) / int(myNum2)
    return mySum
print(myCal(sys.argv[1], sys.argv[2], sys.argv[3]))
