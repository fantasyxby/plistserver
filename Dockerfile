FROM rust:1.75-slim as builder

WORKDIR /usr/src/plistserver
COPY . .
RUN cargo build --release

FROM debian:bullseye-slim
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/local/bin
COPY --from=builder /usr/src/plistserver/target/release/plistserver .

EXPOSE 3788

CMD ["plistserver"]