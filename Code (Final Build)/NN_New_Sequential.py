#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Clear all variables. Fix issue with Thonny & Spyder IDE
import sys
sys.modules[__name__].__dict__.clear()
#===========================================================

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
import keras
from keras.models import Sequential
from keras.layers import Activation, Flatten, Dense
from keras.preprocessing.image import ImageDataGenerator
from keras import optimizers, applications
from keras.models import Model
from keras.utils import to_categorical
from keras.callbacks import ModelCheckpoint, CSVLogger
from keras.models import load_model
from keras.backend.tensorflow_backend import _get_available_gpus, set_session

import numpy as np
import os
import platform
import datetime
import matplotlib.pyplot as plt
import tensorflow as tf
from tensorflow.python.client import device_lib
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

## =========================== User Parameters ============================
Res_x = 128 # number of columns of pixels 
Res_y = 96  # number of rows of pixels

FeatureName = 'Empty','Mixed','Orange_Clownfish','Shrimp','Wrasse'

NoEpochs = 100000
BatchSize = 100

## =========================== Backend Control =============================
keras.backend.set_floatx('float16')
print('Checking Keras Backend:', keras.backend.floatx()) # Check for float16

## ======================== Print Software Version =========================
print("\nPython Version:", platform.python_version()) #print python version
print("Tensorflow Version:", tf.__version__)          #print tensorflow version
print("GPU Available to Keras:",_get_available_gpus(),'\n')
print(device_lib.list_local_devices())                #print CPUs/GPUs on Bus
print('---------------------------------------------------------------')

## ============================ GPU Control ================================
config = tf.ConfigProto()
config.gpu_options.per_process_gpu_memory_fraction = 0.99 #Percentage of GPU max usage
config.gpu_options.visible_device_list = "0"              #Select GPU 
set_session = tf.Session(config=config)                   #Set Session

## ------------------------- Import Time Stamp ----------------------------
now = datetime.datetime.now()

## ============================ Load Data ==================================
# ~~~~~~~~~~~~~~~~Learning

## ========================= Define Keras Model ============================
#---------------Path Names
import_filepath = ('/Batches/Learning',
                   '/Batches/Testing',
                   '/Batches/Verification')
modelpath = ((r'%s' % os.getcwd().replace('\\','/')) + '/Models/' + 'Fish_Imaging_Model.h5')

logpath = ((r'%s' % os.getcwd().replace('\\','/')) + '/Models/logs/' + 'training-' +
             str(now.year) +'-'+ str(now.month) + '-' + str(now.day) + '_' +
             str(now.hour) + '_' + str(now.minute) + '.log')

learn_dir = (r'%s' % os.getcwd().replace('\\','/')) + import_filepath[0]
test_dir = (r'%s' % os.getcwd().replace('\\','/')) + import_filepath[1]
ver_dir = (r'%s' % os.getcwd().replace('\\','/')) + import_filepath[2]


# ========================= Feed In Data PNG ==============================
#------------ Editing of Image
dataset = ImageDataGenerator(rescale = 1.0/255) #scale uint8 pixel values as float

#------------ Feed Learning
x_learn = dataset.flow_from_directory(
    learn_dir,
    target_size=(Res_x, Res_y),
    color_mode = 'rgb',
    classes = ['Empty','Mixed','Orange_Clownfish', 'Shrimp', 'Wrasse'],
    class_mode = 'categorical',
    batch_size = BatchSize )   

#------------ Feed Testing
x_test = dataset.flow_from_directory(
    test_dir,
    target_size=(Res_x, Res_y),
    color_mode = 'rgb',
    classes = ['Empty','Mixed','Orange_Clownfish', 'Shrimp', 'Wrasse'],
    class_mode = 'categorical',
    batch_size = BatchSize )   

#----------- Feed Verification
x_ver = dataset.flow_from_directory(
    ver_dir,
    target_size=(Res_x, Res_y),
    color_mode = 'rgb',
    classes = ['Empty','Mixed','Orange_Clownfish', 'Shrimp', 'Wrasse'],
    class_mode = 'categorical',
    batch_size = BatchSize )

# ====================== Define Sequential Model =======================
model = Sequential()
model.add(Flatten(input_shape=(128,96,3))) # make 1D aray from 3D
model.add(Dense(10000, activation = 'relu'))
model.add(Dense(8000, activation = 'relu'))
model.add(Dense(8000, activation = 'relu'))
model.add(Dense(4000, activation = 'relu'))
model.add(Dense(4000, activation = 'relu'))
model.add(Dense(2000, activation = 'relu'))
model.add(Dense(500, activation = 'relu'))
model.add(Dense(5, activation = 'sigmoid'))

# ===================== Define Evaulation Metrics ======================
model.compile(loss='mean_squared_error',
              optimizer='SGD',
              metrics=['accuracy'])

#---------------Logging Data
logger = keras.callbacks.CSVLogger(logpath)

#---------------Checkpoint Settings
checkpoint=ModelCheckpoint(modelpath,
                           monitor='val_acc',
                           verbose=0,
                           save_best_only=False,
                           save_weights_only=False,
                           mode='max',
                           period=50) #Save Checkpoint every n'th epoch

#--------------Learn Data
model.fit_generator(
    x_learn,
    steps_per_epoch = 50,
    epochs = NoEpochs,
    verbose = 2,
    callbacks=[checkpoint, logger],
    validation_data = x_test,
    validation_steps = 20,
    shuffle = True)

#validation_data = x_test,
#validation_steps = 20,
#--------------Testing Data
[t_loss, t_acc] = model.evaluate_generator(x_test)

#--------------Verification Data
v_array = model.predict_generator(
    x_ver,
    verbose = 1)

#--------------Display Testing and Verification Results
print('\nTesting Loss:',t_loss)
print('Testing_accuracy:',t_acc)
print('\nVerification Results:')
print(v_array)

# ========================== Export Model ============================
model.save(modelpath)    
    
    


