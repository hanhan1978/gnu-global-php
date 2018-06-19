FROM hanhan1978/gnu-global:latest

ENV PHP_VERSION  7.2.6

WORKDIR /tmp

ADD ./gtags.conf /tmp/gtags.conf

RUN curl -fSL -o php.tar.gz "https://github.com/php/php-src/archive/php-$PHP_VERSION.tar.gz" \
    && mkdir /tmp/php-src \
    && tar xzf php.tar.gz -C /tmp/php-src --strip-components 1 \
    && cd /tmp/php-src \
    && gtags --gtagsconf /tmp/gtags.conf -v \
    && htags -aosnfwv \
    && rm -rf /var/www/localhost/htdocs \
    && ln -s /tmp/php-src/HTML /var/www/localhost/htdocs
