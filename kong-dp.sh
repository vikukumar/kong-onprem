kubectl create secret generic kong-enterprise-license -n kong-dp \
  --from-file=license=license.json \
  --dry-run=client -o yaml | kubectl apply -f -

kubectl create secret tls kong-cluster-cert -n kong-dp \
 --cert=./dp1-tls-bundle.crt \
 --key=./dp1-tls.key

kubectl create secret generic kong-ca-cert -n kong-dp \
 --from-file=ca.crt=./CA.crt

 kubectl create secret tls kong-tls-cert -n kong-dp \
 --cert=./tls.crt \
 --key=./tls.key


helm upgrade --install kong-dp kong/kong --namespace kong-dp -f kong-dp.yaml