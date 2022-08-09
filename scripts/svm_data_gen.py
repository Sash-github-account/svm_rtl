# -*- coding: utf-8 -*-
"""
Created on Thu Jul 28 23:07:22 2022

@author: nsash
"""

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



def wr_dp(fp, dp):
    for d in dp:
        #print(d)
        wr = d + '\n'
        fp.write(wr)

def wr_prog_file(dp):
    
    fp = open("bin_file", 'a')
      
    for data in dp:
        sp_dp1 = (data[0][0:8], data[0][8:16], data[0][16:24], data[0][24:32])
        print(sp_dp1)
        wr_dp(fp, sp_dp1)
        sp_dp2 = (data[1][0:8], data[1][8:16], data[1][16:24], data[1][24:32])
        wr_dp(fp, sp_dp2) 
        if len(data) > 2:
            sp_dp3 = (data[2][0:8], data[2][8:16], data[2][16:24], data[2][24:32])
            wr_dp(fp, sp_dp3)
        
    fp.close()

# Driver Code
if __name__ == "__main__" :
    x = [1, 5, 1.5, 8, 1, 9, 7, 8.7, 2.3, 5.5, 7.7, 6.1]  
    y = [2, 8, 1.8, 8, 0.6, 11, 10, 9.4, 4, 3, 8.8, 7.5]
    
    w =  [0.1332713 , 0.42667492, -3.01308577]
    

    w_bin = []
    dp_bin = []
    for i in range(len(x)):
        x_bin =(IEEE754(float(x[i]))[1])
        print(IEEE754(float(x[i]))[0])
        y_bin = (IEEE754(float(y[i]))[1])
        print(IEEE754(float(y[i]))[0])
        dp_bin.append((x_bin, y_bin))
        #print(dp_bin[i])
        
    for i in range(len(w)):
        win = IEEE754(w[i])
        print(win[0])
        w_bin.append(win[1])
    print("weigths")
    print(w_bin)
        
    
    wr_prog_file(dp_bin)
    fp = open("bin_file", 'a')
    wr_dp(fp, ('weigths',))
    fp.close()
    wr_prog_file([tuple(w_bin)])    
        
        