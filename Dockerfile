FROM ubuntu:latest

MAINTAINER team@and.how

WORKDIR /tmp

COPY cpanfile .

RUN apt-get update -y

RUN apt-get install -y build-essential
RUN apt-get install -y ca-certificates
RUN apt-get install -y cpanminus
RUN apt-get install -y openssl
RUN apt-get install -y libssl-dev
RUN apt-get install -y zlib1g-dev
RUN apt-get install -y perlbrew

RUN cpanm -qn App::plx
RUN cpanm -qn App::cpm

RUN perlbrew init
RUN perlbrew install-cpanm
RUN perlbrew install -n perl-5.30.0
RUN perlbrew exec --with perl-5.30.0 cpanm -qn --reinstall --installdeps .

RUN rm cpanfile

CMD perlbrew exec --with perl-5.30.0 perl -V
