#!/usr/bin/perl
use Data::Dumper;
use Carp;
use Time::HiRes qw(time sleep);
use Getopt::Long;

$usage = <<EOS;
$0 cmd options
   valid commands:
      grafana [port]
		   starts grafana default port 3000
			!!!WARNING!!! this will delete old dashboards and data sources
      redisAdapter adapterPort redisPort
         connect with grafana simplejson at http://localhost:adapterPort
			test with http://localhost:adapterPort/ and http://localhost:adapterPort/search
      build
		   creates RedisGrafana container
   options:
EOS

GetOptions(
   'stringparam=s' => \$options{stringparam},
   'booleanparam' => \$options{booleanparam}
   );

confess $usage
   if !@ARGV;

$command = shift;

if($command eq 'grafana')
{
	my $port = shift;
	$port = 3000
		if !$port;
	execute("sed 's/3000/$port/' grafanaDefaults.ini > defaults.ini");
	my $cmd = <<EOS;
sudo docker run -itd --name=grafana --net=host  -v \$(pwd)/defaults.ini:/usr/share/grafana/conf/defaults.ini  -e "GF_INSTALL_PLUGINS=grafana-simple-json-datasource" grafana/grafana:latest
EOS
	execute("sudo docker rm -f grafana");
	execute($cmd);
}
elsif($command eq 'redisAdapter')
{
	my ($adapterPort, $redisPort) = @ARGV;

	confess $usage
		if !$adapterPort || !$redisPort;

	my $name = "Redis_" . $redisPort . "_Grafana_" . $adapterPort;
	execute("sudo docker rm -f $name");
	my $cmd = <<EOS;
sudo docker run -itd --net=host --name $name redisgrafana /app/GrafanaDatastoreServer.py --host 127.0.0.1 --port $adapterPort --redis-server 127.0.0.1 --redis-port $redisPort 
EOS
	execute($cmd);
}
elsif($command eq 'build')
{
	execute("sudo docker build -t redisgrafana .");
}
else
{
   confess $usage;
}

sub execute
{
	my $cmd = shift;
	open $f, "$cmd |";
	print
		while <$f>;
}
