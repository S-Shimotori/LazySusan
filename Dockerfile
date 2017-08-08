FROM ubuntu:yakkety


ARG clingo_src_version="5.2.0"
ARG mkatoms_src_version="2.16"
ARG dlv_rsig_src_version="1.8.10"
ARG ezcsp_src_version="1.7.9-r4024"
ARG bprolog_bin_version="75"
ARG swiprolog_apt_version="7.2.3+dfsg-1build2"
ARG user_name="docker"

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y \
    cmake \
    flex \
    gcc \
    g++ \
    make \
    subversion \
    sudo \
    unzip
RUN useradd -m ${user_name} \
    && echo "docker:docker" | chpasswd \
    && echo "${user_name} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${user_name} \
    && gpasswd -a ${user_name} sudo

USER ${user_name}
WORKDIR /home/${user_name}

# install gringo+clasp
# https://github.com/potassco/clingo/archive/v${clingo_src_version}.tar.gz
ADD clingo-${clingo_src_version}.tar.gz $HOGE
RUN cmake -H/home/${user_name}/clingo-${clingo_src_version} -B/home/${user_name}/clingo -DCMAKE_BUILD_TYPE=Release \
    && cmake --build /home/${user_name}/clingo
RUN sudo ln -s $HOME/clingo/bin/gringo /usr/local/bin/gringo \
    && sudo ln -s $HOME/clingo/bin/clingo /usr/local/bin/clingo \
    && sudo ln -s $HOME/clingo/bin/clasp /usr/local/bin/clasp

# install mkatoms
# http://www.mbal.tk/mkatoms/Source/mkatoms-${mkatoms_src_version}.tgz
ADD mkatoms-${mkatoms_src_version}.tgz $HOME
RUN sudo chown -R ${user_name}:${user_name} mkatoms-${mkatoms_src_version}
WORKDIR /home/${user_name}/mkatoms-${mkatoms_src_version}
RUN ./configure && make && sudo make install
WORKDIR /home/${user_name}

# install dlv_rsig
# http://www.mbal.tk/ezcsp/dlv_rsig-${dlv_rsig_src_version}.tgz
ADD dlv_rsig-${dlv_rsig_src_version}.tgz $HOME
RUN sudo chown -R ${user_name}:${user_name} dlv_rsig-${dlv_rsig_src_version}
WORKDIR /home/${user_name}/dlv_rsig-${dlv_rsig_src_version}
RUN ./configure && make && sudo make install
WORKDIR /home/${user_name}

# install EZCSP
# http://www.mbal.tk/ezcsp/ezcsp-${ezcsp_src_version}.tgz
ADD ezcsp-${ezcsp_src_version}.tgz $HOME
RUN sudo chown -R ${user_name}:${user_name} ezcsp-${ezcsp_src_version}
WORKDIR /home/${user_name}/ezcsp-${ezcsp_src_version}
RUN ./configure && make && sudo make install
WORKDIR /home/${user_name}

# install BProlog
# http://www.picat-lang.org/bprolog/download/bp${bprolog_bin_version}_linux64.tar.gz
# `bp` refers $HOME/BProlog
ADD bp${bprolog_bin_version}_linux64.tar.gz $HOME
RUN sudo ln -s $HOME/BProlog/bp /usr/local/bin/bp

# install SWIProlog
RUN sudo apt-get install -y swi-prolog=${swiprolog_apt_version}

RUN sudo rm /etc/sudoers.d/${user_name}

CMD /bin/bash
