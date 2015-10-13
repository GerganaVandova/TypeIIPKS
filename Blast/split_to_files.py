#!/usr/bin/env python

# Usage: ./split_to_files.py < ACP.68.fasta

import sys

def main():
    f = None
    for line in sys.stdin:
        if line.startswith('>'):
            #filename = line.split(' ')[0][1:]
            #filename1 = line.split('|')[3]
            filename1 = line[1:].strip()
            filename2 = filename1.split(" ")[0]
            if ":" in filename2:
                gbid, coord = filename2.split(":")
                filename = "CyclaseSRPBCC" + gbid + "_" + coord + ".seq"
            else:
                # filename = "CyclaseSRPBCC" + filename2 + ".seq"
                filename = "ACP_" + filename2 + ".seq"
            if f:
                f.close()
            f = open(filename, 'w')
        f.write(line)
    f.close()


if __name__ == "__main__":
    main()
