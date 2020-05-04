#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# Author: John Schulz
# Created on Tue Apr 10 23:53:03 2018
# Class: ECE 468
# Title: Neural Network Project: Fish Identification


#----------------------------Packages------------------------------------------
import imageio       # Used for 'imread'
import numpy as np   # Used for array manipulation
import glob          # Used for global system realtive addressing
#------------------------------------------------------------------------------

"""
#===========================img_llist2array====================================
#    Function recieves the file paths of the image classes. Handles PNGs images
#    only.
#    
#    @param: filepath = relative location of Feature
#            Example: './Batches/Learning/Orange_Clownfish/'
#    @param: FeatureName = Name of Image Feature
#            Example: 'Orange_Clownfish'
#    @param: KeyValue = integer value given for feature type
#            Example: 0 for Monkey Images or 1 for Bear Images
#
#------------------------------------------------------------------------------
"""

def img_list2array (filepath, FeatureName, KeyValue):
    img_data = []
    key = []
    
    filepath_glob = glob.glob(filepath+'*.png')
    
    for myFile in filepath_glob:
        #print(myFile) #Prints filenames
        image = imageio.imread(myFile)
        img_data.append(image) #create list
        key.append(KeyValue)
     
    
    [Res_y, Res_x, Layers] = img_data[0].shape #Get the dimensions of the data
    size = img_data[0].size #Get the number elements in an image
    RGB_size = Res_x*Res_y
    Num_of_images = len(img_data) #Get the number of images in the directory
    
    # Create and Preallocate General Size
    inputData = np.zeros((RGB_size*3,1))
    inputTemp = np.zeros((RGB_size*3,1))
    
    for i in range(Num_of_images):
        if i == 0:
            R = np.reshape((img_data[i])[:,:,0], (Res_x*Res_y,1)) #Red Column Vector
            G = np.reshape((img_data[i])[:,:,1], (Res_x*Res_y,1)) #Green Column Vector
            B = np.reshape((img_data[i])[:,:,2], (Res_x*Res_y,1)) #Blue Column Vector
            inputTemp = np.r_[R[:,0],G[:,0],B[:,0]]       #Flatten list (same as ravel func)
            inputData = np.reshape(inputTemp, (Res_x*Res_y*3,1))   #format for [2352,1]
        else:       
            R = np.reshape((img_data[i])[:,:,0], (Res_x*Res_y,1)) #Red Column Vector
            G = np.reshape((img_data[i])[:,:,1], (Res_x*Res_y,1)) #Green Column Vector
            B = np.reshape((img_data[i])[:,:,2], (Res_x*Res_y,1)) #Blue Column Vector
            inputTemp = np.r_[R[:,0],G[:,0],B[:,0]]       #Flatten list (same as ravel func)
            inputTemp = np.reshape(inputTemp, (Res_x*Res_y*3,1))   #format for [2352,1]
            inputData = np.hstack([inputData, inputTemp]) #add the new row vector
    
    
    
    inputData = np.vstack([inputData, key]) #add key as a column to the end of inputData
    inputData = inputData[:, np.random.permutation(inputData.shape[1])] #suffle columns
    key = inputData[size,:] #save the new key corresponding to the shuffled data
    key = np.reshape(key[:,], (Num_of_images,1)) # define key as column vector
    inputData=np.delete(inputData,size,0) #remove the key from the last row of inputData  
    #inputData = np.array(inputData, dtype=np.uint8) #typecast to uint8
    inputData = np.transpose(inputData) #output data as [100, 2352]
    
   
    #Save Data To Text File
    np.savetxt((filepath+'a'+FeatureName+'.text'), inputData, fmt='%d',delimiter=' ')
    np.savetxt((filepath+'akey.text'), key, fmt='%d',delimiter=' ')
    np.savetxt((filepath+'aReadMe.text'),(Res_x, Res_y,RGB_size,RGB_size*3,Num_of_images),fmt='%d', delimiter=' ', header ="#_of_columns \n#_of_rows \n#_of_pixels \n#_of_input_nodes \n#_of_images" )
 
    del inputTemp, image, img_data, R, G, B, inputData, key #clear from memory
    
#-----------------------------End of Function----------------------------------
    
  
#============Uncomment For Saving Learning Data

img_list2array('./Batches/Learning/Empty/', 'Empty', 0)
print("Saved Empty")
img_list2array('./Batches/Learning/Mixed/', 'Mixed', 1)
print("Saved Mixed");
img_list2array('./Batches/Learning/Orange_Clownfish/', 'Orange_Clownfish', 2)
print("Saved Orange Clownfish");   
img_list2array('./Batches/Learning/Shrimp/', 'Shrimp', 3)
print("Saved Shrimp")
img_list2array('./Batches/Learning/Wrasse/', 'Wrasse', 4)
print("Saved Wrasse")


#============Uncomment For Saving Testing Data

img_list2array('./Batches/Testing/Empty/', 'Empty', 0)
print("Saved Empty")
img_list2array('./Batches/Testing/Mixed/', 'Mixed', 1)
print("Saved Mixed");
img_list2array('./Batches/Testing/Orange_Clownfish/', 'Orange_Clownfish', 2)
print("Saved Orange Clownfish");   
img_list2array('./Batches/Testing/Shrimp/', 'Shrimp', 3)
print("Saved Shrimp")
img_list2array('./Batches/Testing/Wrasse/', 'Wrasse', 4)
print("Saved Wrasse")


#============Uncomment For Saving Verification Data

img_list2array('./Batches/Verification/Empty/', 'Empty', 0)
print("Saved Empty")
img_list2array('./Batches/Verification/Mixed/', 'Mixed', 1)
print("Saved Mixed");
img_list2array('./Batches/Verification/Orange_Clownfish/', 'Orange_Clownfish', 2)
print("Saved Orange Clownfish");   
img_list2array('./Batches/Verification/Shrimp/', 'Shrimp', 3)
print("Saved Shrimp")
img_list2array('./Batches/Verification/Wrasse/', 'Wrasse', 4)
print("Saved Wrasse")






