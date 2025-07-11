FROM ubuntu:latest

RUN apt update -y && \
    apt install -y jq jsonnet wget

RUN wget https://github.com/brancz/gojsontoyaml/releases/download/v0.1.0/gojsontoyaml_0.1.0_linux_arm64.tar.gz && \
    tar -xvzf gojsontoyaml_0.1.0_linux_arm64.tar.gz && \
    chmod +x gojsontoyaml && \
    mkdir -p /usr/local/bin && \
    mv ./gojsontoyaml /usr/local/bin

CMD [ "sleep", "infinity" ]
