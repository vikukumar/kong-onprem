kubectl create namespace kong-cp

kubectl create namespace kong-dp

kubectl create secret generic kong-enterprise-license -n kong-cp --from-file=license=license.json --dry-run=client -o yaml | kubectl apply -f -

kubectl create secret generic kong-session-config -n kong-cp \
 --from-literal=portal_session_conf='{"storage":"kong","secret":"super_secret_salt_string","cookie_name":"portal_session","cookie_samesite":"off","cookie_secure":false, "cookie_domain": ".local"}' \
 --from-literal=admin_gui_session_conf='{"cookie_name":"admin_session","cookie_samesite":"off","secret":"super_secret_salt_string","cookie_secure":false,"storage":"kong", "cookie_domain": ".local"}'


kubectl create secret generic kong-manager-password -n kong-cp \
 --from-literal=password=Vikash8029

kubectl create secret generic kong-cp-postgresql -n kong-cp \
 --from-literal=host="kong-cp-postgresql.kong-cp.svc.cluster.local" \
 --from-literal=password=Vikash8029


kubectl create secret tls kong-cluster-cert -n kong-cp \
 --cert=./cp-tls-bundle.crt \
 --key=./cp-tls.key

kubectl create secret generic kong-ca-cert -n kong-cp \
 --from-file=ca.crt=./CA.crt

helm upgrade --install kong-cp kong/kong --namespace kong-cp -f kong-cp.yaml