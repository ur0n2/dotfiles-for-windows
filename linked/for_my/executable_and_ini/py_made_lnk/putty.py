import os 
import sys

def dir_recursion(prgm_path):
	for path, dirs, files in os.walk(prgm_path): 
		#print files
		for file in files:
			fname = os.path.split(file)
			if fname[-1] == "putty.exe": 
				print "get:" + fname[-1]
				print "got it!"
	return fname


print "[+] First execute to " + "'" + os.path.basename(os.path.realpath(__file__)) + "'"


# case 1
prgm_64path = os.environ.get("programfiles") # C:\Program Files (x86)
#print prgm_path

# case 2
prgm_32path = os.environ.get("programW6432") # C:\Program Files
#print prgm_path

# if 64 bit and then run case1 and case2
if os.environ.get("PROGRAMFILES(X86)") is None: # this case is 32bit
	print("this case is 32bit")
	#print dir_recursion(prgm_32path)
else: # this case is 64bit
	print("this case is 64bit")	
	print dir_recursion(prgm_64path)
	print dir_recursion(prgm_32path)

print "end"
# if 32bit and then just run case2.



# make symbolic link


# execute count logging