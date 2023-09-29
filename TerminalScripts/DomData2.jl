doc = """

Usage:
    create_DomData.jl DETECTOR DATAINPUT RUNA RUNB [-s STORAGEPATH] [-l SLICELEGTH]
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
using Glob
using ToolBox

function main()
    detector = Detector(args["DETECTOR"])
    files = glob("*_S.root", args["DATAINPUT"]) 
    for filename in files
        Runnumber = parse(Int32, filename[collect(findlast("000", filename))[3]+1:collect(findlast("000", filename))[3]+5])
        if Runnumber >= Int64(args["RUNA"]) && Runnumber <= Int64(args["RUNB"])
            DomData(filename, detector, "../Data/DomData_Runs", slice_length=parse(Int32, args["-l"]))
        end
    end
end

main()