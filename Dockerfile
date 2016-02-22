FROM alpine:latest

ENV HOME /root

ADD cleanup /cleanup
RUN apk add --update bash git vim curl tmux && \
    /cleanup

ADD update-vim /update-vim
RUN curl http://j.mp/spf13-vim3 -L -o - | bash

ADD tmux.conf $HOME/.tmux.conf

RUN mkdir /src
WORKDIR /src

# By default start in tmux
ENTRYPOINT ["/bin/bash", "--login", "-i", "-c"]
CMD ["tmux"]

