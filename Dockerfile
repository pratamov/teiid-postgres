FROM jboss/teiid

USER root
WORKDIR /tmp
ADD https://jdbc.postgresql.org/download/postgresql-42.2.4.jar /tmp/postgresql.jar
COPY setup.sh ./
COPY install.cli /tmp/
RUN sed -i -e 's/\r$//' ./setup.sh
RUN chmod +x ./setup.sh && chown jboss setup.sh && chown jboss install.cli

USER jboss
RUN ./setup.sh
RUN /opt/jboss/wildfly/bin/add-user.sh admin Admin123! --silent

CMD ["/bin/sh", "-c", "$JBOSS_HOME/bin/standalone.sh -c standalone-teiid.xml -b 0.0.0.0 -bmanagement 0.0.0.0"]