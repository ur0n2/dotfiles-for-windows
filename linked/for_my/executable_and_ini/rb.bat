shutdown -f -r -t 3
taskkill /f /fi "PID gt 0" /im *