echo "Now we have seen our development environment version, we can now approve to production"
echo "To approve to production you need to approve the automatically created PR in the source repo here"
echo "https://github.com/weavegitops/application-podinfo/pulls"
echo "There should now be a PR to approve."
read -n1 -s
echo "The prod environment will receive this change only when it is approved"
echo "To view the prod cluster you will need to port forward the podinfo service"
echo "For example:" 
echo "kubectl --context=policy25-admin@policy25 port-forward svc/podinfo -n application-podinfo 8090:9898"
echo "Then connect your browser to http://localhost:8090"

