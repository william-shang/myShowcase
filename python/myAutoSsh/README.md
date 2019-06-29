# this is a python scripts that automates the ssh processes
* to find your VM's IP:
  * in Linux:
```
ifconfig
```
  * in Windows:
```
ipconfig /all
```
Before importing the scripts, i have to install paramiko, and to do that pip needs to be installed too;
```
sudo yum install python3* pip.noarch
pip3 install paramiko
```

* NOTE: If we didn't set up a SSH connection to the VM before, the server will not let it connect, have to manually ssh in to the VM first.
  * Type in “ssh nasp@142.232.221.115” then logout with “logout”;
## Author
* **William SHANG** | *Email: wshang1989@gmail.com*
