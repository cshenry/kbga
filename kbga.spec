/*
A KBase module: kbga
This sample module contains one small method - count_contigs.
*/

module kbga {
	/*
	A string representing a ContigSet id.
	*/
	typedef string contigset_id;
	
	/*
	A string representing a workspace name.
	*/
	typedef string workspace_name;
	
	typedef structure {
	    int contig_count;
	} CountContigsResults;
	
	typedef structure {
	    workspace_name workspace;
	    string id;
	} AnnotateGenomeResults;
	
	/*
	Count contigs in a ContigSet
	contigset_id - the ContigSet to count.
	*/
	funcdef count_contigs(workspace_name,contigset_id) returns (CountContigsResults) authentication required;

	/*
	annotate genome
	contigset_id - the ContigSet to count.
	*/
	funcdef annotate_genome(UnspecifiedObject params) returns (AnnotateGenomeResults) authentication required;
};
