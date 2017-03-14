
import subprocess
import os
import sys

base_url= "http://endic.naver.com/search.nhn?sLn=kr&query=" #Search query url
value = '%20'.join(sys.argv[1:]) #search value
print value
prgm_path = os.environ.get("PROGRAMFILES(X86)") #Program Files (x86) path

query = prgm_path + "\Google\Chrome\Application\chrome.exe " + base_url + value #Make query
subprocess.check_call(query, shell=False)
