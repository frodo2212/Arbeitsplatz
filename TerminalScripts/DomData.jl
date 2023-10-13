doc = """

Usage:
    create_DomData.jl DETECTOR DATAINPUT [-s STORAGEPATH] [-l SLICELEGTH]
    create_DomData.jl -h | --help
    create_DomData.jl --version

Options:
  -l SLICELENGTH            The amount of Summaryslices compressed to one new Datapoint [default: 6000]
  -s STORAGEPATH            The Storagepath for the h5 Output-files [default: ../Data]
  -h --help                 Show this screen.
  --version                 Show version.

"""

#irgend ne gute möglichkeit direkt zu überprüfen ob die eingaben sinnvoll sind - bei l nur Int erlauben
#-s Storagepath wird im Moment nicht beachtet


using DocOpt
const args = docopt(doc, version=v"2.0.0")

using KM3io
using ToolBox

function main()
    detector = Detector(args["DETECTOR"])
    sl = parse(Int32, args["-l"])
    Data(args["DATAINPUT"], detector, string("../Data/Runs_sl",Int32(sl/600),"Min"), slice_length=sl)
    print(string("Runs", args["DATAINPUT"], "finished"))
end

main()