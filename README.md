# docker-vrm-editor
Tool for creating Variable Resolution Mesh for NorESM/CESM


Docker container for running panoply netCDF, HDF and GRIB data viewer

```
docker run --rm -p 5800:5800 -v /opt/uio/data:/config quay.io/nordicesmhub/docker-vrm-editor:0.2.1
```

### Reference 

- Source code for the community Mesh Generation Toolkit: https://github.com/ESMCI/Community_Mesh_Generation_Toolkit
- The docker container is based on https://github.com/jlesage/docker-baseimage-gui
