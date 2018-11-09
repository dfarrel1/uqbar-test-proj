### not able to install graphviz from alpine... 
### believe it's pygraphviz causing the issue
FROM python:3.7-alpine
RUN apk add --update \
    alpine-sdk \
    graphviz \
    linux-headers \ 
    python3 \
    python3-dev \
    postgresql-dev
#     

# # # more dependencies for Pillow (pygraphviz)
# RUN apk --no-cache add openssl \
#                        # Pillow dependencies
#                        libffi-dev \
#                        jpeg-dev \
#                        zlib-dev \
#                        freetype-dev \
#                        lcms2-dev \
#                        openjpeg-dev \
#                        tiff-dev \
#                        tk-dev \
#                        tcl-dev \
#                        harfbuzz-dev \
#                        fribidi-dev 

### works with pipenv
# FROM python:3

WORKDIR /opt/app
RUN pip install -U pipenv
COPY . .

### for using pipenv, not pip
# COPY Pipfile Pipfile.lock ./
# RUN pipenv install --dev --system

### for using pip (derived from pipfile), not pipenv
# RUN pipenv lock -r > requirements.txt
# RUN pipenv lock -r --dev > requirements-test.txt
# RUN cat requirements.txt
# RUN cat requirements-test.txt

COPY requirements.txt requirements-test.txt /tmp/

RUN pip3 install --src /src/ -r /tmp/requirements.txt
RUN pip3 install --src /src/ -r /tmp/requirements-test.txt
COPY . .
RUN pip3 install -e .
RUN pip3 freeze
RUN ls

CMD ["/bin/sh"]