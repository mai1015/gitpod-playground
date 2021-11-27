FROM gitpod/workspace-mysql

# Install Redis.
RUN sudo apt-get update \
#  && sudo apt-get install -y build-essential zlib1g-dev libssl-dev libncurses-dev libffi-dev libsqlite3-dev libreadline-dev libbz2-dev \
  && sudo apt-get install -y redis-server apt-transport-https ca-certificates gnupg \
  && echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
  && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - \
  && sudo apt-get update && sudo apt-get install -y google-cloud-sdk \
  && sudo rm -rf /var/lib/apt/lists/*

# aws
# RUN git clone https://github.com/aws/aws-elastic-beanstalk-cli-setup.git \
#   && ./aws-elastic-beanstalk-cli-setup/scripts/bundled_installer \
#   && rm -rf aws-elastic-beanstalk-cli-setup
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && sudo ./aws/install \
    && rm -rf aws awscliv2.zip

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
