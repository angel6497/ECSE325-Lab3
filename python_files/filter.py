#!/usr/bin/env python3

import sys
import numpy as np

def main():
    with open(sys.argv[1], 'r') as input_file, open(sys.argv[2], 'r') as coeff_file, open('filter_output.txt', 'w') as filter_output:
        coeffs = np.array([float(x) for x in coeff_file])
        registers = np.array([0.0] * 25)
        for i in input_file:
            registers = np.roll(registers, 1)
            registers[0] = float(i)
            registers *= (2 ** 15)
            registers = np.round(registers)
            registers /= (2 ** 15)
            #registers = np.round(registers, decimals=1)
            ret = np.sum( coeffs * registers )
            ret *= (2 ** 15)
            ret = round(ret)
            ret /= (2 ** 15)
            ret = np.round(ret, decimals=1)
            filter_output.write('{}\n'.format(ret))

if __name__ == '__main__':
    main()
