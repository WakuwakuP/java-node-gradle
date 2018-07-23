FROM ubuntu:18.04

CMD ["gradle"]

RUN set -x && \
    apt-get update && \
		apt-get install software-properties-common && \
		add-apt-repository -y ppa:cwchien/gradle && \
		apt-get update && \
		apt-get install -y openjdk-8-jdk && \
		apt-get install -y curl nodejs npm gradle && \
		npm cache clean && \
		npm install n -g && \
		n 8.11.3 && \
		apt-get purge -y nodejs npm && \
		ln -sf /usr/local/bin/node /usr/bin/node && \
		ln -sf /usr/local/bin/npm /usr/bin/npm && \
		groupadd --system --gid 1000 gradle \
		useradd --system --gid gradle --uid 1000 --shell /bin/bash --create-home gradle && \
		mkdir /home/gradle/.gradle && \
		chown --recursive gradle:gralde /home/gradle && \
		ln -s /home/gradle/.gradle /root/.gradle

USER gradle
VOLUME "/home/gradle/.gradle"
WORKDIR /home/gradle