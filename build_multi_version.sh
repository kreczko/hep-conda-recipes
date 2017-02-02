#!/bin/sh

# current ubuntu version
CONDA_PY=27 CONDOR_VERSION=8.4.3 conda build htcondor-python
# latest 8.4 on SL6
CONDA_PY=27 CONDOR_VERSION=8.4.11 conda build htcondor-python
# latest stable
CONDA_PY=27 CONDOR_VERSION=8.6.0 conda build htcondor-python
