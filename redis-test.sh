docker network disconnect redix_test_default redix_test-redis-1
echo "network down"
echo "sleeping"
sleep 1
docker network connect redix_test_default redix_test-redis-1
echo "network up"
