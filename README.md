# hep-conda-recipes

```bash
docker build -t kreczko/hep-conda-recipes .
docker run --rm -ti -v `pwd`:/conda-recipes kreczko/hep-conda-recipes /bin/bash
conda build <the package you want to build>
# example for htcondor-python:
CONDA_PY=2.7 CONDOR_VERSION=8.4.2 conda build htcondor-python
```
