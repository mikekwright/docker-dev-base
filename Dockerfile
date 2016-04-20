FROM ubuntu:wily

ENV HOME /root

ADD cleanup /cleanup
RUN apt-get update && \
    apt-get install -y git vim curl cron zsh && \
    /cleanup

ADD update-vim /update-vim
RUN curl http://j.mp/spf13-vim3 -L -o - | sh

ADD https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh /install-zsh.sh
RUN chsh -s /bin/zsh && \
    chmod +x /install-zsh.sh && /install-zsh.sh || exit 0

RUN mkdir /src
WORKDIR /src

# By default start in tmux
ENTRYPOINT ["/bin/bash", "--login", "-i", "-c"]
CMD ["/bin/bash"]

