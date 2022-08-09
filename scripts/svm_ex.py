# -*- coding: utf-8 -*-
"""
Created on Wed Jul 27 22:53:11 2022

@author: nsash

reference:
    1. https://www.freecodecamp.org/news/svm-machine-learning-tutorial-what-is-the-support-vector-machine-algorithm-explained-with-code-examples/
"""

import matplotlib.pyplot as plt
import numpy as np
from sklearn import svm



# Python program to convert a real value
# to IEEE 754 Floating Point Representation.
# Function for converting decimal to binary
def float_bin(my_number, places = 3):
	my_whole, my_dec = str(my_number).split(".")
	my_whole = int(my_whole)
	res = (str(bin(my_whole))+".").replace('0b','')

	for x in range(places):
		my_dec = str('0.')+str(my_dec)
		temp = '%1.20f' %(float(my_dec)*2)
		my_whole, my_dec = temp.split(".")
		res += my_whole
	return res



def IEEE754(n) :
	# identifying whether the number
	# is positive or negative
	sign = 0
	if n < 0 :
		sign = 1
		n = n * (-1)
	p = 30
	# convert float to binary
	dec = float_bin (n, places = p)

	dotPlace = dec.find('.')
	onePlace = dec.find('1')
	# finding the mantissa
	if onePlace > dotPlace:
		dec = dec.replace(".","")
		onePlace -= 1
		dotPlace -= 1
	elif onePlace < dotPlace:
		dec = dec.replace(".","")
		dotPlace -= 1
	mantissa = dec[onePlace+1:]

	# calculating the exponent(E)
	exponent = dotPlace - onePlace
	exponent_bits = exponent + 127

	# converting the exponent from
	# decimal to binary
	exponent_bits = bin(exponent_bits).replace("0b",'')

	mantissa = mantissa[0:23]

	# the IEEE754 notation in binary	
	final = str(sign) + exponent_bits.zfill(8) + mantissa

	# convert the binary to hexadecimal
	hstr = '0x%0*X' %((len(final) + 3) // 4, int(final, 2))
	return (hstr, final)


# linear data
X = np.array([1, 5, 1.5, 8, 1, 9, 7, 8.7, 2.3, 5.5, 7.7, 6.1])
y = np.array([2, 8, 1.8, 8, 0.6, 11, 10, 9.4, 4, 3, 8.8, 7.5])

# show unclassified data
plt.scatter(X, y)
plt.show()

# shaping data for training the model
training_X = np.vstack((X, y)).T
training_y = [0, 1, 0, 1, 0, 1, 1, 1, 0, 0, 1, 1]

# define the model
clf = svm.SVC(kernel='linear', C=1.0)

# train the model
clf.fit(training_X, training_y)

# get the weight values for the linear equation from the trained SVM model
w = clf.coef_[0]

# get the y-offset for the linear equation
a = -w[0] / w[1]

# make the x-axis space for the data points
XX = np.linspace(0, 13)

# get the y-values to plot the decision boundary
yy = a * XX - clf.intercept_[0] / w[1]

# plot the decision boundary
plt.plot(XX, yy, 'k-')

# show the plot visually
plt.scatter(training_X[:, 0], training_X[:, 1], c=training_y)
plt.legend()
plt.show()

coef = clf.coef_ # here the weights of the features will be stored