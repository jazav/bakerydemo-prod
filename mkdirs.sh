# Creating Log Structure
if [ ! -d log ]; then
  mkdir -p log;
  sudo chmod -R 777 log;
fi

if [ ! -d log/nginx ]; then
  mkdir -p log/nginx;
  sudo chmod -R 777 log/nginx;
fi

if [ ! -d log/uwsgi ]; then
  mkdir -p log/uwsgi;
  sudo chmod -R 777 log/uwsgi;
fi

if [ ! -d log/postgresql ]; then
  mkdir -p log/postgresql;
  sudo chmod -R 777 log/postgresql;
fi
echo >&2 "Log...is created"

# Creating Data Structure
if [ ! -d data ]; then
  mkdir -p data;
  sudo chmod -R 777 data;
fi

if [ ! -d data/postgresql ]; then
  mkdir -p data/postgresql;
  sudo chmod -R 777 data/postgresql;
fi

if [ ! -d data/nginx ]; then
  mkdir -p data/nginx;
  sudo chmod -R 777 data/nginx;
fi

if [ ! -d data/uwsgi ]; then
  mkdir -p data/uwsgi;
  sudo chmod -R 777 data/uwsgi;
fi
echo >&2 "Data..is created"

# Creating Media Structure
if [ ! -d media ]; then
  mkdir -p media;
  sudo chmod -R 777 media;
fi

if [ ! -d media/original_images ]; then
  mkdir -p media/original_images;
  sudo chmod -R 777 media/original_images;
fi
echo >&2 "Media.is created"