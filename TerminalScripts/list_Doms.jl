doc = """

Usage:
    list_Doms.jl DETECTOR [-s STORAGEPATH]
    list_Doms.jl -h | --help
    list_Doms.jl --version

Options:
  -s STORAGEPATH            add a Storagepath for the file [default: ]
  -h --help                 Show this screen.
  --version                 Show version.

"""

using DocOpt
const args = docopt(doc, version=v"2.0.0")

using DelimitedFiles
using ToolBox
using KM3io
function main()
    detector = Detector(args["DETECTOR"])
    doms = ToolBox.optical_DomIds(detector)
    println(args["-s"])
    open(string(args["-s"],"Dom_Ids.txt"), "w") do file
      writedlm(file, doms)
    end
end
main()