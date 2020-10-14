FROM ubuntu:20.04
MAINTAINER Darren Leniston <dleniston@tssg.org>
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt -y install postgresql-12 postgresql-client-12
RUN apt-get update && apt-get install -y mdbtools
RUN apt-get update && apt-get install -y git
RUN git clone https://github.com/bats-core/bats-core.git
RUN cd bats-core && ./install.sh /usr/local


WORKDIR /home/ubuntu/

RUN mkdir src
RUN mkdir test_helper
RUN mkdir mdb_files
RUN git clone https://github.com/ztombol/bats-support test_helper/bats-support
RUN git clone https://github.com/bats-core/bats-assert test_helper/bats-assert
RUN chown postgres /home/ubuntu/
RUN chown postgres /home/ubuntu/src/
RUN chown postgres /home/ubuntu/mdb_files

WORKDIR /home/ubuntu/src/

USER postgres

RUN /etc/init.d/postgresql start

RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/12/main/pg_hba.conf

RUN echo "listen_addresses='*'" >> /etc/postgresql/12/main/postgresql.conf

EXPOSE 5432

VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]

CMD ["/usr/lib/postgresql/12/bin/postgres", "-D", "/var/lib/postgresql/12/main", "-c", "config_file=/etc/postgresql/12/main/postgresql.conf"]
