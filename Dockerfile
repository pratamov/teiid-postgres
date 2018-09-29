FROM jboss/teiid

USER root

ADD https://jdbc.postgresql.org/download/postgresql-42.2.4.jar /tmp/postgresql.jar
WORKDIR /tmp
COPY setup.sh ./
COPY install.cli /tmp/
RUN sed -i -e 's/\r$//' ./setup.sh
RUN chmod +x ./setup.sh
RUN ./setup.sh &&  rm -rf $JBOSS_HOME/standalone/configuration/standalone_xml_history/
RUN /opt/jboss/wildfly/bin/add-user.sh admin Admin123! --silent

USER jboss

CMD ["/bin/sh", "-c", "$JBOSS_HOME/bin/standalone.sh -c standalone-teiid.xml -b 0.0.0.0 -bmanagement 0.0.0.0"]