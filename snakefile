import os
from glob import glob
import re

detector = "KM3NeT_00000133_00014422.detx"
datadir = "/home/wecapstor3/capn/mpo1217/km3net/KM3NeT_00000133"
filepaths = glob(f"{datadir}/*_S.root")
def extract_runnumbers(filepaths):
        for filepath in filepaths:
                m = re.search(r"KM3NeT_\d{8}_(\d{8})_S.root", filepath)
                if m:
                        yield int(m[1])

runs2 = list(extract_runnumbers(filepaths))
runs = runs2[100:150]



rule all:
    input: expand("../Data/DomData_Runs/{n}_10.h5", n=runs2)


rule extractData:
    input: os.path.join(datadir, "KM3NeT_00000133_000{run}_S.root")
    output: "../Data/DomData_Runs/{run}_10.h5"
    shell:
        """
        julia --heap-size-hint=6000M TerminalScripts/DomData.jl KM3NeT_00000133_00014422.detx {input}
        """