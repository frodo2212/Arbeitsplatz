using GLMakie
using ToolBox
using KM3io
det = Detector("E:\\Forschungsarbeit\\Daten\\KM3NeT_00000133_00014422.detx")
Dom_Ids = optical_DomIds(det)

#allgemein ohne spezielle Daten
fig1 = ToolBox.plot_allDoms_3D(det)
fig3 = ToolBox.plot_closeDoms_3D(Dom_Ids[50], 60, det)
fig4 = ToolBox.plot_closeDoms_3D_interactive(Dom_Ids[50], det)

#linFit_Data
global_linfits = ToolBox.linfit_DomData(det, only_slopes=true)
global_linfits_tmp = deepcopy(global_linfits)
highest_linfits = ToolBox.Search_linFitData(det, 0.00007, mean_pmts=true)
[delete!(global_linfits_tmp, high_value.Dom_Id) for high_value in highest_linfits]

fig = ToolBox.plot_DomData_3D(global_linfits, det, valuetyp="slope of the mean frequencies")
fig2 = ToolBox.plot_DomData_3D(global_linfits_tmp, det, valuetyp="slope of the mean frequencies (without the extrema)")

 
#Mean_Data
Dom_means = ToolBox.DomData_Dom_mean(det)#, slice_length=6000)
PMT_means = ToolBox.DomData_PMT_mean(det)#, slice_length=6000)
Dom_highest_mean = Dict(i=>maximum(PMT_means[i]) for i in keys(PMT_means))
Dom_lowest_mean = Dict(i=>minimum(PMT_means[i]) for i in keys(PMT_means))

fig3 = ToolBox.plot_DomData_3D(Dom_means, det, valuetyp="mean frequencies")
fig2 = ToolBox.plot_DomData_3D(Dom_highest_mean, det, valuetyp="mean frequencies of pmt with highest f")
fig2 = ToolBox.plot_DomData_3D(Dom_lowest_mean, det, valuetyp="mean frequencies of pmt with lowest f")






#2D-Zeug
using CairoMakie
using ToolBox
using KM3io
det = Detector("E:\\Forschungsarbeit\\Daten\\KM3NeT_00000133_00014422.detx")
Dom_Ids = optical_DomIds(det)

#DomData_Floors
fig = ToolBox.plot_DomData_Floors(1)
#TODO: Da vielleichtauf ne bessere auswertungsmöglichkeit kommen

#Event_Data
Events = ToolBox.intSearch_DomData(det, (9000,20000), threshold=10)
high_PMTs = ToolBox.Search_DomData((10000,30000),(30,2000), slice_length=54000)

#linfit Intervalls Zeug
linfit_intervalls = ToolBox.load_linFitData_intervalls(Dom_Ids[12], pmt=12, return_Dict=true)
linfit_slopes = Dict(i=>linfit_intervalls[i][2] for i in keys(linfit_intervalls))
timesteps, params = ToolBox.load_linFitData_intervalls(Dom_Ids[12])
#TODO: Vorsicht die funktion existert nur mit CairoMakie
fig = ToolBox.plot_lf_Intervalls(Dom_Ids[12], pmt=[12,13,14])



function plot_sorrounding_Doms()
end