FROM ubuntu:latest

RUN apt update && apt install -y \
    curl \
    wget

RUN wget https://download.oracle.com/java/20/archive/jdk-20.0.2_linux-x64_bin.deb && \
    apt install -y ./jdk-20.0.2_linux-x64_bin.deb && \
    rm -f jdk-20.0.2_linux-x64_bin.deb && \
    echo 'JAVA_HOME="/usr/lib/jvm/jdk-20"' >> /root/.bashrc && \
    echo 'export JAVA_HOME' >> /root/.bashrc

RUN wget https://downloads.apache.org/ant/binaries/apache-ant-1.10.13-bin.tar.gz && \
    tar -xf apache-ant-1.10.13-bin.tar.gz && \
    rm -f apache-ant-1.10.13-bin.tar.gz && \
    mv apache-ant-1.10.13/ /usr/local/ant && \
    echo 'ANT_HOME="/usr/local/ant"' >> /root/.bashrc && \
    echo 'PATH="$PATH:/usr/local/ant/bin"' >> /root/.bashrc && \
    echo 'export ANT_HOME' >> /root/.bashrc && \
    echo 'export PATH' >> /root/.bashrc


COPY  ./install_vs_code_server.sh /opt/install_vs_code_server.sh
RUN   cd /opt && \
      ./install_vs_code_server.sh