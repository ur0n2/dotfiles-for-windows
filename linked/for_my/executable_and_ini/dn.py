#-*- coding:mbcs -*-
import subprocess
import os
import sys
import ctypes
from urllib import quote_plus

def win32_utf8_argv():                                                                                               
    """Uses shell32.GetCommandLineArgvW to get sys.argv as a list of UTF-8                                           
    strings.                                                                                                         
                                                                                                                     
    Versions 2.5 and older of Python don't support Unicode in sys.argv on                                            
    Windows, with the underlying Windows API instead replacing multi-byte                                            
    characters with '?'.                                                                                             
                                                                                                                     
    Returns None on failure.                                                                                         
                                                                                                                     
    Example usage:                                                                                                   
                                                                                                                     
    >>> def main(argv=None):                                                                                         
    ...    if argv is None:                                                                                          
    ...        argv = win32_utf8_argv() or sys.argv                                                                  
    ...                                                                                                              
    """                                                                                                              
                                                                                                                     
    try:                                                                                                             
        from ctypes import POINTER, byref, cdll, c_int, windll                                                       
        from ctypes.wintypes import LPCWSTR, LPWSTR                                                                  
                                                                                                                     
        GetCommandLineW = cdll.kernel32.GetCommandLineW                                                              
        GetCommandLineW.argtypes = []                                                                                
        GetCommandLineW.restype = LPCWSTR                                                                            
                                                                                                                     
        CommandLineToArgvW = windll.shell32.CommandLineToArgvW                                                       
        CommandLineToArgvW.argtypes = [LPCWSTR, POINTER(c_int)]                                                      
        CommandLineToArgvW.restype = POINTER(LPWSTR)                                                                 
                                                                                                                     
        cmd = GetCommandLineW()                                                                                      
        argc = c_int(0)                                                                                              
        argv = CommandLineToArgvW(cmd, byref(argc))                                                                  
        if argc.value > 0:                                                                                           
            # Remove Python executable if present                                                                    
            if argc.value - len(sys.argv) == 1:                                                                      
                start = 1                                                                                            
            else:                                                                                                    
                start = 0                                                                                            
            return [argv[i].encode('utf-8') for i in                                                                 
                    xrange(start, argc.value)]                                                                       
    except Exception:                                                                                                
        pass


# support to clipboard
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
        #text = raw_data.raw.decode('utf-16le').rstrip(u'\0')
        text = raw_data.raw.decode('mbcs').rstrip(u'\0')
    GlobalUnlock(handle)
    CloseClipboard()
    return text

def put(s):
    if not isinstance(s, unicode_type):
        s = s.decode('mbcs')
    #data = s.encode('utf-16le')
    data = s.encode('mbcs')
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


prgm_path = ""
if os.environ.get("PROGRAMFILES(X86)") is None: #this case is 32bit 
    prgm_path = os.environ.get("PROGRAMFILES")
else:
    prgm_path = os.environ.get("PROGRAMFILES(X86)")

#print prgm_path
base_url= "http://endic.naver.com/search.nhn?sLn=kr&query=" #Naver Dictionary search query url

#print sys.getfilesystemencoding()

if len(sys.argv) is 1:
    print "You don't type argument(s)"
    value = quote_plus(str(get().encode('mbcs'))) #cmd.exe is MBCS character set
    print "testvalue: " +  value, type(value)

    query = prgm_path + "\Google\Chrome\Application\chrome.exe " + str(base_url) + value #Make query
    print query
    
    subprocess.check_call(query, shell=False)
else:
    argv = win32_utf8_argv() 
    value =  quote_plus( str( (" ".join(argv[1:]) ) ) )
    query = prgm_path + "\Google\Chrome\Application\chrome.exe " + str(base_url) + value #value #Make query

    print query

    subprocess.check_call(query, shell=False)
