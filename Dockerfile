FROM nicerobot/anaconda3:base

MAINTAINER nicerobot <http://github.com/nicerobot/docker-notebook>

ENV PATH /root/anaconda3/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

COPY etc/skel /etc/

# Install kernels and libraries
RUN conda install -y gdal \
    && conda install -y -c r r-essentials r-devtools r-curl r-maptools r-raster \
    && pip install descartes geopy shapely fiona jupyterhub awscli \
    && curl -L http://downloads.typesafe.com/scala/2.10.6/scala-2.10.6.tgz | tar zx \
    && ln -s scala-2.10.6 scala \
    && curl -LO http://d3kbcqa49mib13.cloudfront.net/spark-1.5.2-bin-hadoop2.6.tgz | tar zx \
    && ln -s spark-1.5.2-bin-hadoop2.6 spark \
		&& mkdir -p ${HOME}/notebooks/ro ${HOME}/notebooks/rw \
    && /bin/true

# https://github.com/ContinuumIO/anaconda-issues/issues/72
RUN mkdir -p /etc/pki/tls/certs/ \
    && ln -s /etc/ssl/certs/ca-certificates.crt /etc/pki/tls/certs/ca-bundle.crt

VOLUME ${HOME}/notebooks
WORKDIR ${HOME}/notebooks

EXPOSE 8888

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["notebook","--no-browser"]
