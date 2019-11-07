sleep 5
if curl web | grep -q '

Welcome to Docker !
'; then echo "Success!" exit 0 else echo "Failed!" exit 1 fi