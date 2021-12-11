if [ ! -d log ]; then
  mkdir -p log;

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

if [ ! -d data ]; then
  mkdir -p data;
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