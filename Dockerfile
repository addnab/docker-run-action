FROM docker:19.03

RUN apk add --no-cache bash

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
