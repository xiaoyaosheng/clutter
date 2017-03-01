FROM ${BASE_IMAGE}
MAINTAINER ${MAINTAINER}
ENV REFRESH_AT ${REFRESH_AT}
RUN mkdir -p /opt/${MODULE_NAME}
ADD ${PACKAGE_NAME} /opt/${MODULE_NAME}/
COPY service.supervisord.conf /etc/supervisord.conf.d/service.supervisord.conf
COPY supervisor-msoa-wrapper.sh /opt/${MODULE_NAME}/supervisor-msoa-wrapper.sh
RUN chmod +x /opt/${MODULE_NAME}/supervisor-msoa-wrapper.sh
RUN chmod +x /opt/${MODULE_NAME}/*.sh
EXPOSE
ENTRYPOINT ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]