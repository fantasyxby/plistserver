FROM rust:1.76-slim as builder

WORKDIR /usr/src/app
COPY . .
RUN cargo build --release

# 使用Ubuntu 22.04作为运行环境，GLIBC版本为2.35本不兼容问题
FROM ubuntu:22.04FROM rust:1.76-slim

# 安装运行时所需的最小依赖
RUN apt-get update && apt-get install -y --no-install-recommends \RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \ficates \
    && rm -rf /var/lib/apt/lists/*

# 创建非root用户运行应用程序运行应用程序
RUN groupadd -r plistserver && useradd -r -g plistserver plistserverRUN groupadd -r plistserver && useradd -r -g plistserver plistserver

WORKDIR /appWORKDIR /app












CMD ["./plistserver"]EXPOSE 3788USER plistserver# 切换到非root用户RUN chown -R plistserver:plistserver /app# 更改所有权COPY --from=builder /usr/src/app/target/release/plistserver /app/plistserverCOPY --from=builder /usr/src/app/target/release/plistserver /app/plistserver

# 更改所有权
RUN chown -R plistserver:plistserver /app

# 切换到非root用户
USER plistserver

EXPOSE 3788

CMD ["./plistserver"]
