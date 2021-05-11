FROM pandoc/latex

RUN echo "**** install python ****" && \
    apk add --no-cache python3 && \
    if [ ! -e /usr/bin/python ]; then ln -sf python3 /usr/bin/python ; fi && \
    \
    echo "**** install pip ****" && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --no-cache --upgrade pip setuptools wheel && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    \
    echo "**** install build deps ****" && \
    apk add --no-cache gcc libxml2-dev libxslt-dev python3-dev linux-headers musl-dev && \
    \
    echo "**** install nodejs ****" && \
    apk add --update nodejs npm

RUN pip3 install "docxcompose==1.0.0" "python-docx==0.8.10" "pylint==2.8.2" && \
    npm install -g standard@16.0.3

WORKDIR /app

CMD sh