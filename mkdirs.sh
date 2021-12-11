# Creating Log Structure
if [ ! -d log ]; then
  mkdir -p log;
  sudo chmod -R 777 log;
fi

if [ ! -d log/nginx ]; then
  mkdir -p log/nginx;
fi

if [ ! -d log/uwsgi ]; then
  mkdir -p log/uwsgi;
fi

if [ ! -d log/postgresql ]; then
  mkdir -p log/postgresql;
fi
echo >&2 "Log...is created"

# Creating Data Structure
if [ ! -d data ]; then
  mkdir -p data;
  sudo chmod -R 777 data;
fi

if [ ! -d data/postgresql ]; then
  mkdir -p data/postgresql;
fi

if [ ! -d data/nginx ]; then
  mkdir -p data/nginx;
fi

if [ ! -d data/uwsgi ]; then
  mkdir -p data/uwsgi;
fi
echo >&2 "Data..is created"

# Creating Media Structure
if [ ! -d media ]; then
  mkdir -p media;
  sudo chmod -R 777 media;
fi

if [ ! -d bakerydemo/media/original_images ]; then
  mkdir -p bakerydemo/media/original_images;
fi
echo >&2 "Media.is created"