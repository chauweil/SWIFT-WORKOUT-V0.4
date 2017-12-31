#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Dec 25 22:53:04 2017

@author: jeff
"""
import numpy as np
#import matplotlib.pyplot as plt

from skimage import data
from skimage.feature import match_template

from skimage import io
from skimage.color import rgb2gray

from skimage.transform import rotate
import math
from scipy.ndimage.interpolation import rotate


import pkg_resources

import os,sys
dir_path = os.path.dirname(os.path.realpath(__file__))
os.path.basename(os.path.dirname(os.path.realpath(__file__)))
currentFile = __file__ 

path = os.path.abspath(__file__)

pathname = os.path.dirname(sys.argv[0]) 
os.path.abspath(pathname)
class ticketprocessing:
    
    def __init__(self, file):
        
        # --- set image
        if isinstance(file, str):
            self.image= io.imread(file,as_grey=True)        

            
        # --- set image
        if isinstance(file, np.ndarray):
            self.image= file
            
        # --- rotate            
        if(self.image.shape[1]>self.image.shape[0]):
            self.image=rotate(self.image, -90, reshape=True)


    def __repr__(self):
        return("Image with shape ({},{})".format(self.image.shape[0], self.image.shape[1]))
        
    
    #def plot(self):
        #plt.imshow(self.image)
        
    def cropHF(self,header,foot):
        
        #--- take out the header
        imagebase=self.image
        result = match_template(imagebase, header,pad_input=True)
        ij = np.unravel_index(np.argmax(result), result.shape)
        x, y = ij[::-1]
        hcoin, wcoin = header.shape
        image2=imagebase[math.floor(y+hcoin/2):,:]
        
        
        #--- take out the foot
        result = match_template(image2, foot,pad_input=True)
        ij = np.unravel_index(np.argmax(result), result.shape)
        x, y = ij[::-1]
        hcoin, wcoin = foot.shape
        image3=image2[0:math.floor(y+hcoin/2),:]

        
        return(image3)


    
"""----------------------------------------------------------------------

                    
           read image         

a=imageprocessing('BIG1.jpg')

a.plot()
a

b=a.getHeader(coin,coin2)

plt.imshow(b)


img= io.imread('BIG1.jpg',as_grey=True)
image= io.imread('BIG1.jpg',as_grey=True)

from scipy.ndimage.interpolation import rotate


if(image.shape[1]>image.shape[0]):
    image=rotate(image, -90, reshape=True)


if(img.shape[1]>img.shape[0]):
    img=rotate(img, -90, reshape=True)



coin = img[400:800,700:2000]
coin2 = img[1250:1400,700:1200]

plt.imshow(coin)
plt.imshow(coin2)
plt.imshow(img)
plt.imshow(image)



----------------------------------------------------------------------"""