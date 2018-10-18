FROM josh5/base-ubuntu:16.04
LABEL maintainer="Josh.5 <jsunnex@gmail.com>"


ENV CONTAINER_DOMAIN="localhost.io"


### Install base packages
RUN \
    apt-get update \
    && \
    echo "**** Install Dependencies ****" \
        && apt-get install -y \
            ant \
            cron \
            imagemagick \
            iputils-ping \
            mercurial \
            nano \
            openjdk-8-jre \
            openssl \
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
    echo "Install Perl modules from apt" \
        && apt-get install -y \
            dmtx-utils \
            libarchive-zip-perl \
            libbsd-resource-perl \
            libcgi-session-perl \
            libcommon-sense-perl \
            libconfig-simple-perl \
            libconvert-asn1-perl \
            libdata-guid-perl \
            libdate-calc-perl \
            libdatetime-format-dateparse-perl \
            libdatetime-perl \
            libdbd-pg-perl \
            libdbd-sqlite3-perl \
            libdbd-sybase-perl \
            libdbi-perl \
            libdbix-class-datetime-epoch-perl \
            libdevel-symdump-perl \
            libdigest-sha-perl \
            libemail-mime-createhtml-perl \
            libemail-mime-perl \
            libemail-sender-transport-smtps-perl \
            libexcel-writer-xlsx-perl \
            libfile-copy-recursive-perl \
            libfile-mimeinfo-perl \
            libfile-pid-perl \
            libfile-slurp-perl \
            libfile-touch-perl \
            libfreezethaw-perl \
            libgssapi-perl \
            libhttp-cookies-perl \
            libimage-base-bundle-perl \
            libimage-info-perl \
            libimage-magick-perl \
            libio-all-perl \
            libio-sessiondata-perl \
            libio-socket-ssl-perl \
            libio-string-perl \
            libjson-perl \
            libjson-pp-perl \
            libjson-xs-perl \
            liblog-dispatch-filerotate-perl \
            liblog-log4perl-perl \
            libmail-deliverystatus-bounceparser-perl \
            libmail-pop3client-perl \
            libmail-sender-perl \
            libmath-round-perl \
            libmath-spline-perl \
            libmime-tools-perl \
            libmime-types-perl \
            libnet-imap-simple-perl \
            libnet-ldap-perl \
            libnet-ssleay-perl \
            libnet-statsd-perl \
            libossp-uuid-perl \
            libossp-uuid16 \
            libperl5.22 \
            libphp-serialization-perl \
            librpc-xml-perl \
            libsoap-lite-perl \
            libstring-random-perl \
            libstring-similarity-perl \
            libswitch-perl \
            libtext-csv-perl \
            libtext-csv-xs-perl \
            libtext-levenshtein-perl \
            libtext-unaccent-perl \
            libtext-unidecode-perl \
            libtypes-serialiser-perl \
            liburi-encode-perl \
            libxml-simple-perl \
            libxml-smart-perl \
            libxml2-utils \
            libxmlrpc-lite-perl \
            libyaml-perl \
            perlmagick \
    && \
    echo "**** cleanup ****" \
        && apt-get clean \
        && rm -rf \
            /tmp/* \
            /var/lib/apt/lists/* \
            /var/tmp/*



### Install perl packages
ARG PERL_MM_USE_DEFAULT=1
RUN \
    echo "Install Perl modules from cpan" \
        && cpan install \
            PeekPoke \
            Mail::Sender \
            JSON::DWIW \
            XML::XML2JSON \
            HTTP::Async \
        && cpan install MAKAMAKA/JSON-RPC-0.96.tar.gz \
    && \
    echo "**** cleanup ****" \
        && rm -rf \
            /tmp/* \
            /var/tmp/*


### Add local files
COPY root/ /


# expose port 22 for ssh
EXPOSE 22 80 443
VOLUME /config/
