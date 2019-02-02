- Use https://github.com/Kong/kong-dist-kubernetes to run Kong
- Start a Service B that uses ncat to listen on 8080
- Start a Service A that sends `date` to Service B
- Start Kong as a mesh sidecar in the same pod as Service B
- Configure Kong and the pod iptables to send all traffic transparently through Kong

## Prerequisites

- kubectl
- access to a Kubernetes cluster

If you're running Linux and have docker installed you can use the Make task to install minikube
```
make setup_minikube
```

## Running

```
make build-docker-images && make run
```

Wait for things to be running
```
kubectl get all
```

Service B logs
```
kubectl logs -l app=serviceb
Fri Dec 7 19:46:51 UTC 2018
Ncat: Connection from 172.17.0.1.
Ncat: Connection from 172.17.0.1:53192.
Fri Dec 7 19:46:53 UTC 2018
```

Kong mesh logs.
```
kubectl logs -l app=servicea -c kong
172.17.0.13 [07/Dec/2018:19:47:58 +0000] TCP 200 0 0 0.000
2018/12/07 19:48:00 [info] 39#0: *18352 client 172.17.0.13:53772 connected to 0.0.0.0:7000
2018/12/07 19:48:00 [debug] 39#0: *18352 stream [lua] init.lua:628: balancer(): setting address (try 1): 10.100.100.10:8080
2018/12/07 19:48:00 [info] 39#0: *18352 proxy 172.17.0.13:53774 connected to 10.100.100.10:8080
2018/12/07 19:48:00 [info] 39#0: *18352 client disconnected, bytes from/to client:0/0, bytes from/to upstream:0/28
172.17.0.13 [07/Dec/2018:19:48:00 +0000] TCP 200 0 0 0.000
```

## Terminating

```
make clean
```
