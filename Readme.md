# Build linux kernel meta packages

There are certain packages in Ubuntu Precise for which source packages exist, but the binaries have been lost to history.  This builds lost linux kernel meta packages for Precise.

# Build instructions

## Replibit-specific example

```sh
rm output/*

docker build \
    --build-arg version="3.13.0.100.91" \
    -t \
    build-precise-meta-kernel \
    .

docker run --rm -it -v "${PWD}/output:/out" build-precise-meta-kernel

# sed -i /^Distribution:/s/precise/rb-precise-alpha/ output/*.changes
# dput output/*
# scp output/* user@repository:/upload-location/
```

All packages built in the docker container will appear in the `output` directory.

