# Установка Docker ZvCULN
# https://docs.docker.com/engine/install/ubuntu/#install-using-the-convenience-script
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
apt install docker.io

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Список доступных команд
docker

# Информацию о Docker
sudo docker info

# Запустим тестовый контейнер
sudo docker run hello-world

# Поищем nginx
sudo docker search nginx

# Скачаем образ
sudo docker pull nginx

# Запустим контейнер
sudo docker run -d --name nginx -p 80:80 -v /var/www/html:/usr/share/nginx/html nginx

# Список активных контейнеров
sudo docker ps

# Чтобы увидеть и активные, и неактивные контейнеры
sudo docker ps -a

# Зайдём в оболочку контейнера
sudo docker exec -ti nginx bash

# Остановка и запуск контейнеров
sudo docker stop sharp_volhard
sudo docker start d9b100f2f636

# Перезагрузка
sudo docker restart nginx

# Отправка сигнала
sudo docker kill -s HUP nginx

# Логи контейнера
sudo docker logs nginx

# Информация о контейнере
sudo docker inspect nginx

# Публичные порты
sudo docker port nginx

# Выполняющиеся процессы
sudo docker top nginx

# Использование ресурсов
sudo docker stats nginx

# Список образов
sudo docker images

# Просмотр истории образа
sudo docker history nginx

# Удаление контейнера
sudo docker rm nginx

# Удаление образа
sudo docker rmi nginx

# Удаление остановленных контейнеров без volume
docker rm $(docker ps -aq)

# Удаление всех контейнеров c анонимными volume для них
docker rm -fv $(docker ps -aq)

# Удалить все образы, которые в данный момент не используются в контейнерах
docker rmi $(docker images -q -f "dangling=true")

# Получить локальный IP контейнера
docker inspect --format="{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}"
# Полная очистка неиспользуемых контейнеров, сетей, образов и томов
docker system prune -a -f --volumes

# Дополнительные команды по обслуживанию
# Использование диска
docker system df
# Подробности
docker system df --verbose

docker system prune
docker system info

docker run --name angie -v /var/www/html:/usr/share/angie/html:ro -p 8800:80 -d docker.angie.software/angie:latest

sudo docker cp angie:/etc/angie/ /home/db/angie

docker run --name angie -v /var/www/html:/usr/share/angie/html:ro -v $(pwd)/angie:/etc/angie:ro -p 8800:80 -d docker.angie.software/angie:latest

docker run --name angie -v /var/www/html:/usr/share/angie/html:ro -p 8800:80 -d docker.angie.software/angie:latest

docker run --name angie_host -v /var/www/html:/usr/share/angie/html:ro -v $(pwd)/angie:/etc/angie:ro --network host -d docker.angie.software/angie:latest

docker run --rm -v /var/run/docker.sock:/var/run/docker.sock:ro assaflavie/runlike ID

sudo docker kill -s HUP angie

# Сборка (DEB)
apt source angie
apt build-dep angie
# Модифицируем ./debian/rules ./debian/changelog
dpkg-buildpackage -b
apt-mark hold angie

# Решение проблемы using cached C compiler ... not found
# rm -rf ../angie-feature-cache/*

./configure --prefix=/etc/angie --conf-path=/etc/angie/angie.conf --error-log-path=/var/log/angie/error.log --http-log-path=/var/log/angie/access.log --lock-path=/run/angie.lock --modules-path=/usr/lib/angie/modules --pid-path=/run/angie.pid --sbin-path=/usr/sbin/angie --http-acme-client-path=/var/lib/angie/acme --http-client-body-temp-path=/var/cache/angie/client_temp --http-fastcgi-temp-path=/var/cache/angie/fastcgi_temp --http-proxy-temp-path=/var/cache/angie/proxy_temp --http-scgi-temp-path=/var/cache/angie/scgi_temp --http-uwsgi-temp-path=/var/cache/angie/uwsgi_temp --user=angie --group=angie --with-file-aio --with-http_acme_module --with-http_addition_module --with-http_auth_request_module --with-http_dav_module --with-http_flv_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_mp4_module --with-http_random_index_module --with-http_realip_module --with-http_secure_link_module --with-http_slice_module --with-http_ssl_module --with-http_stub_status_module --with-http_sub_module --with-http_v2_module --with-http_v3_module --with-mail --with-mail_ssl_module --with-stream --with-stream_acme_module --with-stream_mqtt_preread_module --with-stream_rdp_preread_module --with-stream_realip_module --with-stream_ssl_module --with-stream_ssl_preread_module --with-threads --feature-cache=../angie-feature-cache --with-ld-opt='-Wl,-Bsymbolic-functions -flto=auto -ffat-lto-objects -Wl,-z,relro -Wl,-z,now' --with-openssl=/root/openssl-3.5.2

# AWL-LC SSL library
apt  install golang-go cmake ninja-build
cd /root
wget https://github.com/aws/aws-lc/archive/refs/tags/v1.61.4.tar.gz
tar -xvfz v1.61.4.tar.gz

cd /root/aws-lc-1.61.4/
cmake -GNinja -B build
ninja -C build

./configure --prefix=/etc/angie --conf-path=/etc/angie/angie.conf --error-log-path=/var/log/angie/error.log --http-log-path=/var/log/angie/access.log --lock-path=/run/angie.lock --modules-path=/usr/lib/angie/modules --pid-path=/run/angie.pid --sbin-path=/usr/sbin/angie --http-acme-client-path=/var/lib/angie/acme --http-client-body-temp-path=/var/cache/angie/client_temp --http-fastcgi-temp-path=/var/cache/angie/fastcgi_temp --http-proxy-temp-path=/var/cache/angie/proxy_temp --http-scgi-temp-path=/var/cache/angie/scgi_temp --http-uwsgi-temp-path=/var/cache/angie/uwsgi_temp --user=angie --group=angie --with-file-aio --with-http_acme_module --with-http_addition_module --with-http_auth_request_module --with-http_dav_module --with-http_flv_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_mp4_module --with-http_random_index_module --with-http_realip_module --with-http_secure_link_module --with-http_slice_module --with-http_ssl_module --with-http_stub_status_module --with-http_sub_module --with-http_v2_module --with-http_v3_module --with-mail --with-mail_ssl_module --with-stream --with-stream_acme_module --with-stream_mqtt_preread_module --with-stream_rdp_preread_module --with-stream_realip_module --with-stream_ssl_module --with-stream_ssl_preread_module --with-threads --feature-cache=../angie-feature-cache --with-ld-opt='-Wl,-Bsymbolic-functions -flto=auto -ffat-lto-objects -Wl,-z,relro -Wl,-z,now' --with-cc-opt=-I/root/aws-lc-1.61.4/include --with-ld-opt='-L/root/aws-lc-1.61.4/build/ssl -L/root/aws-lc-1.61.4/build/crypto'

make -j8
rm /etc/angie/koi-utf /etc/angie/win-utf
sudo checkinstall --pkgname=angie --pkgversion=1.11.0 --nodoc
