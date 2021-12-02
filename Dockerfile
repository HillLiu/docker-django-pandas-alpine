ARG VERSION=${VERSION:-[VERSION]}

FROM python:${VERSION}-slim as builder
ARG VERSION
RUN apt-get update && \
    apt-get install -qq -y --no-install-recommends \
      build-essential \
      sqlite3 \
      postgresql-client \
      gettext \
      libpq-dev \
      libmaxminddb0 \
      libmaxminddb-dev \
      mmdb-bin

RUN python${VERSION%.*} --version 
ARG PIP3="/root/site/bin/pip3"
ENV PIP_CACHE_DIR=/root/.cache/pip
ENV PATH=/root/site/bin:$PATH
VOLUME /root/.cache/pip

RUN python${VERSION%.*} -m venv /root/site && \
    ${PIP3} install -U pip && \
    ${PIP3} install \
      django \
      django-webpack-loader \
      django-cors-headers \
      django-environ \
      django-storages \
      django-celery-beat \
      django-celery-results \
      djangorestframework \
      djangorestframework-csv \
      requests \
      gunicorn \
      uvicorn \
      httptools \
      uvloop \
      whitenoise \
      numpy \
      pandas \
      Pillow \
      grpcio \
      opencv-python-headless \
      wheel \
      oauth2client \
      Cython \
      celery \
      channels \
      asgi_redis \
      psycopg2-binary \
      feedparser


# FROM python:${VERSION}-slim as app
# COPY --from=builder /root/site /root/site
# ENV PATH=/root/site/bin:$PATH
