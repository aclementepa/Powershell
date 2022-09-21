# Shortcut to open everyday applications

import webbrowser
import os

chrome_path = 'C:/Program Files(x86)/Google/Chrome/Application/chrome.exe %s'
webbrowser.register('google-chrome', None, webbrowser.BackgroundBrowser(chrome_path))
webbrowser.open_new("http://dms.howardindustries.local")
webbrowser.open_new("https://")

# start programs

os.startfile("outlook")
os.startfile("C:\\Program Files (x86)\\Mitel\\Connect\\Mitel.exe")