nt = (
    name="chart",
    data=3,
    transform=(;filter="a"),
    mark=:bar,
    encoding=(
        x=:x,
        y=(field=:y, type=:quantitative)
    )
)

@testset "test spec" begin
    @test spec(nt) == Deneb.Spec(nt)
    @test spec(; nt...) == Deneb.Spec(nt)
end

@testset "test vlspec" begin
    s = Deneb.VegaLiteSpec(; nt...)
    @test vlspec(nt) == s
    @test vlspec(; nt...) == s
    @test vlspec(spec(nt)) == s
    @test vlspec(s) == s
end

@testset "test Mark" begin
    @test Mark(a=3) isa Deneb.MarkSpec
    @test rawspec(Mark(a=3).a) == 3
    @test Mark(:bar, tooltip=true) isa Deneb.MarkSpec
    @test rawspec(Mark(:bar, tooltip=true)) == (type="bar", tooltip=true)
end

@testset "test Encoding" begin
    @test Encoding(a=3) isa Deneb.EncodingSpec
    @test rawspec(Encoding(a=3).a) == 3
    @test Encoding("a:q", x=(aggregate="mean",)) isa Deneb.EncodingSpec
    @test rawspec(Encoding("a:q", x=(aggregate="mean",))) == (;
        x = (aggregate = "mean", field = "a", type = "quantitative")
    )
    @test Encoding("a:q", "b:o", x=(aggregate="mean",)) isa Deneb.EncodingSpec
    @test rawspec(Encoding("a:q", "b:o", x=(aggregate="mean",))) == (
        x = (aggregate = "mean", field = "a", type = "quantitative"),
        y=(field = "b", type = "ordinal")
    )
    @test Encoding("count(a):q") isa Deneb.EncodingSpec
    @test rawspec(Encoding("mean(a):q")) == (;
        x = (aggregate = "mean", field = "a", type = "quantitative")
    )
    @test rawspec(Encoding("mean():q")) == (;
        x = (aggregate = "mean", type = "quantitative")
    )
    @test rawspec(Encoding(color=field("mean():q"))) == (;
        color = (aggregate = "mean", type = "quantitative")
    )
end

@testset "test Data" begin
    @test Data(3) isa Deneb.DataSpec
    @test Data(3).data == 3
    @test rawspec(Data(3)) == 3
    @test Data(url="url") isa Deneb.DataSpec
    @test Data(url="url").data == (;url="url")
end

# TODO: add tests for Facet, Repeat, Transform, Params...
