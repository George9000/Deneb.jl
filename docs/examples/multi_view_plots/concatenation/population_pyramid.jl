# ---
# cover: assets/population_pyramid.png
# author: bruno
# description: Population Pyramid
# ---

using Deneb

data = Data(url="https://vega.github.io/vega-datasets/data/population.json")

base = Data(data) * Transform(
    filter="datum.year == 2000"
) * Transform(
    calculate="datum.sex == 2 ? 'Female' : 'Male'",
    as=:gender,
) * vlspec(
    config=(view=(;stroke=nothing),
    axis=(;grid=false))
)

left = Mark(:bar) * Transform(
    filter=field(:gender, equal=:Female),
) * Encoding(
    x=field(
        "sum(people)",
        title=:population,
        axis=(;format=:s),
        sort=:descending,
    ),
    y=field(:age, axis=nothing, sort=:descending),
    color=field(
        :gender,
        scale=(;range=["#675193", "#ca8861"]),
        legend=nothing,
    ),
) * vlspec(title=:Female)

right = Mark(:bar) * Transform(
    filter=field(:gender, equal=:Male),
) * Encoding(
    x=field(
        "sum(people)",
        title=:population,
        axis=(;format=:s),
    ),
    y=field(:age, axis=nothing, sort=:descending),
    color=field(:gender, legend=nothing),
) * vlspec(title=:Male)

middle = Mark(:text, align=:center) * Encoding(
    y=field("age:O", axis=nothing, sort=:descending),
    text="age:Q"
)

chart = base * [left middle right] * layout(spacing=0)

save("assets/population_pyramid.png", chart)  #src
