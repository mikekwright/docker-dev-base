FROM ubuntu:wily

ENV HOME /root

ADD cleanup /usr/local/bin/docker-cleanup
RUN apt-get update && \
    apt-get install -y git vim curl cron zsh sudo && \
    docker-cleanup

# Setup the locale for the system to be UTF
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
RUN locale-gen en_US.UTF-8 && \
    dpkg-reconfigure locales

# Create the user we will run as moving foward (not root)
RUN adduser --disabled-password --gecos "" docker-user && \
    usermod -G root docker-user && \
    echo "docker-user ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers

ENV HOME /home/docker-user
USER docker-user 

# Install the vim package (spf13)
ADD update-vim /usr/local/bin/update-vim
RUN curl http://j.mp/spf13-vim3 -L -o - | sh

# Add a shell with more info (zsh)
#ADD https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh /install-zsh.sh
RUN sudo chsh -s /bin/zsh docker-user && \
    curl -sSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh || exit 0

RUN sudo mkdir /src
WORKDIR /src

ENTRYPOINT ["/bin/bash", "--login", "-i", "-c"]
CMD ["/bin/bash"]

