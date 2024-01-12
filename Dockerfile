FROM python:3.9.18-bullseye AS core

WORKDIR /src

RUN pip install poetry && \
    git clone https://github.com/VikParuchuri/marker.git


FROM core AS poetry_installer

WORKDIR /src/marker

RUN poetry config virtualenvs.in-project true && \
    poetry remove torch && \
    poetry source add --priority=explicit pytorch-cpu https://download.pytorch.org/whl/cpu && \
    poetry add torch && \
    poetry install

FROM core AS runner

WORKDIR /src/marker

RUN apt-get update && \
    apt-get install -y --no-install-recommends sudo lsb-release && \
    yes | bash scripts/install/tesseract_5_install.sh && \
    yes | bash scripts/install/ghostscript_install.sh && \
    cat scripts/install/apt-requirements.txt | xargs sudo apt-get install -y

COPY --from=poetry_installer /src/marker/.venv/ /src/marker/.venv/
COPY load_models.py .
RUN .venv/bin/python load_models.py

COPY entrypoint.sh .
ENTRYPOINT ["/bin/sh", "entrypoint.sh"]
