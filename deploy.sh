docker build -t ryurikk/multi-client:latest -t ryurikk/multi-client:$SHA -f ./client/DockerFile ./client
docker build -t ryurikk/multi-server:latest -t ryurikk/multi-server:$SHA -f ./server/DockerFile ./server
docker build -t ryurikk/multi-worker:latest -t ryurikk/multi-worker:$SHA -f ./worker/DockerFile ./worker

docker push ryurikk/multi-client:latest
docker push ryurikk/multi-server:latest
docker push ryurikk/multi-worker:latest

docker push ryurikk/multi-client:$SHA
docker push ryurikk/multi-server:$SHA
docker push ryurikk/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ryurikk/multi-server:$SHA
kubectl set image deployments/client-deployment client=ryurikk/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ryurikk/multi-worker:$SHA