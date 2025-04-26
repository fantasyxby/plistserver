FROM rust:1.75-slim as builder

WORKDIR /usr/src/plistserver
COPY . .
RUN cargo build --release

# 将基础镜像从 bullseye-slim 更改为 bookworm-slim，它包含更新的 GLIBC 版本
FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/local/bin
COPY --from=builder /usr/src/plistserver/target/release/plistserver .

EXPOSE 3788

CMD ["plistserver"]