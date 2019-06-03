import sys, csv, random
myFile = open("os-exam.csv", newline="")
myFileList = list(csv. reader(myFile, delimiter = ":"))
myChoiceList = ["a", "b", "c", "d", "e", "f"]
def myCSV():
    myQuestionNum = 1
    for tempLine in myFileList:
        if (len(tempLine) > 4):
            #random.shuffle(tempLine[2:len(tempLine)])
            print("\n")
            for n in range(len(tempLine)):
                if n == 0:
                    print("Question #" + str(myQuestionNum) + ".) : " + tempLine[n])
                    myQuestionNum += 1
                elif n == 1:
                    print("Correct Answer: " + tempLine[n])
                else:
                    print(str(myChoiceList[n-2]) + ".) " + tempLine[n])
myCSV()