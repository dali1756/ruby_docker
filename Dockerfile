FROM ruby:3.3.4-slim

LABEL maintainer="Jeter <jeter.chen@gmail.com>"

# slim 版本使用 apt-get，alpine 版本使用 apk
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    # 刪除 slim 版本緩存包內容，安裝完就不需要了
    && rm -rf /var/lib/apt/lists/*

# 建立容器內的資料夾
WORKDIR /app

# 複製需要的 Gemfile
COPY Gemfile* .

# install Gem
RUN bundle install

# 將專案中所有文件 copy to docker container
# 第一個 . 是專案目錄，第二個 . 是容器內的當前目錄
COPY . .

# 告訴 docker 應該要監聽哪個 port
EXPOSE 3000

# 啟動時要執行的預設命令
CMD ["rails", "server", "-b", "0.0.0.0"]