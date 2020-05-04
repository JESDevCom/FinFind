#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
@author: John Schulz
Created on Tue Apr 10 23:50:00 2018
Class: ECE 468
Description: Final Project - Fish Identification
"""
#+++++++++++++++++++++++++++++++++++++++++++++++
# Clear all variables. Fix issue with Thonny IDE
import sys
sys.modules[__name__].__dict__.clear()
#==============================================

import keras
from keras.engine import Input, Model
from keras.layers import Dense
from keras.utils import to_categorical
from keras.callbacks import ModelCheckpoint, CSVLogger
from keras.backend.tensorflow_backend import _get_available_gpus, set_session
from keras.models import load_model

import numpy as np
import os
import platform
import datetime
import matplotlib.pyplot as plt
import tensorflow as tf
from tensorflow.python.client import device_lib

now = datetime.datetime.now() #get date and time for data writing

## =========================== Backend Control =============================
keras.backend.set_floatx('float16')
print('Checking Keras Backend:', keras.backend.floatx()) # Check for float16

## ======================== Print Software Version =========================
print("\nPython Version:", platform.python_version()) #print python version
print("Tensorflow Version:", tf.__version__)          #print tensorflow version
print("GPU Available to Keras:",_get_available_gpus(),'\n')
print(device_lib.list_local_devices())
print('---------------------------------------------------------------')

## ============================ GPU Control ================================
config = tf.ConfigProto()
config.gpu_options.per_process_gpu_memory_fraction = 0.99 #Percentage of GPU max usage
config.gpu_options.visible_device_list = "0"              #Select GPU 
set_session = tf.Session(config=config)                   #Set Session

## =======================+++ File Paramters +++============================
# Learning/Training/Verification
# Micro or Mega Batches
# Micro less than 1000 (Learning) and Mega less than 10000 (Learning)
import_filepath = ('/BatchesText/Learning/Micro_Batches/',
                   '/BatchesText/Testing/Micro_Batches/',
                   '/BatchesText/Verification/Micro_Batches/',
                   '/Batches/Learning/Mega_Batches/',
                   '/Batches/Testing/Mega_Batches/',
                   '/Batches/Verification/Mega_Batches/')

BatchName = 'MB_'
KeyName =   'key_'
FeatureName = 'Empty','Mixed','Orange_Clownfish','Shrimp','Wrasse'
MB_n = 1    #which Batch file do you want to read MB_<MB_n> ?
M_uC = 0    #which Batch directory Mega (3) or Micro (0) ?
NoEpochs = 2
## ============================ Load Data ==================================
# ~~~~~~~~~~~~~~~~Learning
Batchpath = ((r'%s' % os.getcwd().replace('\\','/')) + import_filepath[0+M_uC] + BatchName + str(MB_n) + '.text')
Keypath = ((r'%s' % os.getcwd().replace('\\','/')) + import_filepath[0+M_uC] + KeyName + str(MB_n) + '.text')
x_learn = np.loadtxt(Batchpath, delimiter = ' ')/255
y_learn = to_categorical(np.loadtxt(Keypath  , delimiter = ' '))
print("\nx_learning:",x_learn.shape, '@',Batchpath)
print("y_learning:",y_learn.shape, '@', Keypath)

# ~~~~~~~~~~~~~~~~Testing
Batchpath = ((r'%s' % os.getcwd().replace('\\','/')) + import_filepath[1+M_uC] + BatchName + str(MB_n) + '.text')
Keypath = ((r'%s' % os.getcwd().replace('\\','/')) + import_filepath[1+M_uC] + KeyName + str(MB_n) + '.text')
x_test = np.loadtxt(Batchpath, delimiter = ' ')/255
y_test = to_categorical(np.loadtxt(Keypath  , delimiter = ' '))
print("\nx_testing:",x_test.shape, '@', Batchpath)
print("y_testing:",y_test.shape, '@', Keypath)

# ~~~~~~~~~~~~~~~Verification
Batchpath = ((r'%s' % os.getcwd().replace('\\','/')) + import_filepath[2+M_uC] + BatchName + str(MB_n) + '.text')
Keypath = ((r'%s' % os.getcwd().replace('\\','/')) + import_filepath[2+M_uC] + KeyName + str(MB_n) + '.text')
x_ver  = np.loadtxt(Batchpath, delimiter = ' ')/255
y_ver = np.reshape(np.loadtxt(Keypath, delimiter = ' '), (x_ver.shape[0],1))
print("\nx_verification:",x_ver.shape, '@',Batchpath)
print("y_verification:",y_ver.shape, '@',Keypath,'\n')

## ====================== Dependednt Parameters ===========================
NoLabels = len(FeatureName)     # number of output nodes
NoInputs = x_learn.shape[1]     # number of input nodes
BatchSize  = len(y_learn)
 
 
## ========================= Define Keras Model ===========================
#---------------Path Names
modelpath = ((r'%s' % os.getcwd().replace('\\','/')) + '/Models/' + 'Fish_Imaging_Model.h5')

modelpath_unique = ((r'%s' % os.getcwd().replace('\\','/')) + '/Models/' + 'model-' +
             str(now.year) +'-'+ str(now.month) + '-' + str(now.day) + '_' +
             str(now.hour) + '_' + str(now.minute) + '.hdf5')

logpath = ((r'%s' % os.getcwd().replace('\\','/')) + '/Models/logs/' + 'training-' +
             str(now.year) +'-'+ str(now.month) + '-' + str(now.day) + '_' +
             str(now.hour) + '_' + str(now.minute) + '.log')

#---------------Define Layers
inputs = keras.layers.Input(shape=(36864,), dtype='float16')
hidden1 = keras.layers.Dense(10000, activation='relu')(inputs)
hidden2 = keras.layers.Dense(8000, activation='relu')(hidden1)
hidden3 = keras.layers.Dense(8000, activation='relu')(hidden2)
hidden4 = keras.layers.Dense(2000, activation='relu')(hidden3)
hidden5 = keras.layers.Dense(2000, activation='relu')(hidden4)
hidden6 = keras.layers.Dense(500, activation='relu')(hidden5)
output = keras.layers.Dense(5, activation = 'sigmoid')(hidden6)

#---------------Create Model
model = keras.models.Model([inputs],[output])
model.compile(loss='mean_squared_error',optimizer='sgd',metrics=['accuracy'])

#---------------Logging Data
logger = keras.callbacks.CSVLogger(logpath)

#---------------Checkpoint Settings
checkpoint=ModelCheckpoint(modelpath,
                           monitor='val_acc',
                           verbose=0,
                           save_best_only=False,
                           save_weights_only=False,
                           mode='max',
                           period=10) #Save Checkpoint every n'th epoch

#--------------Run Model Settings
model.fit([x_learn],
          [y_learn],
          epochs=NoEpochs,
          verbose=2,
          callbacks=[checkpoint,logger])

#--------------Testing Update Model
model.train_on_batch([x_test],[y_test]) #Single Gradient Update

#--------------Verification Prediction
y_prediction=model.predict([x_ver])
data = np.zeros((y_prediction.shape[0], (y_prediction.shape[1]) + 1))
data[:,0:5] = np.around(y_prediction)
data[:,5:6] = y_ver
print(data)
out_stat = model.test_on_batch([x_ver],to_categorical(y_ver))
print("-------------------Verification Results--------------------")
print('Loss:',out_stat[0],'\nAccuracy:',out_stat[1]);

#-------------Save Model After Finishing
model.save(modelpath) #Saving again for testing data 
























