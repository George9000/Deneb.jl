# ---
# cover: assets/grouped_bar_chart.png
# author: bruno
# description: Grouped Bar Chart
# ---

using Deneb
data = (
    category=collect("AAABBBCCC"),
    group=collect("xyzxyzxyz"),
    value=rand(9)
)
chart = Data(data) * Mark(:bar, tooltip=true) * Encoding(
    :category,
    "value:q",
    xOffset=(;field=:group),
    color=(;field=:group)
)

save("assets/grouped_bar_chart.png", chart)  #src

# !!! note "Version info"
#     The example above requires at least Vega v5.

# Using the column encoding:
Data(data) * Mark(:bar, tooltip=true) * Encoding(
    :group,
    "value:q",
    color=(;field=:group),
    column=(;field=:category),
)
