doc = """

Usage:
    create_DomData.jl DOMID [-l SLICELEGTH]  [-s STORAGEPATH]  [-d DATAINPUT] 
    create_DomData.jl -h | --help
    create_DomData.jl --version

Options:
  -d DATAINPUT              The folder in which it looks for the DomData_Run files [default: ../Data]
  -l SLICELENGTH            The amount of Summaryslices compressed to one new Datapoint [default: 6000]
  -s STORAGEPATH            The Storagepath for the h5 Output-files [default: ../Data/DomData_Doms]
  -h --help                 Show this screen.
  --version                 Show version.

"""

#irgend ne gute möglichkeit direkt zu überprüfen ob die eingaben sinnvoll sind - bei l nur Int erlauben


using DocOpt
const args = docopt(doc, version=v"2.0.0")

using ToolBox

function main()
    DomData(parse(Int32, args["DOMID"]), string(args["-d"]), string(args["-s"]), slice_length=parse(Int64, args["-l"]))
end

main()

