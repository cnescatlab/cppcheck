# Docker image for Cppcheck

This project aims to provide a simple Docker image to encapsulate and run a [Cppcheck](https://github.com/danmar/cppcheck) analysis through Docker.

### Run Cppcheck

#### Get latest image
Images are now hosted directly on GitHub:
```Dockerfile
docker pull ghcr.io/cnescatlab/cppcheck:latest
```

#### Run core checks
Assuming current directory contains the source code to analyze, simply run the following command:
```Dockerfile
docker run --rm -v ${PWD}:/src ghcr.io/cnescatlab/cppcheck:latest cppcheck -v --xml --enable=all . 2> report.xml
```

#### Run MISRA C 2012 checks
Assuming current directory contains the source code to analyze, simply run the following command:
```Dockerfile
docker run --rm -v ${PWD}:/src ghcr.io/cnescatlab/cppcheck:latest cppcheck --dump .; misra.py *.dump 2>report.xml
```
Or simplier:
```Dockerfile
docker run --rm -v ${PWD}:/src ghcr.io/cnescatlab/cppcheck misra
```

#### Run CERT checks
Assuming current directory contains the source code to analyze, simply run the following command:
```Dockerfile
docker run --rm -v ${PWD}:/src ghcr.io/cnescatlab/cppcheck:latest cppcheck --dump .; cert.py *.dump 2>report.xml
```

### Versions matrix
Here is the versions matrix of the image:

|                                    TAG                                        |                       CPPCHECK VERSION                       |                        BASE IMAGE                      |
|:-----------------------------------------------------------------------------:|:------------------------------------------------------------:|:------------------------------------------------------:|
| [latest](https://github.com/cnescatlab/cppcheck/pkgs/container/cppcheck/1.90) | [1.90](https://github.com/danmar/cppcheck/releases/tag/1.90) | [python:3.8.1-alpine](https://hub.docker.com/_/python) |
|  [1.90](https://github.com/cnescatlab/cppcheck/pkgs/container/cppcheck/1.90)  | [1.90](https://github.com/danmar/cppcheck/releases/tag/1.90) | [python:3.8.1-alpine](https://hub.docker.com/_/python) |

### How to contribute
If you experienced a problem with the plugin please open an issue. Inside this issue please explain us how to reproduce this issue and paste the log.

If you want to do a PR, please put inside of it the reason of this pull request. If this pull request fix an issue please insert the number of the issue or explain inside of the PR how to reproduce this issue.

### License
Copyright 2022 CNES CatLab.

Licensed under the [GNU General Public License, Version 3.0](https://www.gnu.org/licenses/gpl.txt)
