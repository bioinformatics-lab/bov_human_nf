// nextflow.enable.dsl = 2

// process CARNEIRO {
//     tag "${genomeId}"
//     errorStrategy "ignore"
//     cpus 1
//     publishDir params.resultsDir, mode: 'move'

//     input:
//     val(genomeId)

//     output:
//     path("*fa")

//     script:
//     """
//     ncbi-acc-download --format fasta ${genomeId}

//     """
// }

// workflow DOWNLOAD_CARNEIRO {

//     sra_ch = Channel.of(ids)

//     CARNEIRO(sra_ch.flatten())

// }


/*
================================
params
================================
*/

params.resultsDir = 'results/rawGenomes'
params.apiKey = "FIXME"

/*
================================
ids of genomes to be downloaded
================================
*/

ids = [
            'SRR13046668',
            'SRR13046669',
            'SRR13046670',
            'SRR13046671',
            'SRR13046672',
            'SRR13046673',
            'SRR13046674',
            'SRR13046675',
            'SRR13046676',
            'SRR13046677',
            'SRR13046678',
            'SRR13046679',
            'SRR13046680',
            'SRR13046681',
            'SRR13046682',
            'SRR13046683',
            'SRR13046684',
            'SRR13046685',
            'SRR13046686',
            'SRR13046687',
            'SRR13046688',
            'SRR13046689'
    ]



/*
================================
only for publishing these files to results folder
================================
*/


process downloadRawGenomes {
    tag "${genomeName}"
    publishDir params.resultsDir, mode: 'copy'

    input:
    tuple val(genomeName), file(genomeReads) from Channel.fromSRA(ids, cache: true, apiKey: params.apiKey)

    script:

    """
    echo ${genomeName}
    echo ${genomeReads[0]}
    echo ${genomeReads[1]}
    """

    //mkdir -p ../../../$params.resultsDir
    //cp \$(readlink -f ${genomeReads[0]}) ../../../$params.resultsDir/
    //cp \$(readlink -f ${genomeReads[1]}) ../../../$params.resultsDir/


}
