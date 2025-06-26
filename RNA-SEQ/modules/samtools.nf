nextflow.enable.dsl=2

process SAM2BAM {
    tag "$sample_id"
    publishDir "${params.outdir}/bam", mode: 'copy'

    input:
    tuple val(sample_id), path(samfile)

    output:
    path("${sample_id}_sorted.bam")

    script:
    """
    samtools sort -@ ${params.threads} -o ${sample_id}_sorted.bam ${samfile}
    """
}

