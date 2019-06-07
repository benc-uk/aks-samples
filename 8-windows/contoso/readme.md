# Application
This is the standard ASP<span></span>.NET Framework demo application 'Contoso Sports'

No source code changes have been made, only a `Dockerfile` has been added to run it as a container.

# Building
This was done in Azure Pipelines, see `build-pipeline.yml`

# Deploy
Change hostname in `ingress.yaml`
```
cd 8-windows/contoso
kubectl apply -f .
```

# Database
The will try to connect to a MSSQL Server instance by DNS name `sqlserver` and use a database called `sportsdb`

The `mssql.yaml` will deploy the MSSQL Server as a pod and create a service called `sqlserver` the only manual step is the creation of the database which can be done as follows

NOTE. No
```
export SQLPOD=$(kubectl get po -l app=mssql -o jsonpath='{.items[0].metadata.name}')
kubectl exec -it $SQLPOD -- /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Password123! -Q "create database sportsdb"
```