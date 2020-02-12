FROM alpine:3.5
WORKDIR /app/build
COPY . /app
RUN apk add --no-cache g++ make cmake libmpdclient-dev openssl-dev
RUN cmake ..
RUN make

FROM alpine:3.5
RUN apk add  --no-cache libmpdclient openssl curl
EXPOSE 8080
ENV MPD_HOST="poly.home.mangelsen.se"
COPY --from=0 /app/build/ympd /usr/bin/ympd
COPY --from=0 /app/build/mkdata /usr/bin/mkdata
CMD ympd --host $MPD_HOST