FROM python:3.8.1-alpine AS base

ENV CPPCHECK_VERSION=1.90

WORKDIR /tmp/cppcheck

RUN apk add --no-cache -t .required_apks \
    git \
    make \
    g++ \
    pcre-dev \
 && git clone --single-branch -b $CPPCHECK_VERSION https://github.com/danmar/cppcheck.git . \
 && make install MATCHCOMPILER=yes FILESDIR=/etc/cppcheck HAVE_RULES=yes CXXFLAGS="-O2 -DNDEBUG -Wall -Wno-sign-compare -Wno-unused-function --static" \
 && apk del .required_apks \
 && echo -e "#!/bin/sh\ncppcheck --dump .\n misra.py \`find . -name '*.dump' | tr '\n' ' '\` 2> misra-report.txt" > /usr/bin/misra && chmod +x /usr/bin/misra

FROM python:3.8.1-alpine
RUN pip install --trusted-host pypi.org pygments \
 && rm -rf /lib/apk /etc/apk /home /var /tmp /srv /media /mnt /run /sbin /opt
COPY --from=base /usr/bin/cppcheck /usr/bin/cppcheck-htmlreport /usr/bin/misra /usr/bin/*.py /usr/bin/
COPY --from=base /etc/cppcheck /etc/cppcheck

LABEL maintainer="cnescatlab"
WORKDIR /src
