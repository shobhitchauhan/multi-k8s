docker build -t schauhan27/docker-multi-client:latest -t schauhan27/docker-multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t schauhan27/docker-multi-server:latest -t schauhan27/docker-multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t schauhan27/docker-multi-worker:latest -t schauhan27/docker-multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push schauhan27/docker-multi-client:latest
docker push schauhan27/docker-multi-server:latest
docker push schauhan27/docker-multi-worker:latest
docker push schauhan27/docker-multi-client:$SHA
docker push schauhan27/docker-multi-server:$SHA
docker push schauhan27/docker-multi-worker:$SHA
kubectl apply -f config
kubectl set image deployments/client-deployment server=schauhan27/docker-multi-client:$SHA
kubectl set image deployments/server-deployment server=schauhan27/docker-multi-server:$SHA
kubectl set image deployments/worker-deployment server=schauhan27/docker-multi-worker:$SHA
