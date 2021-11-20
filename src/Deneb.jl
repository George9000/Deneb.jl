module Deneb

using JSON

include("spec_types.jl")
include("spec_api.jl")
include("render.jl")

export spec, vlspec,
    data, mark, encoding

end # module
