
  alias gitrefresh='git checkout origin/master -f | git checkout master -f | git pull origin master'
  alias klogin='cloudctl login -a https://mycluster.icp:8443 --skip-ssl-validation -u admin -p admin -n services  -c id-mycluster-account'
  alias kns='echo "kubectl config set-context mycluster-context --user=admin --namespace="'
  alias hlist='helm list -d -r --tls'
  alias hkill='helm delete --tls --purge '
  alias icpstatus='sudo watch -n 5 "docker ps -n15 --format \"table {{.RunningFor}}\\t{{.Status}}\\t{{.Command}}\\t{{.Names}}\" | cut -c -140"'
  alias pkill='kubectl delete pod --force --grace-period 0 '
  alias plist='kubectl get pods --sort-by='{.metadata.creationTimestamp}' -o wide'
  alias pinspect='kubectl get pod -o yaml '
  alias plog='kubectl logs '
  alias pdesc='kubectl describe pod '
  alias dsearch='docker ps | grep '
  alias dlist='docker ps -n15 --format "table {{.RunningFor}}\\t{{.Status}}\\t{{.Command}}\\t{{.Names}}" | cut -c -140'
  alias dlistall='docker ps -n15 -a --format "table {{.RunningFor}}\\t{{.Status}}\\t{{.Command}}\\t{{.Names}}" | cut -c -140'
  alias dlog='docker logs '
  alias ..='cd ..'
  ## Colorize the ls output ##
  alias ls='ls --color=auto'
  alias edit_placement='KUBE_EDITOR="nano" kubectl edit pp --namespace default'
  alias get_clusters='mcmctl get clusters --all-namespaces'
  alias get_deployables='mcmctl get deployables --all-namespaces'
  alias get_work='mcmctl get work --all-namespaces'
  alias netwrk='nmtui'

    function stresstest()
    {
    echo "Starting busybox";
    echo "then start    yes > /dev/null & ";
    docker run -it --rm busybox
    }
