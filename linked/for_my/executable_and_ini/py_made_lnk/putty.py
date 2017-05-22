import os 
import sys

def dir_recursion(prgm_path):
	for path, dirs, files in os.walk(prgm_path): 
		#print files
		for file in files:
			fname = os.path.split(file)
			if fname[-1] == "putty.exe": 
				print "get:" + fname[-1]
				print "file:"+ file, path
				print "got it!"
	return fname, path


print "[+] First execute to " + "'" + os.path.basename(os.path.realpath(__file__)) + "'"

print os.path.basename(os.path.realpath(__file__)).split(".")[0]

# case 1
prgm_64path = os.environ.get("programfiles") # C:\Program Files (x86)
#print prgm_path

# case 2
prgm_32path = os.environ.get("programW6432") # C:\Program Files
#print prgm_path

# if 64 bit and then run case1 and case2
# if 32bit and then just run case2.
if prgm_64path is None: # this case is 32bit. programfiles(x86) path is not exist. that mean is x86 system.
	print("this case is 32bit")
	
	[execute, paths] = dir_recursion(prgm_32path)
	if [execute, paths] is None:
		print "what the " + os.path.basename(os.path.realpath(__file__)).split(".")[0] + " is not installed."
	else:
		print "wOw " + os.path.basename(os.path.realpath(__file__)).split(".")[0] + " is installed."
else: # this case is 64bit
	print("this case is 64bit")	
	
	[execute, paths] = dir_recursion(prgm_64path)
	if [execute, paths] is None:
		print "64bit path is None"
	else:
		[execute, paths] = dir_recursion(prgm_32path) 
		if [execute, paths] is None:
			print "what the " + os.path.basename(os.path.realpath(__file__)).split(".")[0] + " is not installed."
		else:
			print "wOw " + os.path.basename(os.path.realpath(__file__)).split(".")[0] + " is installed."
	

# 


# make symbolic link


# execute count logging



ㅁㄴ러ㅏㅣㅁ노림ㄴ라ㅣㅁㄴ라ㅣ
설계가잘못됨 


