# License for this file: MIT (expat)
# Copyright 2021, DLR Institute of System Dynamics and Control

module ModiaPlot_GLMakie

# Constants
const headingSize = 10

const path = dirname(dirname(@__FILE__))   # Absolute path of package directory
const Version = "0.4.0"
const Date = "2022-02-03"

println("Importing ModiaPlot_GLMakie Version $Version ($Date) - this takes some time due to GLMakie import")

import ModiaResult
import Colors
import Measurements
import MonteCarloMeasurements
using  Unitful

using  GLMakie
include("$(ModiaResult.path)/src/plot.jl")

const showFigureStringInDiagram = true
const callDisplayFunction = true
const reusePossible = true

const Makie_Point2f = isdefined(GLMakie, :Point2f) ? Point2f : Point2f0    
include("$(ModiaResult.path)/src/makie.jl")


function showFigure(figureNumber::Int)::Nothing
    #println("... in showFigure")
    if haskey(figures, figureNumber)
        matrixFigure = figures[figureNumber]
        fig = matrixFigure.fig
        display(fig)
    else
        @warn "showFigure: figure $figureNumber is not defined."
    end    
    return nothing
end


function saveFigure(figureNumber::Int, fileName; kwargs...)::Nothing
    #println("... in saveFigure")
    if haskey(figures, figureNumber)
        fig = figures[figureNumber].fig
        fullFileName = joinpath(pwd(), fileName)
        println("... save plot in file: \"$fullFileName\"")
        save(fileName, fig; kwargs...)
        display(fig)
    else
        @warn "saveFigure: figure $figureNumber is not defined."
    end    
    return nothing
end


function closeFigure(figureNumber::Int)::Nothing
    #println("... in closeFigure")
    delete!(figures,figureNumber)
    if length(figures) > 0
        dictElement = first(figures)
        display(dictElement[2].fig)
    else
        fig = Figure()
        display(fig)
    end
    return nothing
end


"""
    closeAllFigures()

Close all figures.
"""
function closeAllFigures()::Nothing
    #println("... in closeAllFigures")
    if length(figures) > 0
        empty!(figures)
        fig = Figure()
        display(fig)
    end
    return nothing
end

end