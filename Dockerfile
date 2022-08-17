FROM public.ecr.aws/docker/library/docker:20.10

RUN apk add bash

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
