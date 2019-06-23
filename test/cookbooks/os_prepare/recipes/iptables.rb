# encoding: utf-8
# author: Stephan Renatus

case node['platform']
when 'ubuntu', 'rhel', 'centos', 'fedora'
  execute 'iptables -A INPUT -i eth0 -p tcp -m tcp '\
          '--dport 80 -m state --state NEW -m comment '\
          '--comment "http on 80" -j ACCEPT'
  execute 'iptables -N derby-cognos-web'
  execute 'iptables -A INPUT -j derby-cognos-web'
  execute 'iptables -A derby-cognos-web -p tcp -m tcp --dport 80 '\
          '-m comment --comment "derby-cognos-web" -j ACCEPT'
  # IPv6
  execute "ip6tables -A INPUT -i eth0 -p tcp -m tcp "\
          "--dport 80 -m state --state NEW -m comment "\
          '--comment "http v6 on 80" -j ACCEPT'
  execute "ip6tables -N derby-cognos-web-v6"
  execute "ip6tables -A INPUT -j derby-cognos-web-v6"
  execute "ip6tables -A derby-cognos-web-v6 -p tcp -m tcp --dport 80 "\
          '-m comment --comment "derby-cognos-web-v6" -j ACCEPT'
end
