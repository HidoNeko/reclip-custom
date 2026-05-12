# ReClip Custom

Công cụ tải video và âm thanh mã nguồn mở với giao diện web sạch sẽ. Hỗ trợ tải từ YouTube, TikTok, Instagram, Twitter/X và hơn 1000 trang web khác — định dạng MP4 hoặc MP3.

![ReClip MP3 Mode](assets/preview-mp3.png)

## Tính năng

- Tải video từ hơn 1000 trang web (thông qua [yt-dlp](https://github.com/yt-dlp/yt-dlp))
- Xuất định dạng video MP4 hoặc tách nhạc MP3
- Tùy chọn chất lượng/độ phân giải
- Tải hàng loạt — dán nhiều link cùng lúc
- Tự động loại bỏ link trùng lặp
- Giao diện sạch, phản hồi nhanh (Responsive)
- Backend đơn giản bằng Python Flask

## Hướng dẫn cài đặt (Ubuntu)

### 1. Cài đặt các gói hệ thống
Yêu cầu Python 3 và FFmpeg để ghép âm thanh cho video chất lượng cao:

```bash
sudo apt update
sudo apt install -y python3-pip python3-venv ffmpeg
```

### 2. Thiết lập môi trường
```bash
git clone https://github.com/HidoNeko/reclip-custom
cd reclip-custom
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

### 3. Chạy ứng dụng với Gunicorn (Đề xuất)
Sử dụng Gunicorn để hỗ trợ xử lý song song nhiều luồng:

```bash
gunicorn --workers 1 --threads 8 --bind 0.0.0.0:8899 app:app
```

Sau đó truy cập địa chỉ: `http://<IP-cua-ban>:8899`

### 4. Chạy với PM2 (Quản lý tiến trình)

PM2 giúp ứng dụng chạy ngầm, tự động khởi động lại nếu bị lỗi hoặc sau khi reboot máy chủ.

**Cài đặt PM2 (nếu chưa có):**
```bash
sudo npm install -g pm2
```

**Chạy với Gunicorn qua PM2 (Khuyên dùng):**
```bash
pm2 start "gunicorn --workers 1 --threads 4 --bind 0.0.0.0:8899 app:app" --name "reclip-custom"
```

**Hoặc chạy trực tiếp bằng Python:**
```bash
pm2 start app.py --name "reclip-custom" --interpreter ./venv/bin/python
```

**Quản lý ứng dụng:**
- `pm2 status`: Xem danh sách ứng dụng đang chạy.
- `pm2 logs reclip-custom`: Xem log (nhật ký) của ứng dụng.
- `pm2 restart reclip-custom`: Khởi động lại.
- `pm2 stop reclip-custom`: Dừng ứng dụng.
- `pm2 save`: Lưu cấu hình để tự khởi động lại sau khi reboot server (cần chạy `pm2 startup` trước).

## Chạy với Docker

```bash
docker build -t reclip-custom .
docker run -p 8899:8899 reclip-custom
```

## Cách sử dụng

1. Dán một hoặc nhiều URL video vào ô nhập liệu
2. Chọn định dạng **MP4** (video) hoặc **MP3** (âm thanh)
3. Nhấn **Fetch** để tải thông tin video và ảnh thu nhỏ
4. Chọn chất lượng/độ phân giải mong muốn
5. Nhấn **Download** cho từng video hoặc **Download All**

## Công nghệ sử dụng

- **Backend:** Python + Flask
- **Frontend:** Vanilla HTML/CSS/JS
- **Download engine:** [yt-dlp](https://github.com/yt-dlp/yt-dlp) + [ffmpeg](https://ffmpeg.org/)

