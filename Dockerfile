FROM golang:1.17.4-alpine AS builder

RUN apk add --no-cache git make bash
ADD node-driver-registrar/ /node-driver-registrar/
WORKDIR /node-driver-registrar
RUN make

FROM scratch
LABEL maintainers="Florian Piesche <florian@yellowkeycard.net>"
LABEL description="Unmodified multi-arch builds of kubernetes-csi/node-driver-registrar"

COPY --from=builder /node-driver-registrar/bin/csi-node-driver-registrar /csi-node-driver-registrar
ENTRYPOINT ["/csi-node-driver-registrar"]
