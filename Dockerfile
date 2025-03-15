FROM python:3.8-slim-buster as main

ENV RAILWAY=true
ENV DOCKER=true
ENV GIT_PYTHON_REFRESH=quiet
ENV PIP_NO_CACHE_DIR=1

# Объединение установки пакетов
RUN apt-get update && apt-get install -y --no-install-recommends 
    libcairo2 git build-essential python3-dev libffi-dev 
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/* /tmp/*

RUN pip install --upgrade pip setuptools wheel
RUN git clone https://github.com/hikariatama/Hikka /Hikka

WORKDIR /Hikka
RUN pip install --no-warn-script-location --no-cache-dir -r requirements.txt
RUN pip install --no-warn-script-location --no-cache-dir redis

EXPOSE 8080

RUN mkdir /data

CMD ["python3", "-m", "hikka"]
