# Jupyter-Docker | Docker image enabled with Jupyter

[![Docker Image CI](https://github.com/Davidelanz/jupyter-docker/actions/workflows/docker-image.yml/badge.svg)](https://github.com/Davidelanz/jupyter-docker/actions/workflows/docker-image.yml)
[![](https://img.shields.io/badge/Ubuntu-20.04-orange)](https://releases.ubuntu.com/20.04/)
[![](https://img.shields.io/badge/Python-3.8.2-yellow)](https://www.python.org/downloads/release/python-382/)
[![](https://img.shields.io/badge/MiniConda-yes-green)](https://docs.conda.io/en/latest/miniconda.html)

Repository for the [davidelanz/jupyter](https://hub.docker.com/r/davidelanz/jupyter) docker image. 
It provides a quick, dockerized set up for Jupyter Lab with multiple Conda environments.

|   | Features  |
|---|---|
| [![](https://raw.githubusercontent.com/Davidelanz/jupyter-docker/master/.docs/formatter.png)](https://jupyterlab-code-formatter.readthedocs.io/) | The image comes with [jupyterlab_code_formatter](https://jupyterlab-code-formatter.readthedocs.io/) already installed |
| [![](https://raw.githubusercontent.com/Davidelanz/jupyter-docker/master/.docs/lsp-integration.png)](https://jupyterlab-lsp.readthedocs.io/en/latest/index.html) | The image comes with [LSP Python language server for JupyterLab](https://jupyterlab-lsp.readthedocs.io/en/latest/index.html) (jedi 0.17.2) already installed |
| [![](https://raw.githubusercontent.com/Davidelanz/jupyter-docker/master/.docs/opencv.png)](https://opencv.org/) | The image comes already with a Python3.7 Conda environment with OpenCV support called ``opencv-py3.7`` |

![](https://raw.githubusercontent.com/Davidelanz/jupyter-docker/master/.docs/banner.png)

---

- [Loading the image](#loading-the-image)
  - [Mount from DockerHub](#mount-from-dockerHub)
  - [Build from GitHub](#build-from-github)
- [Using the image](#using-the-image)
  - [Creating and loading new Conda environment](#creating-and-loading-new-conda-environment)

---

# Loading the image

## Mount from DockerHub

Download the image from [davidelanz/jupyter](https://hub.docker.com/r/davidelanz/jupyter), 
then mount the container (the image exposes JupyterLab on the ``8888`` port):
```
docker run -p CONTANER_PORT:8888 -v EXTERNAL_FOLDER:/workspace --name CONTAINER_NAME davidelanz/jupyter
```

Your workspace will be available at [localhost:CONTANER_PORT](http://localhost:CONTANER_PORT).

## Build from GitHub

The image can be directly built from the GitHub repository:

```
$ git clone https://github.com/davidelanz/jupyter-docker
$ cd jupyter-docker/
$ docker build . -t davidelanz/jupyter
```

# Using the image

## Creating and loading new Conda environment

> The image comes already with a Python3.7 environment with OpenCV support called ``opencv-py3.7``.

You can create a new enviroment as follows (you can easily do it from the JupyterLab console):
```
conda create -y --name <DESIRED_ENV_NAME> python=<DESIRED_PYTHON_VERSION>
```
Then you can load it to JupyterLab as follows:
```
conda activate <DESIRED_ENV_NAME> && conda install -y ipykernel && python -m ipykernel install --name <DESIRED_ENV_NAME> --user
```

With Jupyter installed you get the list of currently installed kernels with:
```
jupyter kernelspec list
```

If you want to uninstall an unwanted kernel:
```
jupyter kernelspec uninstall <UNWANTED_KERNEL>
```
