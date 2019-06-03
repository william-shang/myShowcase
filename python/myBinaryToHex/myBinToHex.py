def decToHexConvert(m):
    if (m <= 0):
        return "0"
    elif (m<=1):
        return str(m)
    else:
        x =(m%16)
        if (x < 10):
            return str(x)
        if (x == 10):
            return "A"
        if (x == 11):
            return "B"
        if (x == 12):
            return "C"
        if (x == 13):
            return "D"
        if (x == 14):
            return "E"
        if (x == 15):
            return "F"

def binaryToHex(myBinaryNum):
    tempSum = 0
    myHexList = []
    myBinaryList = list(map(int, str(myBinaryNum)))
    if len(myBinaryList)%4 == 1:
        myBinaryList[0:0] = [0, 0, 0]
    elif len(myBinaryList)%4 == 2:
        myBinaryList[0:0] = [0, 0]
    elif len(myBinaryList)%4 == 3:
        myBinaryList[0:0] = [0]
    for n in range(len(myBinaryList)):
        if (n+1)%4 == 1:
            tempSum += myBinaryList[n]*8
        elif (n+1)%4 == 2:
            tempSum += myBinaryList[n]*4
        elif (n+1)%4 == 3:
            tempSum += myBinaryList[n]*2
        elif (n+1)%4 == 0:
            tempSum += myBinaryList[n]*1
            myHexList.append(decToHexConvert(tempSum))
            tempSum = 0
    return "".join(myHexList)



print(binaryToHex(111011111111011010000))




