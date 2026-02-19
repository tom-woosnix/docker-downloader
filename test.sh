docker run -d \
  --name seerr \
  --init \
  -e LOG_LEVEL=debug \
  -e TZ=Asia/Tashkent \
  -e PORT=5055 \
  -p 5055:5055 \
  -v /path/to/appdata/config:/app/config \
  --restart unless-stopped \
  --health-cmd "wget --no-verbose --tries=1 --spider http://localhost:5055/api/v1/status || exit 1" \
  --health-start-period 20s \
  --health-timeout 3s \
  --health-interval 15s \
  --health-retries 3 \
  ghcr.io/seerr-team/seerr:latest
