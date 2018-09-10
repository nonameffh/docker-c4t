FROM nonameffh/php71:dev

LABEL maintainer="Aleksey Tarasov <nonameffh@gmail.com>"

## add python
RUN apk add --update \
    supervisor \
    python2 python2-dev \
    python3 python3-dev \
    build-base \
    nginx \
  && curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && python get-pip.py \
  && pip install enum et-xmlfile jdcal openpyxl psycopg2 psycopg2-binary XlsxWriter \
  && pip3 install --upgrade pip \
  && pip3 install et-xmlfile jdcal openpyxl psycopg2 psycopg2-binary XlsxWriter \
  && rm -rf /var/cache/apk/* \
  && mkdir -p /run/nginx

COPY supervisor/supervisord.conf /etc/supervisord.conf
COPY bin/* /usr/local/bin/
RUN chmod +x /usr/local/bin/run-app

EXPOSE 80
CMD ["run-app"]