#!/bin/bash
#
# in order to run this script, you should kubernetes cli setup
# or, you will need to cluster adresss, username, password
#
URL=`kubectl cluster-info | grep "Kubernetes master" | awk '{print $6}'`
HOST=`echo $URL | cut -d'/' -f3 | cut -d':' -f1`

HOST_IP=${1:-$HOST}
ICPCLUSTERADMIN=${2:-admin}
ICPCLUSTERADMINPASSWORD=${3:-admin}

echo "HOST_IP -> $HOST_IP"

BEARER=$(curl -H "Content-Type: application/x-www-form-urlencoded;charset=UTF-8" \
-d "grant_type=password&username="$ICPCLUSTERADMIN"&password="$ICPCLUSTERADMINPASSWORD"&scope=openid" \
https://$HOST_IP:8443/idprovider/v1/auth/identitytoken --insecure | \
jq '.access_token' | tr -d '"')
echo "BEARER: $BEARER"

curl -k -X POST \
  https://$HOST_IP:8443/idmgmt/identity/api/v1/teams \
  -H "Authorization: bearer ${BEARER}" \
  -H "content-type: application/json" \
  -d '{
	     "name": "CatalogTestTeam",
	     "teamId": "CatalogTestTeam",
	     "users": [{
			      "userId": "admin1",
			      "firstName": "Admin1",
			      "lastName": "Admin1",
			      "email": "admin1@foo.bar",
                  "userBaseDN": "uid=admin1,ou=People,dc=local,dc=io",
			      "roles": [{"id": "crn:v1:icp:private:iam::::role:Administrator"}]
		      },
		      {
			      "userId": "admin10",
			      "firstName": "Admin10",
			      "lastName": "Admin10",
			      "email": "admin10@foo.bar",
			      "userBaseDN": "uid=admin10,ou=People,dc=local,dc=io",
			      "roles": [{"id": "crn:v1:icp:private:iam::::role:ClusterAdministrator"}]
		      },
		      {
			      "userId": "editor1",
			      "firstName": "Editor1",
			      "lastName": "Editor1",
			      "email": "editor1@foo.bar",
			      "userBaseDN": "uid=editor1,ou=People,dc=local,dc=io",
			      "roles": [{"id": "crn:v1:icp:private:iam::::role:Editor"}]
		      },
		      {
			      "userId": "operator1",
			      "firstName": "Operator1",
			      "lastName": "Operator1",
			      "email": "operator1@foo.bar",
			      "userBaseDN": "uid=operator1,ou=People,dc=local,dc=io",
			      "roles": [{"id": "crn:v1:icp:private:iam::::role:Operator"}]
		      },
		      {
			      "userId": "viewer1",
			      "firstName": "Viewer1",
			      "lastName": "Viewer1",
			      "email": "viewer1@foo.bar",
			      "userBaseDN": "uid=viewer1,ou=People,dc=local,dc=io",
			      "roles": [{"id": "crn:v1:icp:private:iam::::role:Viewer"}]
		      }
	      ],
	      "usergroups": []
      }' \
  --insecure


  curl -k -X POST \
    https://$HOST_IP:8443/idmgmt/identity/api/v1/teams \
    -H "Authorization: bearer ${BEARER}" \
    -H "content-type: application/json" \
    -d '{
  	     "name": "DevTeam",
  	     "teamId": "DevTeam",
  	     "users": [
  		      {
  			      "userId": "dev1",
  			      "firstName": "Dev1",
  			      "lastName": " ",
  			      "email": "dev1@foo.bar",
  			      "userBaseDN": "uid=dev1,ou=People,dc=local,dc=io",
  			      "roles": [{"id": "crn:v1:icp:private:iam::::role:Operator"}]
  		      },
            {
             "userId": "dev2",
             "firstName": "Dev2",
             "lastName": " ",
             "email": "dev2@foo.bar",
             "userBaseDN": "uid=dev2,ou=People,dc=local,dc=io",
             "roles": [{"id": "crn:v1:icp:private:iam::::role:Editor"}]
           },
           {
             "userId": "dev3",
             "firstName": "Dev3",
             "lastName": " ",
             "email": "dev3@foo.bar",
             "userBaseDN": "uid=dev3,ou=People,dc=local,dc=io",
             "roles": [{"id": "crn:v1:icp:private:iam::::role:Viewer"}]
           }
  	      ],
  	      "usergroups": []
        }' \
    --insecure


    curl -k -X POST \
      https://$HOST_IP:8443/idmgmt/identity/api/v1/teams \
      -H "Authorization: bearer ${BEARER}" \
      -H "content-type: application/json" \
      -d '{
           "name": "ProdTeam",
           "teamId": "ProdTeam",
           "users": [
              {
                "userId": "prod1",
                "firstName": "Prod1",
                "lastName": " ",
                "email": "prod1@foo.bar",
                "userBaseDN": "uid=prod1,ou=People,dc=local,dc=io",
                "roles": [{"id": "crn:v1:icp:private:iam::::role:Operator"}]
              },
              {
               "userId": "prod2",
               "firstName": "Prod2",
               "lastName": " ",
               "email": "prod2@foo.bar",
               "userBaseDN": "uid=prod2,ou=People,dc=local,dc=io",
               "roles": [{"id": "crn:v1:icp:private:iam::::role:Editor"}]
             },
             {
               "userId": "prod3",
               "firstName": "Prod3",
               "lastName": " ",
               "email": "prod3@foo.bar",
               "userBaseDN": "uid=prod3,ou=People,dc=local,dc=io",
               "roles": [{"id": "crn:v1:icp:private:iam::::role:Viewer"}]
             }
            ],
            "usergroups": []
          }' \
      --insecure

      curl -k -X POST \
        https://$HOST_IP:8443/idmgmt/identity/api/v1/teams \
        -H "Authorization: bearer ${BEARER}" \
        -H "content-type: application/json" \
        -d '{
             "name": "TestTeam",
             "teamId": "TestTeam",
             "users": [
                {
                  "userId": "test1",
                  "firstName": "Test1",
                  "lastName": " ",
                  "email": "test1@foo.bar",
                  "userBaseDN": "uid=test1,ou=People,dc=local,dc=io",
                  "roles": [{"id": "crn:v1:icp:private:iam::::role:Operator"}]
                },
                {
                 "userId": "test2",
                 "firstName": "Test2",
                 "lastName": " ",
                 "email": "test2@foo.bar",
                 "userBaseDN": "uid=test2,ou=People,dc=local,dc=io",
                 "roles": [{"id": "crn:v1:icp:private:iam::::role:Editor"}]
               },
               {
                 "userId": "test3",
                 "firstName": "Test3",
                 "lastName": " ",
                 "email": "test3@foo.bar",
                 "userBaseDN": "uid=test3,ou=People,dc=local,dc=io",
                 "roles": [{"id": "crn:v1:icp:private:iam::::role:Viewer"}]
               }
              ],
              "usergroups": []
            }' \
        --insecure
