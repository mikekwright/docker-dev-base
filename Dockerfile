FROM ubuntu:wily

ENV HOME /root

ADD cleanup /cleanup
RUN apt-get update && \
    apt-get install -y git vim curl cron tmux fontconfig zsh && \
    /cleanup

ADD update-vim /update-vim
RUN curl http://j.mp/spf13-vim3 -L -o - | sh

ADD https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh /install-zsh.sh
RUN chsh -s /bin/zsh && \
    chmod +x /install-zsh.sh && /install-zsh.sh || exit 0

ADD https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf $HOME/.fonts/PowerlineSymbols.otf
ADD https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf  $HOME/.fonts/10-powerline-symbols.conf
RUN mkdir -p $HOME/.config/fontconfig/conf.d
ADD enable-powerline /enable-powerline

ADD tmux.conf $HOME/.tmux.conf
ADD tmux.powerline.conf $HOME/.tmux.powerline.conf

RUN mkdir /src
WORKDIR /src

# Not this is only for powerline stuff, if specify this at runtime with -e TERM=$TERM
ENV TERM xterm-256color

# By default start in tmux
ENTRYPOINT ["/bin/bash", "--login", "-i", "-c"]
CMD ["tmux"]

