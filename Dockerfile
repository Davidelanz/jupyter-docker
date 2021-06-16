


FROM ubuntu:20.04

RUN apt-get update && apt-get install -y --no-install-recommends \
     build-essential \
     ca-certificates \
     curl \
     git \
     htop \
     libglu1 \
     libjpeg-dev \
     libpng-dev \
     nano \
     ssh \
     unzip \
     wget

# Install conda
RUN wget -q https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh  && \
     chmod +x ~/miniconda.sh && \
     ~/miniconda.sh -b -p /opt/conda && \
     rm ~/miniconda.sh && \
     /opt/conda/bin/conda install conda-build 
# Make conda activated by default in bash
RUN  echo "source /opt/conda/bin/activate" >> ~/.bashrc
# Add it to PATH
ENV PATH opt/conda/bin:$PATH

# Install Jupyter and Node.js (for jupyter extensions)
RUN conda install  -y ipython notebook jupyter jupyterlab ipywidgets && \
     conda install -y nodejs -c conda-forge --repodata-fn=repodata.json
# Install code formatter
RUN conda install  -y jupyterlab_code_formatter black isort -c conda-forge 
# Install language server (WORKS WITH JEDI >=0.17.2 <0.18.0)
RUN conda install  -y jedi=0.17.2  && \
     conda install -y python-language-server jedi-language-server jupyterlab-lsp jupyter-lsp-python -c conda-forge

# Create OpenCV environment (with Python 3.7)
RUN conda create -y --name opencv-py3.7 python=3.7 ffmpeg matplotlib opencv
# Add the newly created enviromnent to jupyter
RUN conda install -y --name opencv-py3.7 ipykernel
RUN /opt/conda/envs/opencv-py3.7/bin/python -m ipykernel install --name "opencv-py3.7" --user
# Add to path
ENV PATH /opt/conda/envs/opencv-py3.7/bin:$PATH

# Clean all
RUN conda clean -ya

# Expose 8888 jupyter port
EXPOSE 8888

# Workspace directory
WORKDIR /workspace
RUN chmod -R a+w /workspace

# Prepare for launching jupyter at the container's start
CMD /bin/sh -c "/opt/conda/bin/python -m jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root --ServerApp.token='' --ServerApp.terminado_settings='{\"shell_command\":[\"bash\"]}'"
