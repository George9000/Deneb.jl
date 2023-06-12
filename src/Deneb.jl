module Deneb

using UUIDs
using NodeJS_16_jll
using JSON, Tables
using MultilineStrings: indent

const SymbolOrString = Union{Symbol, AbstractString}

include("types.jl")
include("api.jl")
include("render.jl")
include("composition.jl")
include("themes.jl")

export
    # api
    spec, vlspec,
    Data, Mark, Encoding, Transform, Params, Facet, Repeat,
    field, layout, projection,
    interactive, condition, condition_test,
    resolve, resolve_scale, resolve_axis, resolve_legend,
    # composition
    concat,
    # render
    save, # json, html,
    # themes
    set_theme!, print_theme

end # module
