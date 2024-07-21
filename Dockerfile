FROM docker.io/alpine AS build
RUN apk add --no-cache build-base zlib-dev bsd-compat-headers libcap-dev libnetfilter_queue-dev nftables
WORKDIR /src/zapret
COPY src .
RUN make

FROM docker.io/alpine AS tpws
COPY --from=build /src/zapret/tpws/tpws /usr/local/bin/
RUN adduser -SH tpws
USER tpws
ENTRYPOINT ["tpws"]
