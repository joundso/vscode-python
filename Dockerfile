FROM python:3.13.5-slim

WORKDIR /home

ARG vs_version=3.4.1

RUN /bin/bash -c "apt-get update -y;apt-get install wget -y"

RUN wget https://github.com/cdr/code-server/releases/download/${vs_version}/code-server-${vs_version}-linux-x86_64.tar.gz
RUN tar -xzvf code-server-${vs_version}-linux-x86_64.tar.gz

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

ENV PASSWORD=demo

RUN ln -s ./code-server-${vs_version}-linux-x86_64/code-server ./code-server

CMD /bin/bash -c "./code-server \
    --install-extension ms-python.python --force \
    --install-extension ms-azuretools.vscode-docker --force \
    && ./code-server \
    --host 0.0.0.0 \
    --port 8989" 