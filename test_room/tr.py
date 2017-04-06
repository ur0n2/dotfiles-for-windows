import subprocess
import os
import sys
import ctypes

OpenClipboard = ctypes.windll.user32.OpenClipboard
EmptyClipboard = ctypes.windll.user32.EmptyClipboard
GetClipboardData = ctypes.windll.user32.GetClipboardData
SetClipboardData = ctypes.windll.user32.SetClipboardData
CloseClipboard = ctypes.windll.user32.CloseClipboard
CF_UNICODETEXT = 13

GlobalAlloc = ctypes.windll.kernel32.GlobalAlloc
GlobalLock = ctypes.windll.kernel32.GlobalLock
GlobalUnlock = ctypes.windll.kernel32.GlobalUnlock
GlobalSize = ctypes.windll.kernel32.GlobalSize
GMEM_MOVEABLE = 0x0002
GMEM_ZEROINIT = 0x0040

unicode_type = type(u'')

def get():
    text = None
    OpenClipboard(None)
    handle = GetClipboardData(CF_UNICODETEXT)
    pcontents = GlobalLock(handle)
    size = GlobalSize(handle)
    if pcontents and size:
        raw_data = ctypes.create_string_buffer(size)
        ctypes.memmove(raw_data, pcontents, size)
        text = raw_data.raw.decode('utf-16le').rstrip(u'\0')
    GlobalUnlock(handle)
    CloseClipboard()
    return text

def put(s):
    if not isinstance(s, unicode_type):
        s = s.decode('mbcs')
    data = s.encode('utf-16le')
    OpenClipboard(None)
    EmptyClipboard()
    handle = GlobalAlloc(GMEM_MOVEABLE | GMEM_ZEROINIT, len(data) + 2)
    pcontents = GlobalLock(handle)
    ctypes.memmove(pcontents, data, len(data))
    GlobalUnlock(handle)
    SetClipboardData(CF_UNICODETEXT, handle)
    CloseClipboard()

paste = get
copy = put

if len(sys.argv) is 1:
    print "You don't type argument(s)"
    print get()

    base_url= "https://translate.google.co.kr/#auto/ko/" #Google Translate Query URL
    value = str(get()) # '%20'.join(get()) #'%20'.join(sys.argv[1:]) #search value
    print "testvalue: " +  value

    prgm_path = "asD"
    if os.environ.get("PROGRAMFILES(X86)") is None: #this case is 32bit 
        prgm_path = os.environ.get("PROGRAMFILES")
    else:
        prgm_path = os.environ.get("PROGRAMFILES(X86)")
    print prgm_path

    query = prgm_path + "\Google\Chrome\Application\chrome.exe " + str(base_url) + value #Make query
    print query
    subprocess.check_call(query, shell=False)

    #test_room
#    test_data = open("tddd.txt")

