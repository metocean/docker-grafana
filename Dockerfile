FROM metocean/aroha:v1.0.0
MAINTAINER Thomas Coats <thomas@metocean.co.nz>

ENV GRAFANA_VERSION=3.0-beta3

ADD . /install/
RUN /install/install.sh
CMD ["/sbin/initsh"]