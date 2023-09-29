doc = """

Usage:
    create_DomData.jl DETECTOR RUN LENGTH [-s STORAGEPATH] [-l SLICELEGTH]
    create_DomData.jl -h | --help
    create_DomData.jl --version

Options:
  -l SLICELENGTH            The amount of Summaryslices compressed to one new Datapoint [default: 6000]
  -s STORAGEPATH            The Storagepath for the h5 Output-files [default: ../Data/DomData_Runs]
  -h --help                 Show this screen.
  --version                 Show version.

"""

using DocOpt
const args = docopt(doc, version=v"2.0.0")

using KM3io
using Glob
using ToolBox

function main()
    loadpath = "/home/wecapstor3/capn/mpo1217/km3net/KM3NeT_00000133"
    storagepath = string("../Data/Runs_sl",Int32(parse(Int32,args["-l"])/600),"Min")
    detector = Detector(args["DETECTOR"])
    Run_start = parse(Int32, args["RUN"])
    files = glob("*_S.root", loadpath)
    for i in (0:(parse(Int32,args["LENGTH"])-1))
        if string(loadpath,"/KMeNeT_00000133_000",(Run_start+i),"_S.root") in files
            DomData(Run_start+i, detector, loadpath, storagepath, slice_length=parse(Int32, args["-l"]))
        end
    end
end

main()