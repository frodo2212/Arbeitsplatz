doc = """

Usage:
    create_DomData.jl START END [-s STORAGEPATH] [-l SLICELEGTH]
    create_DomData.jl -h | --help
    create_DomData.jl --version

Options:
  -l SLICELENGTH            The amount of Summaryslices compressed to one new Datapoint [default: 6000]
  -s STORAGEPATH            The Storagepath for the h5 Output-files [default: ../Data/DomData_Doms]
  -h --help                 Show this screen.
  --version                 Show version.

"""

#irgend ne gute möglichkeit direkt zu überprüfen ob die eingaben sinnvoll sind - bei l nur Int erlauben


using DocOpt
const args = docopt(doc, version=v"2.0.0")

using ToolBox
using DelimitedFiles

function main()
    Doms = readdlm("Dom_Ids.txt", Int64)[:,1]
    slice_length = parse(Int32, args["-l"])
    for i in (parse(Int32, args["START"]):parse(Int32, args["END"]))
      DomData(Doms[i], string(args["-s"]), slice_length=slice_length)
    end
    open(string("../Data/DomData_Doms/result",args["START"],"_",args["END"],".txt"), "w") do file
      write(file, '0')
    end
end

main()