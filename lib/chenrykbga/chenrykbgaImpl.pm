package chenrykbga::chenrykbgaImpl;
use strict;
use Bio::KBase::Exceptions;
# Use Semantic Versioning (2.0.0-rc.1)
# http://semver.org 
our $VERSION = "0.1.0";

=head1 NAME

chenrykbga

=head1 DESCRIPTION

The SDK version of the KBaase Genome Annotation Service.
This wraps genome_annotation which is based off of the SEED annotations.

=cut

#BEGIN_HEADER
use Bio::KBase::AuthToken;
use Bio::KBase::workspace::Client;
use Config::IniFiles;
use Data::Dumper;
########################################################################
# Authors: Shane Canon, Christopher Henry
# Date: 11/14/2016
# Contact email: chenry@mcs.anl.gov
# Development location: Mathematics and Computer Science Division, Argonne National Lab
########################################################################
use warnings;
use JSON::XS;
use DateTime;
use Digest::MD5;
use Getopt::Long;
use Bio::KBase::GenomeAnnotation::Client;
use chenrykbga::gawrapper;
use Bio::KBase::workspace::ScriptHelpers qw(get_ws_client workspace workspaceURL parseObjectMeta parseWorkspaceMeta printObjectMeta);

#END_HEADER

sub new
{
    my($class, @args) = @_;
    my $self = {
    };
    bless $self, $class;
    #BEGIN_CONSTRUCTOR

    my $config_file = $ENV{ KB_DEPLOYMENT_CONFIG };
    my $cfg = Config::IniFiles->new(-file=>$config_file);
    my $wsInstance = $cfg->val('chenrykbga','workspace-url');
    die "no workspace-url defined" unless $wsInstance;

    $self->{'workspace-url'} = $wsInstance;

    #END_CONSTRUCTOR

    if ($self->can('_init_instance'))
    {
	$self->_init_instance();
    }
    return $self;
}

=head1 METHODS



=head2 annotate_genome

  $return = $obj->annotate_genome($params)

=over 4

=item Parameter and return types

=begin html

<pre>
$params is an UnspecifiedObject, which can hold any non-null object
$return is a chenrykbga.AnnotateGenomeResults
AnnotateGenomeResults is a reference to a hash where the following keys are defined:
	workspace has a value which is a chenrykbga.workspace_name
	id has a value which is a string
workspace_name is a string

</pre>

=end html

=begin text

$params is an UnspecifiedObject, which can hold any non-null object
$return is a chenrykbga.AnnotateGenomeResults
AnnotateGenomeResults is a reference to a hash where the following keys are defined:
	workspace has a value which is a chenrykbga.workspace_name
	id has a value which is a string
workspace_name is a string


=end text



=item Description

annotate genome
params - a param hash that includes the workspace id and options

=back

=cut

sub annotate_genome
{
    my $self = shift;
    my($params) = @_;

    my @_bad_arguments;
    (defined $params) or push(@_bad_arguments, "Invalid type for argument \"params\" (value was \"$params\")");
    if (@_bad_arguments) {
	my $msg = "Invalid arguments passed to annotate_genome:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'annotate_genome');
    }

    my $ctx = $chenrykbga::chenrykbgaServer::CallContext;
    my($return);
    #BEGIN annotate_genome
    chenrykbga::gawrapper::annotate($self->{'workspace-url'}, $ctx->token,$params);
    $return={'workspace'=>'blah','id'=>'1'};
    #END annotate_genome
    my @_bad_returns;
    (ref($return) eq 'HASH') or push(@_bad_returns, "Invalid type for return variable \"return\" (value was \"$return\")");
    if (@_bad_returns) {
	my $msg = "Invalid returns passed to annotate_genome:\n" . join("", map { "\t$_\n" } @_bad_returns);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'annotate_genome');
    }
    return($return);
}




=head2 version 

  $return = $obj->version()

=over 4

=item Parameter and return types

=begin html

<pre>
$return is a string
</pre>

=end html

=begin text

$return is a string

=end text

=item Description

Return the module version. This is a Semantic Versioning number.

=back

=cut

sub version {
    return $VERSION;
}

=head1 TYPES



=head2 contigset_id

=over 4



=item Description

A string representing a ContigSet id.


=item Definition

=begin html

<pre>
a string
</pre>

=end html

=begin text

a string

=end text

=back



=head2 workspace_name

=over 4



=item Description

A string representing a workspace name.


=item Definition

=begin html

<pre>
a string
</pre>

=end html

=begin text

a string

=end text

=back



=head2 AnnotateGenomeResults

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
workspace has a value which is a chenrykbga.workspace_name
id has a value which is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
workspace has a value which is a chenrykbga.workspace_name
id has a value which is a string


=end text

=back



=cut

1;
