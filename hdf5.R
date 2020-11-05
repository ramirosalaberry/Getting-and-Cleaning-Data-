#install.packages("hdf5r")
source("http://bioconductor.org/biocLite.R")
biocLite("rhdf5") # se instala con bioconductor manager
created = h5createFile("example.h5")
created
created=h5createGroup('example.h5', 'foo')
created=h5createGroup('example.h5', 'baa')
created=h5createGroup('example.h5', 'foo/foobaa')
h5ls('example.h5')