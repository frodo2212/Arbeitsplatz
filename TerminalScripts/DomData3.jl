doc = """

Usage:
    create_DomData.jl DETECTOR DATAINPUT RUNS [-s STORAGEPATH] [-l SLICELEGTH]
    create_DomData.jl -h | --help
    create_DomData.jl --version

Options:
  -l SLICELENGTH            The amount of Summaryslices compressed to one new Datapoint [default: 6000]
  -s STORAGEPATH            The Storagepath for the h5 Output-files [default: ../Data/DomData_Runs]
  -h --help                 Show this screen.
  --version                 Show version.

"""

#irgend ne gute möglichkeit direkt zu überprüfen ob die eingaben sinnvoll sind - bei l nur Int erlauben


using DocOpt
const args = docopt(doc, version=v"2.0.0")

using KM3io
using ToolBox
using Glob

function main()
    detector = Detector(args["DETECTOR"])
    runs = parse.(Int32, split(chop(args["RUNS"]; head=1, tail=1), ','))
    files = glob("*_S.root", args["DATAINPUT"]) 
    for filename in files
        Runnumber = parse(Int32, filename[collect(findlast("000", filename))[3]+1:collect(findlast("000", filename))[3]+5])
        if Runnumber in runs
            DomData(filename, detector, "../Data/DomData_Runs", slice_length=parse(Int32, args["-l"]))
        end
    end
end

main()