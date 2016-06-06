FROM alexellis2/nginx-arm:v6
RUN sudo apt-get update && \
    sudo apt-get -qy install curl iputils-ping
RUN rm -rf /etc/nginx/sites-available/*
RUN rm -rf /etc/nginx/sites-enabled/*
RUN rm -rf /etc/nginx/conf.d/*
ADD ./conf.d/* /etc/nginx/conf.d/
RUN ls /etc/nginx/conf.d/


