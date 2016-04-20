FROM alpine:latest

ENV HOME /root

ADD cleanup /cleanup
RUN apk add --update bash git vim curl && \
    /cleanup

ADD update-vim /update-vim
RUN curl http://j.mp/spf13-vim3 -L -o - | bash

RUN mkdir /src
WORKDIR /src

# By default start in tmux
ENTRYPOINT ["/bin/bash", "--login", "-i", "-c"]
CMD ["/bin/bash"]

