FROM python:3.11-slim

RUN apt update && apt install curl tar libdigest-sha-perl sudo -y && apt clean
RUN useradd -m runner && echo "runner:runner" | chpasswd && adduser runner sudo
WORKDIR /actions-runner
RUN curl -o actions-runner-linux-x64-2.315.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.315.0/actions-runner-linux-x64-2.315.0.tar.gz && \
  echo "6362646b67613c6981db76f4d25e68e463a9af2cc8d16e31bfeabe39153606a0  actions-runner-linux-x64-2.315.0.tar.gz" | shasum -a 256 -c && \
  tar xzf ./actions-runner-linux-x64-2.315.0.tar.gz
RUN ./bin/installdependencies.sh
USER runner
ADD start-runner.sh .

CMD ["bash","-c","./start-runner.sh"]
