FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt -y install postgresql-12 postgresql-client-12
RUN apt-get update && apt-get install -y mdbtools

WORKDIR /home/ubuntu/

RUN chown postgres /home/ubuntu/
USER postgres

RUN /etc/init.d/postgresql start

RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/12/main/pg_hba.conf

RUN echo "listen_addresses='*'" >> /etc/postgresql/12/main/postgresql.conf

EXPOSE 5432

VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]

CMD ["/usr/lib/postgresql/12/bin/postgres", "-D", "/var/lib/postgresql/12/main", "-c", "config_file=/etc/postgresql/12/main/postgresql.conf"]
