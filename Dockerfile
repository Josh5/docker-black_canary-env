FROM josh5/ubuntu-oracle-java7-jdk
MAINTAINER Josh.5 "jsunnex@gmail.com"


ENV CONTAINER_DOMAIN="localhost.io"


### Install base packages
RUN \
    apt-get update \
    && \
    echo "**** Install Dependencies ****" \
        && apt-get install -y \
            cron \
            openssl \
            nano \
            ant \
            mercurial \
            imagemagick \
            iputils-ping \
    && \
    echo "**** Install Apache ****" \
        && apt-get install -y \
            apache2 \
            apache2-bin \
            apache2-data \
            apache2-dev \
            apache2-utils \
    && \
    echo "**** Configure Apache ****" \
        && a2enmod rewrite
### Install perl packages
RUN \
    echo "Install Perl modules from apt" && \
    apt-get install -y \
        dmtx-utils \
        libarchive-zip-perl \
        libbsd-resource-perl \
        libconfig-simple-perl \
        libdate-calc-perl \
        libdatetime-perl \
        libdbd-pg-perl \
        libdbd-sybase-perl \
        libdbi-perl \
        libdbix-class-datetime-epoch-perl \
        libdigest-sha-perl \
        libemail-mime-createhtml-perl \
        libemail-mime-perl \
        libemail-sender-transport-smtps-perl \
        libfile-copy-recursive-perl \
        libfile-mimeinfo-perl \
        libfile-pid-perl \
        libfile-slurp-perl \
        libfile-touch-perl \
        libhttp-cookies-perl \
        libimage-magick-perl \
        libio-all-perl \
        libio-socket-ssl-perl \
        liblog-log4perl-perl \
        libmail-pop3client-perl \
        libmail-sender-perl \
        libmath-round-perl \
        libmath-spline-perl \
        libmime-tools-perl \
        libmime-types-perl \
        libnet-imap-simple-perl \
        libnet-ssleay-perl \
        libnet-statsd-perl \
        libperl5.22 \
        librpc-xml-perl \
        libswitch-perl \
        libxml-simple-perl \
        libxml-smart-perl \
        libxml2-utils \
        perlmagick \
        liblog-dispatch-filerotate-perl \
        libcommon-sense-perl \
        libconvert-asn1-perl \
        libdata-guid-perl \
        libdatetime-format-dateparse-perl \
        libdevel-symdump-perl \
        libexcel-writer-xlsx-perl \
        libgssapi-perl \
        libimage-base-bundle-perl \
        libimage-info-perl \
        libio-string-perl \
        libjson-perl \
        libjson-xs-perl \
        libmail-deliverystatus-bounceparser-perl \
        libnet-ldap-perl \
        libossp-uuid-perl \
        libossp-uuid16 \
        libstring-random-perl \
        libstring-similarity-perl \
        libtext-levenshtein-perl \
        libtext-unaccent-perl \
        libtext-unidecode-perl \
        libtypes-serialiser-perl \
        libyaml-perl \
        libcgi-session-perl \
        libfreezethaw-perl \
        libio-sessiondata-perl \
        libsoap-lite-perl \
        libtext-csv-perl \
        libtext-csv-xs-perl \
        libxmlrpc-lite-perl \
        libdbd-sqlite3-perl \
        libjson-pp-perl \
        liburi-encode-perl
### Install perl packages
ARG PERL_MM_USE_DEFAULT=1
RUN \
    echo "Install Perl modules from cpan" && \
    cpan install \
        PeekPoke \
        Mail::Sender \
        JSON::DWIW \
        XML::XML2JSON \
        HTTP::Async \
    && \
    cpan install MAKAMAKA/JSON-RPC-0.96.tar.gz

### Cleanup
RUN rm -rf /var/lib/apt/lists/*

### Add local files
COPY root/ /

# expose port 22 for ssh
EXPOSE 22 80 443
VOLUME /config/
