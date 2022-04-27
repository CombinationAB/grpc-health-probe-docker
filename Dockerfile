ARG version=0.4.11
FROM alpine:3 as build
ARG version
RUN apk --no-cache add curl
RUN case "$(arch)" in x86_64) release_arch=amd64 ;; i386) release_arch=386 ;; aarch64) release_arch=arm64 ;; arm*) release_arch=arm;; *) release_arch=$(arch);; esac && \
    curl -L https://github.com/grpc-ecosystem/grpc-health-probe/releases/download/v${version}/grpc_health_probe-linux-${release_arch} > /grpc_health_probe
RUN chmod 755 /grpc_health_probe
FROM scratch
COPY --from=build /grpc_health_probe /
ENTRYPOINT [ "/grpc_health_probe" ]
LABEL org.opencontainers.image.source=https://github.com/CombinationAB/grpc-health-probe-docker
CMD [ "-help" ]
