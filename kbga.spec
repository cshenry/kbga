/*
The SDK version of the KBaase Genome Annotation Service.
This wraps genome_annotation which is based off of the SEED annotations.
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
	    workspace_name workspace;
	    string id;
	} AnnotateGenomeResults;
	
	/*
	annotate genome
	params - a param hash that includes the workspace id and options
	*/
	funcdef annotate_genome(UnspecifiedObject params) returns (AnnotateGenomeResults) authentication required;
};
