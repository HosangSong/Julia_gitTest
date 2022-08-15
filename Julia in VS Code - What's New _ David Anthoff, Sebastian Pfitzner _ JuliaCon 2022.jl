using DataFrames, RDatasets

# some small datasets

iris = dataset("datasets", "iris")
#neuro = dataset("boot", "neuro")
#Hsb82 = dataset("mlmRev", "Hsb82")

# medium-seize matrix
medium = rand(100_000, 3)

# large matrix
large = rand(1_000_000, 10)