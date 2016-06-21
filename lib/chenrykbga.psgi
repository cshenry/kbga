use chenrykbga::chenrykbgaImpl;

use chenrykbga::chenrykbgaServer;
use Plack::Middleware::CrossOrigin;



my @dispatch;

{
    my $obj = chenrykbga::chenrykbgaImpl->new;
    push(@dispatch, 'chenrykbga' => $obj);
}


my $server = chenrykbga::chenrykbgaServer->new(instance_dispatch => { @dispatch },
				allow_get => 0,
			       );

my $handler = sub { $server->handle_input(@_) };

$handler = Plack::Middleware::CrossOrigin->wrap( $handler, origins => "*", headers => "*");
