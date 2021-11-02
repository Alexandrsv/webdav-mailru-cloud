FROM mono:6
WORKDIR /app
RUN apt-get update && apt-get install -y wget unzip
RUN wget -O - "https://api.github.com/repos/yar229/WebDavMailRuCloud/releases/latest" | grep 'browser_download_url' | grep -o "http.*48\.zip" | xargs wget
RUN apt-get clean autoclean \
    apt-get autoremove --yes \
    rm /var/lib/{apt,dpkg,cache,log}/
RUN unzip *

ENV PORT=47896
EXPOSE ${PORT}
CMD mono /app/wdmrc.exe -p ${PORT} -h http://*
