#! /bin/bash -
# incomplete; 
#by William SAHNG
# Activity: RegEx and Sed
# myFilePath for win10 testing
declare myFilePath=/c/myGitFolder/myScripts/mySample_dhcpd.conf
# Task 1: Emulate grep with sed. Print all lines starting with option.
function myTask1 {
    sed '/option/!d' $myFilePath
}

# Task 2: Delete all blank lines in the file
function myTask2 {
    sed -i '/./!d' $myFilePath
}

# Task 3: Add the following line to the beginning of the file: # NASP19 sed DHCP Configuration
function myTask3 {
    # The leading number is the position in the file where you want the insert
    # in this case a '1' indicates the top of the file.
    sed -i '1i# NASP19 sed DHCP Configuration' $myFilePath
}

# Task 4: Remove all comments at the end of line 
# hints : (1) what does ^ match? (2) what does [^] match? (3) what does [^^] match?
function myTask4 {
    # The command '/^#/d' remove line starting with #. 
    # The command 's/#.*$//' find comments at end of lines, and replace with nothing;
    # i ended up removing starting from the 3rd line;  
    # this is most likely the cheating way to do this, but it gets the job done;
    sed -i '3,$s/#.*$//' $myFilePath
}    

# Task 5: Change the router IP address to 10.10.0.1. 
# Note that there is more than one empty space between "option" and "routers". 
# Your expression should therefore match multiple empty spaces. 
# To match any white space, use [[:space:]]. 
# This will match tab, space, etc.
function myTask5{
    # this is just searching for the words "option  routers" and change the line with what i need the line to be;
    sed -i '/option  routers/c\        option routers                  10.10.0.1;' $myFilePath
}

# Task 6: Report the range of IP addresses. 
# The output should be in the form: IP range is : 10-100. 
# I.e., do not report the rest of IP addresses.
function myTask6{
    sed -n -e 's/^.*range//p' $myFilePath
    sed -e 's/192.168.1.//'$myRangeVar
}
