use kbga::kbgaImpl;

use kbga::kbgaServer;
use Plack::Middleware::CrossOrigin;



my @dispatch;

{
    my $obj = kbga::kbgaImpl->new;
    push(@dispatch, 'kbga' => $obj);
}


my $server = kbga::kbgaServer->new(instance_dispatch => { @dispatch },
				allow_get => 0,
			       );

my $handler = sub { $server->handle_input(@_) };

$handler = Plack::Middleware::CrossOrigin->wrap( $handler, origins => "*", headers => "*");
