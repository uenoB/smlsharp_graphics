FROM debian:bookworm-slim AS base
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt/lists,sharing=locked \
    rm -f /etc/apt/apt.conf.d/docker-clean \
 && apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get upgrade --no-install-recommends -y

FROM base AS build
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt/lists,sharing=locked \
    apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
      build-essential \
      ca-certificates \
      libgl-dev \
      libglu1-mesa-dev \
      libglut-dev \
      libgmp-dev \
      llvm-19-dev \
      wget
WORKDIR /root
RUN wget https://github.com/massivethreads/massivethreads/archive/refs/tags/v1.02.tar.gz
RUN wget https://github.com/smlsharp/smlsharp/releases/download/v4.2.0/smlsharp-4.2.0.tar.gz
RUN tar -xzf v1.02.tar.gz
RUN cd massivethreads-1.02 \
 && ./configure --enable-shared --disable-static \
 && make -j$(grep '^processor' /proc/cpuinfo | wc -l) \
 && make install
RUN ldconfig
RUN tar -xzf smlsharp-4.2.0.tar.gz
RUN cd smlsharp-4.2.0 \
 && ./configure --with-llvm=/usr/lib/llvm-19 \
 && make -j$(grep '^processor' /proc/cpuinfo | wc -l) \
 && make install
COPY graphics/ /root/graphics/graphics/
COPY graphics_repl/ /root/graphics/graphics_repl/
RUN cd graphics/graphics_repl \
 && sed -i -e '/"-r"/d' compiler.sml \
 && make SMLSHARP_SRCDIR=/root/smlsharp-4.2.0
RUN cd graphics \
 && tar -cf - */*.o */*.smi | tar -C /usr/local/lib/smlsharp -xf -
RUN exec >> /usr/local/lib/smlsharp/prelude.smi \
 && echo 'include "./graphics/graphics.smi"' \
 && echo 'include "./graphics_repl/easytop.smi"'
RUN cp graphics/graphics_repl/smlsharp_graphics_repl /usr/local/bin/smlsharp
RUN mkdir /root/DEST \
 && tar -cf - \
      /usr/local/bin/smlsharp \
      /usr/local/lib/libmyth.so* \
      /usr/local/lib/smlsharp \
    | tar -C /root/DEST -xf -

FROM base
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt/lists,sharing=locked \
    apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
      gcc \
      llvm-19 \
      libc-dev \
      libgmp-dev \
      libgl1 \
      libglu1-mesa \
      libglut3.12 \
      rlwrap
COPY --from=build /root/DEST/ /
RUN ldconfig
ARG TZ=Asia/Tokyo
RUN ln -sf "/usr/share/zoneinfo/$TZ" /etc/localtime \
 && echo "$TZ" > /etc/timezone
RUN useradd -m -s /usr/local/bin/smlsharp_entry smlsharp
COPY wsl/root/ / 
