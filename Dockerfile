# Datawire.io Proton
#
# VERSION               0.0.3

FROM      ubuntu

# Version
RUN echo "Datawire.io Proton v0.0.3"

# Get updates and install GIT
RUN apt-get update && apt-get install -y git

# Install node
RUN (apt-get -y install nodejs && apt-get -y install npm && cp -s /usr/bin/nodejs /usr/local/bin/node)

# Install proton dependencies
RUN (apt-get -y install uuid-dev python-dev swig gcc cmake)

# Install proton
ADD install-proton.sh ws2tcp.sh /opt/
RUN chmod +x /opt/install-proton.sh && /opt/install-proton.sh && rm /opt/install-proton.sh

