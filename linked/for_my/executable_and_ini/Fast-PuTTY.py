"""
[+] Fast Putty .py
[+] Author: LeeJunHwan(ur0n2)
[+] Usage:
    argv ip: input host IP, default: NULL
    argv id: user account, default: root
    argv port: port, default: 50022
    argv pw: account password default:123123
    argv wrt: write host ip number to default.ini
    argv wrtip: 
    argv wrtpt: 
    argv help: 
    argv 
    Base Command: C:\program files (x86)\putty\putty.exe root@192.168.4.22:50022 -pw 123123
    Example Command: __this__.py 13
[+] Test Environment: Windows 7 Ultimate KN x64
"""
#/usr/bin/python

import argparse
import ConfigParser
import subprocess
import os

def check_ini_file():
    try: #default.ini exist check       
        config = ConfigParser.RawConfigParser()
        config.read("default.ini")      
        print config.options("SERVER_HOST_IP")

    except: #default.ini create         
        config = ConfigParser.RawConfigParser()
        config.add_section("SERVER_HOST_IP")
        config.set("SERVER_HOST_IP", "host_ip", "22") #default ip is 192.168.4.22
        ff = open("default.ini", "wb") 
        with ff as configfile:
            config.write(configfile)
            ff.close()

if __name__ == "__main__":
    check_ini_file()

    parser = argparse.ArgumentParser()

    #arguments are optional
    parser.add_argument("-ip", help="x of 192.168.4.x", type=str) 
    parser.add_argument("-id", help="user id, default: root", type=str) 
    parser.add_argument("-P", help="port number, default: 50022",type=str) #argument format like putty command line
    parser.add_argument("-pw", help="password, default: 123123", type=str)    
    parser.add_argument("-wrt", help = "write host ip number to default.ini", type=str) #wrt = write

    args = parser.parse_args() #arguments parsing

    config = ConfigParser.ConfigParser()
    config.read("default.ini")
    
    if not args.id:
        args.id = "root"
        
    if not args.P:
        args.P = "50022"
        
    if not args.pw:
        args.pw = "123123"

    if args.wrt:
        ff = open("default.ini", "wb") 
        with ff as configfile:       
            config.set("SERVER_HOST_IP", "host_ip", args.wrt)
            print config.get("SERVER_HOST_IP","host_ip")    
            config.write(configfile)
        ff.close()
        #exit(1)

    if not args.ip:
        args.ip = config.get("SERVER_HOST_IP", "host_ip")

    """
    print args.ip
    print args.id
    print args.P
    print args.pw
    print args.wrt
    """
    
    #concatenate putty command line with id, ip, port, pw
    argus = args.id + "@192.168.4." + args.ip + " -P " + args.P + " -pw " + args.pw
    #print argus
    print args.id + args.ip + args.P + args.pw
    
    #prgm_path = os.environ.get("PROGRAMFILES(X86)")
    run_run = "C:\Program Files\PuTTY\putty.exe " + argus #"C:\Program Files (x86)\PuTTY\putty.exe " + argus
    
    print run_run
    
    subprocess.check_call(run_run)
