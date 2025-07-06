pip install passlib
htpasswd -cb .htpasswd test test
docker build -t internal-pypi .

docker run -d \
  --name internal-pypi \
  -p 8080:8080 \
  -v $(pwd)/packages:/packages \
  internal-pypi
