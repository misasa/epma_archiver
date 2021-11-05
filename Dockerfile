ARG RUBY_VERSION="2.1"
FROM ruby:${RUBY_VERSION}

RUN apt-get update \
&& apt-get install -y python-pip \
  python-dev \
  liblapack-dev \
  libjpeg-dev \
  libpng-dev \
  zlib1g-dev \
  postgresql-client \  
  gfortran
RUN ln -s /usr/lib/x86_64-linux-gnu/libjpeg.so.62.1.0 /usr/lib/libjpeg.so
RUN ln -s /usr/lib/x86_64-linux-gnu/libz.so /usr/lib/libz.so
WORKDIR /usr/local
RUN git clone https://gitlab.misasa.okayama-u.ac.jp/pythonpackage/jxmap.git
RUN pip install future
RUN pip install numpy==1.6.2
RUN pip install -r ./jxmap/requirements.txt
RUN pip install ./jxmap

RUN useradd -m --home-dir /app epma
USER epma
WORKDIR /app
COPY --chown=epma:epma Gemfile Gemfile.lock /app/
RUN bundle config set --local path 'vendor/bundle'
RUN mkdir /app/vendor
COPY bundle.tar.gz /app/vendor
RUN cd /app/vendor && \
    tar xvzf bundle.tar.gz && \
    rm bundle.tar.gz
RUN bundle install
COPY . /app