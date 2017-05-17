# don't change this file
# variables are loading in {{repo_env}}/bin/activate by the next order
# 1. /etc/{{name}}.sh
# 2. this file
# so rewrite you variables in /etc/{{name}}.sh
LANG=en_US.UTF-8
LANGUAGE=en_US:en
LC_ALL=en_US.UTF-8
PYTHONIOENCODING="utf-8"
PYTHONUNBUFFERED=1

HOST=${HOST:-localhost}
DB_HOST=${DB_HOST:-localhost}
DB_NAME=${DB_NAME:-'{{name}}'}
[ -n "${HOST_SSL:-}" ] && [ "$HOST" != 'localhost' ] && SSL='s' || SSL=''

# TODO: client related
SUPERDESK_WS_URL=${SUPERDESK_WS_URL:-"ws$SSL://$HOST/ws"}

# TODO: need to get rid this for proper SaaS
SUPERDESK_CLIENT_URL=${SUPERDESK_CLIENT_URL:-"http$SSL://$HOST"}

# To work properly inside and outside container, must be
# - "proxy_set_header Host <host>;" in nginx
# - the same "<host>" for next two settings
# TODO: try to fix at backend side, it should accept any host
SUPERDESK_URL=${SUPERDESK_URL:-"http$SSL://$HOST/api"}
CONTENTAPI_URL=${CONTENTAPI_URL:-"http$SSL://$HOST/contentapi"}

MONGO_URI=${MONGO_URI:-"mongodb://$DB_HOST/$DB_NAME"}
LEGAL_ARCHIVE_URI=${LEGAL_ARCHIVE_URI:-"mongodb://$DB_HOST/${DB_NAME}_la"}
ARCHIVED_URI=${ARCHIVED_URI:-"mongodb://$DB_HOST/${DB_NAME}_ar"}
ELASTICSEARCH_URL=${ELASTICSEARCH_URL:-"http://$DB_HOST:9200"}
ELASTICSEARCH_INDEX=${ELASTICSEARCH_INDEX:-"$DB_NAME"}

CONTENTAPI_ELASTICSEARCH_INDEX=${CONTENTAPI_ELASTICSEARCH_INDEX:-"${DB_NAME}_ca"}
# TODO: fix will be in 1.6 release, keep it for a while
CONTENTAPI_ELASTIC_INDEX=$CONTENTAPI_ELASTICSEARCH_INDEX
CONTENTAPI_MONGO_URI=${CONTENTAPI_MONGO_URI:-"mongodb://$DB_HOST/${CONTENTAPI_ELASTICSEARCH_INDEX}"}

REDIS_URL=${REDIS_URL:-redis://$DB_HOST:6379/1}

C_FORCE_ROOT=1
CELERYBEAT_SCHEDULE_FILENAME=${CELERYBEAT_SCHEDULE_FILENAME:-/tmp/celerybeatschedule}
CELERY_BROKER_URL=${CELERY_BROKER_URL:-$REDIS_URL}

# TODO: remove after full adoption of MEDIA_PREFIX
AMAZON_SERVE_DIRECT_LINKS=${AMAZON_SERVE_DIRECT_LINKS:-True}
AMAZON_S3_USE_HTTPS=${AMAZON_S3_USE_HTTPS:-True}
if [ -n "$AMAZON_CONTAINER_NAME" ]; then
    AMAZON_S3_SUBFOLDER=${AMAZON_S3_SUBFOLDER:-'{{db_name}}'}
    MEDIA_PREFIX=${MEDIA_PREFIX:-"http$SSL://$HOST/api/upload-raw"}
fi

if [ -n "${SUPERDESK_TESTING:-}" ]; then
    SUPERDESK_TESTING=True
    CELERY_ALWAYS_EAGER=True
    ELASTICSEARCH_BACKUPS_PATH=/var/tmp/elasticsearch
    LEGAL_ARCHIVE=True
fi
