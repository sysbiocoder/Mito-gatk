#!/usr/bin/python

import sys, getopt
import pandas as pd
def main(argv):
    cfile = ''
    try:
        opts, args = getopt.getopt(argv,"c:",["cfile="])
    except getopt.GetoptError:
        print('get_cm.py -c <cfile> ')
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print('get_cm.py -c <cfile> ')
            sys.exit()
        elif opt in ("-c", "--cfile"):
            cfile = arg

            print("Fffd")
    con= pd.read_csv(cfile, sep='\t',header=[0])
    print(con.columns)
    a= con["Major Heteroplasmies Count"].values[0]
    sys.stdout.write(str(a))
    print(a)
    sys.exit(0)
  
if __name__ == "__main__":
   main(sys.argv[1:])