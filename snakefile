import os
from glob import glob
import re

slice_length = 6000  #das hier irgendwie als Argument übergeben


detector = "KM3NeT_00000133_00014422.detx"
datadir = "/home/wecapstor3/capn/mpo1217/km3net/KM3NeT_00000133"
filepaths = glob(f"{datadir}/*_S.root")
def extract_runnumbers(filepaths):
        for filepath in filepaths:
                m = re.search(r"KM3NeT_\d{8}_(\d{8})_S.root", filepath)
                if m:
                        yield int(m[1])

runs = list(extract_runnumbers(filepaths))
length_min = int(slice_length/600)


rule all:
    input: expand("../Data/Runs_sl{length_min}Min/{n}_10.h5", n=runs)


rule extractData:
    input: os.path.join(datadir, "KM3NeT_00000133_000{run}_S.root")
    output: "../Data/Runs_sl{length_min}Min/{run}_10.h5"
    shell:
        """
        julia --heap-size-hint=6000M TerminalScripts/DomData.jl KM3NeT_00000133_00014422.detx {input} -l={slice_length}
        """