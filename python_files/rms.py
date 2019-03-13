#!/usr/bin/env python3

import sys
import math

def main():
    with open(sys.argv[1], 'r') as ref_file, open(sys.argv[2], 'r') as output_file:
        tmp = 0
        counter = 0
        for r, o in zip(ref_file, output_file):
            tmp += (float(r.strip()) - float(o.strip())) ** 2
            counter += 1

        rms = math.sqrt( tmp / counter )

    print('RMS: {}'.format(rms))

if __name__ == '__main__':
    main()
