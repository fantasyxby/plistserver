FROM rust:1.76-slim as builder

WORKDIR /usr/src/app
COPY . .
RUN cargo build --release

# 使用与构建环境相同的基础镜像，解决GLIBC版本不兼容问题
FROM rust:1.76-slim

# 安装运行时所需的最小依赖
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# 创建非root用户运行应用程序
RUN groupadd -r plistserver && useradd -r -g plistserver plistserver

WORKDIR /app
COPY --from=builder /usr/src/app/target/release/plistserver /app/plistserver

# 更改所有权
RUN chown -R plistserver:plistserver /app

# 切换到非root用户
USER plistserver

EXPOSE 3788

CMD ["./plistserver"]
