#!/usr/bin/env python3

import sys
import numpy as np
from bitstring import Bits

word_length = int(sys.argv[2])
frac_length = int(sys.argv[3])

def main():
    with open(sys.argv[1], 'r') as input_file, open('output_decimal.txt', 'w') as output_file:
        for n in input_file:
            n = n.strip()
            num = Bits(bin=n[:word_length-frac_length]).int
            frac = compute_frac(n[word_length-frac_length:])
            tmp = num + frac
            output_file.write('{}\n'.format(tmp))

def compute_frac(bin_frac):
    dec_frac = 0
    for i in range(len(bin_frac)):
        dec_frac += (1 / (2 ** (i+1))) * int(bin_frac[i])
    return float(dec_frac)

if __name__ == '__main__':
    main()
