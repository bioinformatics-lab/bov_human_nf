nextflow.enable.dsl = 2

params.resultsDir = "${params.outdir}/fastqc"
params.saveMode = 'copy'
params.shouldPublish = true

process FASTQC {
    tag "${genomeName}"
    publishDir params.resultsDir, mode: params.saveMode, enabled: params.shouldPublish

    input:
    tuple val(genomeName), path(genomeReads)

    output:
    tuple path('*.html'), path('*.zip')


    script:

    """
    fastqc *fastq*
    """

    stub:

    """
    echo fastqc *fastq*

    mkdir ${genomeName}
    touch ${genomeName}/${genomeName}.html
    touch ${genomeName}/${genomeName}.zip
    """
}




