FROM ubuntu

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update

RUN apt-get install -y language-pack-en
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN locale-gen en_US.UTF-8
RUN dpkg-reconfigure locales

RUN apt-get install -y \
    openssh-server \
    libxml2-dev \
    python \
    build-essential \
    make \
    gcc \
    python-dev \
    wget

RUN wget http://python-distribute.org/distribute_setup.py 
RUN python distribute_setup.py

RUN wget https://raw.github.com/pypa/pip/master/contrib/get-pip.py 
RUN python get-pip.py

RUN pip install sentry

RUN apt-get install -y postgresql-client-9.1 postgresql-client-common libpq5
RUN apt-get install -y libpq-dev

RUN pip install psycopg2

EXPOSE 9000
VOLUME ["/data"]

ADD sentry.conf.py /sentry.conf.py

ENTRYPOINT ["/usr/local/bin/sentry", "--config=/sentry.conf.py"]
CMD ["upgrade"]
