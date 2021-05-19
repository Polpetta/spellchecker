FROM buildpack-deps:stable-scm

ARG ASPELL_SERVER=ftp://ftp.gnu.org/gnu/aspell
ARG ASPELL_VERSION=0.60.8
ARG ASPELL_EN=2019.10.06-0

RUN apt-get update && apt-get install -y --no-install-recommends build-essential \
  && curl -SLO "${ASPELL_SERVER}/aspell-${ASPELL_VERSION}.tar.gz" \
  && curl -SLO "${ASPELL_SERVER}/dict/en/aspell6-en-${ASPELL_EN}.tar.bz2" \
  && tar -xzf "/aspell-${ASPELL_VERSION}.tar.gz" \
  && tar -xjf "/aspell6-en-${ASPELL_EN}.tar.bz2" \
  && cd "/aspell-${ASPELL_VERSION}" \
  && ./configure \
  && make \
  && make install \
  && ldconfig \
  && cd "/aspell6-en-${ASPELL_EN}" \
  && ./configure \
  && make \
  && make install \
  && apt-get purge -y build-essential \
  && apt-get autoremove -y \
  && apt-get autoclean -y \
  && rm -rf /aspell* /var/lib/apt/lists/*

ENTRYPOINT ["aspell"]