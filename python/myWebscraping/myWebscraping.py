import bs4
import requests
myPageContent = requests.get('https://www.memoryexpress.com/Category/HardDrives')
myPageContent.raise_for_status()
mySoup = bs4.BeautifulSoup(myPageContent.content, 'html.parser')
myElems = mySoup.find_all('div', {"class":"c-shcaicon-item"})
for link in myElems:
    myItemName = link.find("div", class_ = "c-shcaicon-item__body-name")
    myItemName = myItemName.find("a").get_text()
    myPrice = link.find("div", class_ = "c-shcaicon-item__summary-list")
    myPrice = myPrice.find("span").get_text()
    #the ADATA is out of place when printed out,
    # \r\n = CR + LF // Used as a new line character in Windows
    if "\n" in myItemName.strip():
        string = (myItemName.strip())
        split = string.split("\r\n")
        #print(split)
        myItemName = ""
        for i in range(len(split)):
            split[i] = split[i].strip()
        for i in split:
            if i == "":
                continue
            else:
                myItemName += i + " "
        #print(split)
        #print(output)
    print("The Hard Drive: " + myItemName.strip() + " is for sale at " + myPrice.strip())
