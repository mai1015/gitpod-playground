FROM gitpod/workspace-mysql

# Install Redis.
RUN sudo apt-get update \
  && sudo apt-get install -y redis-server apt-transport-https ca-certificates gnupg \
  && echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
  && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - \
  && sudo apt-get update && sudo apt-get install google-cloud-sdk \
  && sudo rm -rf /var/lib/apt/lists/*

# Install Elasticsearch
ARG ES_REPO=https://artifacts.elastic.co/downloads/elasticsearch
ARG ES_ARCHIVE=elasticsearch-oss-7.5.2-linux-x86_64.tar.gz
RUN wget "${ES_REPO}/${ES_ARCHIVE}" \
  && wget "${ES_REPO}/${ES_ARCHIVE}.sha512" \
  && shasum -a 512 -c ${ES_ARCHIVE}.sha512 \
  && tar -xzf ${ES_ARCHIVE}

RUN npm i -g generator-jhipster@6.10.5 &&\
 npm i -g @loopback/cli

RUN curl -sL https://raw.githubusercontent.com/IBM-Cloud/ibm-cloud-developer-tools/master/linux-installer/idt-installer | bash
