import paramiko
from myAutoSsh_conf import mySshVars

if __name__ == "__main__":
    s = paramiko.SSHClient()
    s.load_system_host_keys()
    s.connect(hostname, port, username, password)
    stdin, stdout, stderr = s.exec_command('uptime')
    print stdout.read()
    s.close()
