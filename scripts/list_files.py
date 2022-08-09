# -*- coding: utf-8 -*-
"""
Created on Fri Feb 18 15:34:28 2022

@author: nsash

references:
    1.https://www.geeksforgeeks.org/python-list-files-in-a-directory/
"""

import os
 
for x in os.listdir():
    if x.endswith(".sv"):
        # Prints only text file present in My Folder
        print("`include "+"\""+x+"\"")