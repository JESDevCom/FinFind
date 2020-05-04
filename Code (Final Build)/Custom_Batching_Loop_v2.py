#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# Author: John Schulz
# Created on Thu Apr 12 03:19:21 2018
# Class: ECE 468
# Title: Neural Network Project: Fish Identification

# ------------------------Packages--------------------------
import numpy as np  # Used for array manipulation
import os           # Used for getting filepaths
# ----------------------------------------------------------

"""
#=============================Batching_Loop====================================
# Description: 
# Receives the relative address to the batched .text/.csv files
# containing all the images for each feature. Then saves the randomly selected
# images in a user specified batch size to the destination export_filepath.
# All feature names must be entered. The user can select the number of images
# in the batches and the number of batches made. The values start and end
# refer to name of the batch file that will be saved. For example, if 
# Batch 1 already exists you will want the start value to be 2 as to not
# overwrite the existing Batch 1. A key matching the shuffled data is also
# saved as .text and .csv file extension.

# Start and End Values can be seen at:
# ./Batches/(Learning or Testing or Verification)/Micro_Batches

# @param import_filepath = Relative path string to the .text | .csv array file
#    Ex: './Batches/Learning/'
    
# @param ImportExt = '.csv' or '.text' file format being read
#   Ex: '.csv'
    
# @param export_filepath = Relative path string to the save location
#    Ex: './Batches/Learning/Micro_Batches/'
 
# @param ExportExt = '.csv' or '.text' file format being saved
#    Ex. '.csv'
   
# @param FeatureName  = tuple array of feature names
#    Ex: 'Empty','Mixed','Orange_Clownfish','Shrimp','Wrasse'
    
# @param BatchSize = integer of images in each batch
# @param Start = integer number to start creating
# @param End = integer number to end at when creating
#------------------------------------------------------------------------------
"""


def Batching_Loop(import_filepath, ImportExt, export_filepath, ExportExt ,FeatureName, BatchSize, Start, End):
    
    if(BatchSize < 21):
        print("Possible Error: BatchSize is to small")
        print("Errors can occur because not every feature is in the batch and each must")
    
    # Create Batch Numbered Start to End
    for loop in range(Start, End):

        # Print Batch Number To Console
        print("\n----------------Batch Number ", loop, "----------------")

        # Randomly Generate Array For Which A Feature Will Be Counted in 'BatchElement'
        ChooseArray = np.random.randint(len(FeatureName), size=(1, BatchSize))  # rand array range from 0 to 4

        # Used Store The Number of Images From Each Feature That Will Be Used
        BatchElement = np.zeros((1, len(FeatureName)), dtype=int)

        # Declare Arrays
        x_train = []
        y_train = []
        x_temp = []
        Row_Access = []

        # Count the number of instances for Features in this Batch               
        for x in range(BatchSize):

            if (ChooseArray[0, x] == 0):
                BatchElement[0, 0] = BatchElement[0, 0] + 1

            elif (ChooseArray[0, x] == 1):
                BatchElement[0, 1] = BatchElement[0, 1] + 1

            elif (ChooseArray[0, x] == 2):
                BatchElement[0, 2] = BatchElement[0, 2] + 1

            elif (ChooseArray[0, x] == 3):
                BatchElement[0, 3] = BatchElement[0, 3] + 1

            elif (ChooseArray[0, x] == 4):
                BatchElement[0, 4] = BatchElement[0, 4] + 1

 
        
        # Each Feature into Custom Batch
        del ChooseArray
        print("Starting Custom Batch")
        x_new = 0
        
        for i in range(len(FeatureName)):
        
            print("Loading Feature ",i)  
            del x_temp, Row_Access
            #Get Path to Current Directory + Saved Directory (Works on Mac and Windows)
            
            fullpath = ((r'%s' % os.getcwd().replace('\\','/')) + import_filepath + FeatureName[i] + '/a' + FeatureName[i] + ImportExt)
            x_temp = np.loadtxt((fullpath), delimiter = ' ', dtype=np.uint8)
            
            #Create Random Order of Images to Access in x_temp array
            Row_Access = np.random.randint(len(x_temp), size=(BatchElement[0,i],1), dtype=np.uint16)
            print("Done Loading ",i,"\n")
            
            
            if (i==0):
                #Preallocate
                x_train = np.zeros(shape = (BatchSize,(x_temp.shape[1])), dtype=np.uint8)
                y_train = np.zeros(shape = (BatchSize,1), dtype=np.uint8)
            
                for x in range(BatchElement[0,i]):
                    x_train[x,:] = x_temp[(Row_Access[x,0]) , :]
                    y_train[x,:] = i       
                    
            elif (i > 0):
                x_new = x_new + (x + 1)
                for x in range(BatchElement[0,i]):
                    x_train[x+x_new,:] = x_temp[(Row_Access[x,0]) , :]
                    y_train[x+x_new,:] = i  
        
                
        
        # Format Data for Output
        y_train = np.reshape(y_train, (BatchSize, 1))  # make it a column vector
        inputData = np.hstack([x_train, y_train])  # add key as a column to the end of inputData
        inputData = inputData[np.random.permutation(inputData.shape[0]), :]  # suhffle Images (ie. rows)

        size = x_train.shape[1]  # Get number of columns
        y_train = np.reshape(inputData[:, size], (BatchSize, 1))  # save the new key corresponding to the shuffled data

        inputData = np.delete(inputData, -1, axis=1)  # remove the key from the last row of inputData
        x_train = np.array(inputData, dtype=np.uint8)  # typecast to uint8
        y_train = np.array(y_train, dtype=np.uint8)  # typecast to uint8

        

        # Save Data To Text and CSV File
        fullpath = ((r'%s' % os.getcwd().replace('\\','/')) + export_filepath + 'MB_' + str(loop) + ImportExt)
        np.savetxt(fullpath, x_train, fmt='%d', delimiter=' ')
        
        fullpath = ((r'%s' % os.getcwd().replace('\\','/')) + export_filepath + 'key_' + str(loop) + ImportExt)
        np.savetxt(fullpath, y_train, fmt='%d', delimiter=' ')
        
        #fullpath = ((r'%s' % os.getcwd().replace('\\','/')) + export_filepath + 'MB_' + str(loop) + '.csv')
        #np.savetxt(fullpath, x_train, fmt='%d', delimiter=' ')
        
        #fullpath = ((r'%s' % os.getcwd().replace('\\','/')) + export_filepath + 'key_' + str(loop) + '.csv')
        #np.savetxt(fullpath, y_train, fmt='%d', delimiter=' ')
        
        fullpath = ((r'%s' % os.getcwd().replace('\\','/')) + export_filepath + 'ReadMe_' + str(loop) + ImportExt)
        np.savetxt(fullpath, (loop, BatchSize), fmt='%d', delimiter=' ', header="BatchNumber\nNumber_of_images")

        print("---------------Batch ", loop, " Exported---------------")
    return

## ==========================Parameters=========================##
Start = 2  # Start Creating Batch 1
End = 5  # End Creating Batch 5

FeatureNames = 'Empty', 'Mixed', 'Orange_Clownfish', 'Shrimp', 'Wrasse'

# ---------Learning
import_path = ('/Batches/Learning/')
export_path = ('/BatchesText/Learning/Mega_Batches/')
BatchSize = 1000   # Number of Images in a Batch
Batching_Loop(import_path, '.text', export_path, '.text',FeatureNames, BatchSize, Start, End)


#---------Testing
import_path = '/Batches/Testing/'
export_path = '/BatchesText/Testing/Mega_Batches/'
BatchSize = 200
Batching_Loop(import_path, '.text', export_path, '.text', FeatureNames, BatchSize, Start, End)


#---------Verification
import_path = '/Batches/Verification/'
export_path = '/BatchesText/Verification/Mega_Batches/'
BatchSize = 100
Batching_Loop(import_path, '.text', export_path, '.text', FeatureNames, BatchSize, Start, End)


##--------------------------------------------------------------##

