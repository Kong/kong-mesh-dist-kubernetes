#!/bin/sh

http get kong-admin:8001 && \
http --ignore-stdin put kong-admin:8001/services/service-b host=serviceb port=8080 protocol=tcp -f && \
http --ignore-stdin post kong-admin:8001/services/service-b/routes name=service-b sources[1].ip=0.0.0.0/0 protocols=tcp -f
