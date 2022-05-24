#!/usr/bin/python

import sys, getopt
import pandas as pd
def main(argv):
    rfile = ''
    sfile = ''
    ofile = ''
    try:
        opts, args = getopt.getopt(argv,"r:s:o:",["rfile=","sfile=","ofile="])
    except getopt.GetoptError:
        print('combstats.py -r <rfile> -s <sfile> -o <ofile> ')
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print('combstats.py -r <rfile> -s <sfile> -o <ofile>')
            sys.exit()
        elif opt in ("-r", "--rfile"):
            rfile = arg
        elif opt in ("-s", "--sfile"):
            sfile = arg
        elif opt in ("-o", "--ofile"):
            ofile = arg
            print("Fffd")
    ref= pd.read_csv(rfile, sep='\t',header=[0])
    shf= pd.read_csv(sfile, sep='\t',header=[0])
    out = ref.set_index('statistic').add(shf.set_index('statistic'), fill_value=0)
    out.to_csv(ofile, sep='\t')
    print(out.head())
    print(ref.head())
    print(shf.head())
if __name__ == "__main__":
   main(sys.argv[1:])