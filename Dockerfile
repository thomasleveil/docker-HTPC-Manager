FROM python:2

RUN cd /usr/local/src/ \
	&& curl http://www.ijg.org/files/jpegsrc.v8c.tar.gz | tar xz \
	&& cd jpeg-8c \
	&& ./configure --enable-shared --prefix=$CONFIGURE_PREFIX \
	&& make \
	&& make install
RUN apt-get install -y libpng-dev libfreetype6 libfreetype6-dev zlib1g-dev
RUN pip install PIL --allow-external PIL --allow-unverified PIL
RUN pip install psutil

ADD . /srv/
WORKDIR /srv
EXPOSE 80
CMD ["python", "Htpc.py", "--port", "80"]