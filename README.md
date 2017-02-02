# hep-conda-recipes
Conda recipes for packages used in High Energy Particle Physics (HEP)


```bash
git clone https://github.com/kreczko/hep-conda-recipes.git
cd hep-conda-recipes
docker build -t kreczko/hep-conda-recipes .
docker run --rm -ti -v `pwd`:/conda-recipes kreczko/hep-conda-recipes /bin/bash
conda build <the package you want to build>
```

## htcondor-python
### Building
```bash
git clone https://github.com/kreczko/hep-conda-recipes.git
cd hep-conda-recipes
docker build -t kreczko/hep-conda-recipes .
docker run --rm -ti -v `pwd`:/conda-recipes kreczko/hep-conda-recipes /bin/bash
# example for htcondor-python:
CONDA_PY=2.7 CONDOR_VERSION=8.4.3 conda build htcondor-python &> build.log &
```

### Using
```
# pick installer from https://conda.io/miniconda, example uses Linux
wget https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh
# follow instructions https://conda.io/docs/install/quick.html
bash Miniconda2-latest-Linux-x86_64.sh

# it is important that you use conda-forge for the boost package
# as the default does not come with libboost_python
conda config --add channels conda-forge
conda config --add channels kreczko

conda create -n condor python=2.7
source activate condor
conda install htcondor-python
```
