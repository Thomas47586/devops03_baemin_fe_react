# 1. Tải image NodeJS bản 24 làm môi trường nền
FROM node:24

# 2. Tạo và chuyển vào thư mục làm việc trong container
WORKDIR /frontend_nextjs

# 3. Copy file định nghĩa thư viện vào container trước (để tối ưu cache)
COPY package.json .

# 4. Tăng thời gian chờ kết nối mạng lên 50 phút để tránh lỗi timeout
RUN  yarn config set network-timeout 3000000

# 5. Cài đặt các thư viện cần thiết
RUN yarn install

# 6. Copy toàn bộ mã nguồn còn lại vào container
COPY . .

# 7. Build project => Đóng gói source code
RUN yarn run build

# Thông báo container sẽ mở cổng 3000
EXPOSE 3000

# 8. Lệnh chạy server khi container khởi động
CMD ["yarn", "start"]

# --- LỆNH CHẠY TRÊN TERMINAL (Bỏ dấu # ở đầu khi gõ vào Terminal) ---
# Build image:
# docker build . -t img-beamin

# Run container:
# docker run -d -p 3001:3000 --name beamin_nextjs img-beamin