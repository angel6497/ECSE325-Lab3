#!/usr/bin/env python3

import sys
import numpy as np

word_length = int(sys.argv[2])
frac_length = int(sys.argv[3])

with open(sys.argv[1], 'r') as input_file, open('output_fixed_point.txt', 'w') as output_file:
    dec_nums = [float(x) for x in input_file.read().split()]
    for n in dec_nums:
        tmp = round( n * (2 ** frac_length) )
        tmp = np.binary_repr(tmp, word_length)
        output_file.write(tmp + '\n')
