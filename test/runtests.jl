using Test, Documenter, LinearAlgebraForCAP

# test upto whitespaces
doctest(LinearAlgebraForCAP; doctestfilters=[r"\s+" => ""])
