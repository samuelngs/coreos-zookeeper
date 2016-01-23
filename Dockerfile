FROM infinitely/java8:latest

EXPOSE 2181 2888 3888

ENV ZOOKEEPER_HOME /usr/lib/zookeeper
ENV PATH ${PATH}:${ZOOKEEPER_HOME}/bin

# Add files
ADD releases/current $ZOOKEEPER_HOME
ADD tasks/secure.sh $ZOOKEEPER_HOME/bin

ADD zoo.cfg $ZOOKEEPER_HOME/conf

# Set work directory
WORKDIR $ZOOKEEPER_HOME

# Install Bash
RUN apk --update add bash &&\
# Cleanup
    rm -rf /tmp/* &&\
    rm -rf /var/cache/apk/* &&\
# Prepare for data and logs
    mkdir -p $ZOOKEEPER_HOME/data &&\
    mkdir -p $ZOOKEEPER_HOME/logs &&\
    chown -R nobody:nobody $ZOOKEEPER_HOME &&\
# Secure image
    bin/secure.sh

USER nobody

VOLUME ["/usr/lib/zookeeper/data"]

# Entry Point
ENTRYPOINT ["zkServer.sh"]

# Default Command
CMD ["start-foreground"]


