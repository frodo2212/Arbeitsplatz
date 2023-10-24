using GLMakie
using ToolBox
using KM3io: Detector

function main()
    det = Detector("E:\\Forschungsarbeit\\Daten\\KM3NeT_00000133_00014422.detx")
    Data = ToolBox.DomData_Dom_mean(det)
    fig = ToolBox.plot_Doms_3D(Data, det)
    wait(display(fig))


end 
main()