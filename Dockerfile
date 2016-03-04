FROM kbase/kbase:sdkbase.latest
MAINTAINER KBase Developer
# -----------------------------------------

# Insert apt-get instructions here to install
# any required dependencies for your module.

# RUN apt-get update
RUN cpanm -i Config::IniFiles

RUN git clone https://github.com/kbase/genome_annotation && \
   cp -a genome_annotation/lib/Bio lib/

# Build kb_seed
RUN cd /kb/dev_container/modules && \
    rm -rf kb_seed strep_repeats kmer_annotation_figfam && \
    git clone https://github.com/kbase/kb_seed && \
    git clone https://github.com/kbase/strep_repeats && \
    git clone https://github.com/kbase/kmer_annotation_figfam && \
    . /kb/dev_container/user-env.sh && \
    cd kb_seed && make && make deploy 

RUN \
    cd /kb/bootstrap/kb_search_for_rnas && \
    ./build.search_for_rnas /kb/runtime/ && \
    cd /kb/bootstrap/kb_glimmer && \
    ./build.glimmer /kb/runtime/ && \
    cd /kb/bootstrap/kb_elph && \
    ./build.elph /kb/runtime/

RUN sed -i 's/capture_stderr/tee_stderr/' /kb/deployment/lib/Bio/KBase/GenomeAnnotation/GenomeAnnotationImpl.pm

RUN mkdir /data && \
    mkdir /data/Data.may1 && \
    mkdir /data/kmer
                                                           
# -----------------------------------------

COPY ./ /kb/module
RUN mkdir -p /kb/module/work

WORKDIR /kb/module

RUN make

ENTRYPOINT [ "./scripts/entrypoint.sh" ]

CMD [ ]
