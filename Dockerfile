FROM nicerobot/anaconda3:base

MAINTAINER nicerobot <http://github.com/nicerobot/docker-irkernel>

ENV PATH /root/anaconda3/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Install kernels and libraries
RUN conda install -y -c r r-essentials \
    && conda install -y gdal \
    && pip install descartes geopy shapely fiona \
    && /bin/true

VOLUME /notebooks
WORKDIR /notebooks

EXPOSE 8888

ENTRYPOINT ["jupyter"]
CMD ["--help"]
