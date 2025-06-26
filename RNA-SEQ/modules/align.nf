nextflow.enable.dsl=2

process ALIGN {
    tag "$sample_id"
    publishDir "${params.outdir}/alignment", mode: 'copy'

    input:
    tuple val(sample_id), path(read1), path(read2)

    output:
    tuple val(sample_id), path("${sample_id}.sam")

    script:
    """
    hisat2 -p ${params.threads} \\
        -x ${params.hisat2idx} \\
        -1 ${read1} -2 ${read2} \\
        -S ${sample_id}.sam
    """
}

