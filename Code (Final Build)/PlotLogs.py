import numpy as np
import scipy
import os
import matplotlib.pyplot as plt

logpath_model1 = ((r'%s' % os.getcwd().replace('\\','/')) + '/Models/logs/training-2018-4-19_2_2_pltver.log')
model1 = np.loadtxt(logpath_model1, delimiter = ',')

epoch = model1[:,0]
training_acc = model1[:,1]
training_loss = model1[:,2]
verification_acc = model1[:,3]
verification_loss = model1[:,4]

plt.figure(1)
plt.subplot(211)
plt.plot(epoch, training_acc, 'b--', epoch, verification_acc, 'r--')
plt.grid(True)
plt.xlabel('NoEpochs')
plt.ylabel('Accuracy Value')
plt.title('Calculated Accuracy per Epoch Using Standard Gradient Descent Optimizer')
plt.axis([0, 5893, 0, 1])
plt.legend(('Training Accuracy','Verification Accuracy'))

plt.subplot(212)
plt.plot(epoch, training_loss, 'b--', epoch, verification_loss, 'r--')
plt.grid(True)
plt.xlabel('NoEpochs')
plt.ylabel('Loss Value')
plt.title('Calculated Loss per Epoch Using Standard Mean Square Error')
plt.xlim([0, 5893])
plt.ylim([0, 0.5])
plt.legend(('Training Loss','Verification Loss'))

plt.show()

print("Mean Training Accuracy", np.mean(training_acc))
print("Mean Traning Loss", np.mean(training_loss),'\n')
print("Mean Verification Accuracy", np.mean(verification_acc))
print("Mean Verification Loss", np.mean(verification_loss))

